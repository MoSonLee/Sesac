//
//  CammeraViewController.swift
//  SeSacWekk6
//
//  Created by 이승후 on 2022/08/12.
//

import UIKit

import YPImagePicker
import Alamofire
import SwiftyJSON

import Toast

final class CammeraViewController: UIViewController {
    
    @IBOutlet private weak var ypImagePickerButton: UIButton!
    @IBOutlet private weak var cameraButton: UIButton!
    @IBOutlet private weak var photoLibraryButton: UIButton!
    @IBOutlet private weak var resultImageView: UIImageView!
    @IBOutlet weak var saveToGalleryButton: UIButton!
    @IBOutlet weak var cloverFaceButton: UIButton!
    
    private let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saveToGalleryButton.setTitle("갤러리에 저장", for: .normal)
        cloverFaceButton.setTitle("닮은 연예인 찾기", for: .normal)
        ypImagePickerButton.setTitle("IMAGE PICKER", for: .application)
        cameraButton.setTitle("Camera", for: .normal)
        photoLibraryButton.setTitle("Photo", for: .normal)
        picker.delegate = self
    }
    
    @IBAction private func ypImageButtonClicked(_ sender: UIButton) {
        let picker = YPImagePicker()
        picker.didFinishPicking { [unowned picker] items, _ in
            if let photo = items.singlePhoto {
                print(photo.fromCamera)
                print(photo.image)
                print(photo.originalImage)
                //                print(photo.modifiedImage)
                //                print(photo.exifMeta)
                self.resultImageView.image = photo.image
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction private func cameraButtonClicked(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("사용불가 + 알럿")
            return
        }
        picker.sourceType = .camera
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @IBAction private func photoLibraryButtonClicked(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("사용불가 + 알럿")
            return
        }
        picker.sourceType = .camera
        picker.allowsEditing = false
        present(picker, animated: true)
    }
    
    @IBAction private func saveToPhotoLibrary(_ sender: UIButton) {
        if let image = resultImageView.image {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            self.view.makeToast("사진 저장이 완료되었습니다!")
        }
    }
    //이미지뷰 이미지 > 네이버 > 얼굴분석 해줘 요청 > 응답
    //문자열이 아닌 파일, 이미지, pdf 파일 자체가 그대로 전송 되지 않음. -> 텍스트 형태로 인코딩
    //어떤 파일의 종류가 명시되는지 -> Content Type
    @IBAction private func clovaFaceButtonClicked(_ sender: UIButton) {
        let url = APIKey.naverCelebrityURL
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": APIKey.naverClientId,
            "X-Naver-Client-Secret": APIKey.naverSecretId,
//            "Content-Type": "multipart/form-data"
        ]
        //UIImage를 텍스트 형태(바이너리 타입)로 변환해서 전달
        let imageData = resultImageView.image?.jpegData(compressionQuality: 0.4)
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(imageData!, withName: "image")
        }, to: url, headers: header).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let celebrity = json["faces"][0]["celebrity"]["value"]
                self.view.makeToast("나와 닮은 연예인은\(celebrity)입니다.")
                print(json)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension CammeraViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    //사진을 선택하거나 카메라 촬영 직푸
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(#function)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.resultImageView.image = image
            dismiss(animated: true)
        }
    }
    //취소 버튼 클릭시
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print(#function)
        dismiss(animated: true)
    }
}
