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

class CammeraViewController: UIViewController {
    
    @IBOutlet weak var ypImagePickerButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var photoLibraryButton: UIButton!
    @IBOutlet weak var resultImageView: UIImageView!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ypImagePickerButton.setTitle("IMAGE PICKER", for: .application)
        cameraButton.setTitle("Camera", for: .normal)
        photoLibraryButton.setTitle("Photo", for: .normal)
        
        picker.delegate = self
    }
    
    @IBAction func ypImageButtonClicked(_ sender: UIButton) {
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
    
    @IBAction func cameraButtonClicked(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("사용불가 + 알럿")
            return
        }
        picker.sourceType = .camera
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @IBAction func photoLibraryButtonClicked(_ sender: UIButton) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("사용불가 + 알럿")
            return
        }
        picker.sourceType = .camera
        picker.allowsEditing = false
        present(picker, animated: true)
    }
    
    @IBAction func saveToPhotoLibrary(_ sender: UIButton) {
        
        if let image = resultImageView.image {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
    //이미지뷰 이미지 > 네이버 > 얼굴분석 해줘 요청 > 응다ㅣㅂ
    //문자열이 아닌 파일, 이미지, pdf 파일 자체가 그대로 전송 되지 않음. -> 텍스트 형태로 인코딩
    //어떤 파일의 종류가 명시되는지 -> Content Type
    @IBAction func clovaFaceButtonClicked(_ sender: UIButton) {
        let url = "https://openapi.naver.com/v1/vision/celebrity"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "tSUzT1r164LmbgFXn59B",
            "X-Naver-Client-Secret": "rtxl2UV_IV",
//            "Content-Type": "multipart/form-data"
        ]
        
        //UIImage를 텍스트 형태(바이너리 타입)로 변환해서 전달
        guard let imageData = resultImageView.image?.jpegData(compressionQuality: 0.4) else {
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data("one".utf8), withName: "image")
        }, to: url, headers: header).validate(statusCode: 200...500).responseData { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
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
