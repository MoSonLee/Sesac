//
//  RealmViewController.swift
//  Diary
//
//  Created by 이승후 on 2022/08/24.
//

import UIKit

import SnapKit
import RealmSwift
import Zip

final class RealmViewController: UIViewController {
    
    let localRealm = try! Realm()
    var tasks: Results<UserDiary>!
    var removeId: ObjectId?
    lazy var repository = USerDiaryRepository()
    
    lazy var taskArray = Array(tasks)
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchRealm()
        tableView.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setConfigure()
        setNavigationItems()
    }
    
    private func setConfigure() {
        view.backgroundColor = .white
        setTableView()
    }
    
    private func setNavigationItems() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
        let backUpButton = UIBarButtonItem(title: "백업", style: .plain, target: self, action: #selector(backupButtonClicked))
        let reStoreButton = UIBarButtonItem(title: "복구", style: .plain, target: self, action: #selector(restoreButtonClicked))
        self.navigationItem.rightBarButtonItems = [backUpButton, reStoreButton]
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        backUpButton.tintColor = .black
        reStoreButton.tintColor = .black
    }
    
    private func fetchRealm() {
        tasks = repository.fetch()
        tableView.reloadData()
    }
    
    private func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(RealmTableViewCell.self, forCellReuseIdentifier: RealmTableViewCell.identifier)
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func showActivityViewController() {
        
        guard let path = documentDirectoryPath() else {
            showAlert(title: "도큐먼트 위치에 오류가 있씁니다.")
            return
        }
        
        let backUpFileURL = path.appendingPathComponent("SeSacDiary_1.zip")
        
        let vc = UIActivityViewController(activityItems: [backUpFileURL], applicationActivities: [])
        self.present(vc, animated: true)
    }
    
    @objc func backupButtonClicked() {
        
        var urlPaths = [URL]()
        
        //도큐먼트 위치에 백업 파일 확인
        guard let path = documentDirectoryPath() else {
            showAlert(title: "도큐먼트 위치에 오류가 있씁니다.")
            return
        }
        let realmFile = path.appendingPathComponent("default.realm")
        
        guard FileManager.default.fileExists(atPath: realmFile.path) else {
            showAlert(title: "벡압힐 파일이 없습니다")
            return
        }
        
        urlPaths.append(URL(string: realmFile.path)!)
        
        //백업 파일을 압축
        
        do {
            let zipFilePath = try Zip.quickZipFiles(urlPaths, fileName: "SeSacDiary_1")
            showActivityViewController()
            print("Archive Location: \(zipFilePath)")
        } catch {
            showAlert(title: "압축을 실패했습니다.")
        }
    }
    
    @objc func restoreButtonClicked() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy:  true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true)
        
    }
    
    @objc private func backButtonTapped() {
        self.dismiss(animated: true)
    }
}

extension RealmViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RealmTableViewCell.identifier) as? RealmTableViewCell else { return UITableViewCell()}
        
        cell.titleLabel.text = taskArray[indexPath.row].diaryTitle
        cell.descriptionLabel.text = taskArray[indexPath.row].diaryContent
        cell.realmImage.image = loadImageFromDocument(fileName: "\(taskArray[indexPath.row].objectId)")
        removeId = taskArray[indexPath.row].objectId
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let task = self.taskArray[indexPath.row]
        if editingStyle == .delete {
            taskArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            removeImageFormDocument(fileName: "\(task.objectId)")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150
    }
}

extension RealmViewController: UIDocumentPickerDelegate{
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print(#function)
    }
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        guard let selectedFileURL = urls.first else {
            showAlert(title: "선택하신 파일을 찾을 수 없습니다.")
            return
        }
        
        guard let path = documentDirectoryPath() else {
            showAlert(title: "도큐먼트 위치에 오류가 있습니다.")
            return
        }
        
        let sandboxFileURL = path.appendingPathComponent(selectedFileURL.lastPathComponent)
        
        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
            let fileURL = path.appendingPathComponent("SeSacDiary_1.zip")
            
            do {
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print(unzippedFile)
                    self.showAlert(title: "복구가 완료되었습니다.")
                })
            } catch {
                showAlert(title: "압축 해제에 실패")
            }
        } else {
            do {
                //파일 앱의 zip -> 도큐먼트 폴더에 복사
                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
                let fileURL = path.appendingPathComponent("SeSacDiary_1.zip")
                
                try Zip.unzipFile(fileURL, destination: path, overwrite: true, password: nil, progress: { progress in
                    print("progress \(progress)")
                }, fileOutputHandler: { unzippedFile in
                    print(unzippedFile)
                    self.showAlert(title: "복구가 완료되었습니다.")
                })
                
            } catch {
                showAlert(title: "압축 해제에 실패했습니다.")
            }
        }
    }
}
