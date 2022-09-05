//
//  GCDViewController.swift
//  Sesac2Week9
//
//  Created by 이승후 on 2022/09/02.
//

import UIKit

class GCDViewController: UIViewController {
    
    let url1 = URL(string: "https://apod.nasa.gov/apod/image/2201/OrionStarFree3_Harbison_5000.jpg")!
    let url2 = URL(string: "https://apod.nasa.gov/apod/image/2112/M3Leonard_Bartlett_3843.jpg")!
    let url3 = URL(string: "https://apod.nasa.gov/apod/image/2112/LeonardMeteor_Poole_2250.jpg")!
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var thirdImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func trending() {
        
    }
    
    func genre() {
        
    }
    
    @IBAction func serialSync(_ sender: UIButton) {
        
        print("START", terminator: " ")
        
        for i in 1...100 {
            print(i, terminator: " ")
        }
        
        DispatchQueue.main.sync { //왜 문제가 생기는지 + 사용하지 않음
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        print("END", terminator: " ")
    }
    
    @IBAction func serialAsync(_ sender: UIButton) {
        print("START", terminator: " ")
        
        DispatchQueue.main.async { //일단 큐(매니저에) 보내고 바로 다른 작업을 시작함
            // 네트워크에서 주로 사용
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 1...100 {
            DispatchQueue.main.async {
                print(i, terminator: " ")
            }
        }
        
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        
        print("END", terminator: " ")
        
    }
    
    @IBAction func globalSync(_ sender: UIButton) {
        
        print("START", terminator: " ")
        
        DispatchQueue.global().sync { //메인 쓰레드에서 작업하는 것과 똑같음 + 사용하지 않음
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END", terminator: " ")
    }
    
    @IBAction func globalAsync(_ sender: UIButton) {
        print("START \(Thread.isMainThread)", terminator: " ")
        
        //        DispatchQueue.global().async {
        //            for i in 1...100 {
        //                print(i, terminator: " ")
        //            }
        //        }
        
        for i in 1...100 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("END \(Thread.isMainThread)")
    }
    
    @IBAction func GCDQos(_ sender: UIButton) {
        
        let customQueue = DispatchQueue(label: "concurrentSeSAC", qos: .userInteractive, attributes: .concurrent)
        customQueue.async {
            print("START")
        }
        //우선순위 userineractive -> background
        
        for i in 1...100 {
            DispatchQueue.global(qos: .background).async {
                
                print(i, terminator: " ")
            }
        }
        for i in 101...201 {
            DispatchQueue.global(qos: .userInteractive).async {
                print(i, terminator: " ")
            }
        }
        for i in 301...401 {
            DispatchQueue.global(qos: .utility).async {
                
                print(i, terminator: " ")
            }
        }
    }
    @IBAction func dispatchGroup(_ sender: UIButton) {
        
        let group = DispatchGroup()
        
        
        DispatchQueue.global().async(group: group) {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 101...200 {
                print(i, terminator: " ")
            }
        }
        
        DispatchQueue.global().async(group: group) {
            for i in 201...300 {
                print(i, terminator: " ")
            }
        }
        group.notify(queue: .main) {
            print("끝")
            //tableview.reload
        }
    }
    
    @IBAction func dispatchGroupNasa(_ sender: UIButton) {
        
        //        request(url: url1) { image in
        //            print("1")
        //            self.request(url: self.url2) { image in
        //                print("2")
        //                self.request(url: self.url3) { image in
        //                    print("3")
        //                }
        //            }
        //        }
        
        //        let group = DispatchGroup()
        //        var imageList: [UIImage] = []
        //
        //        DispatchQueue.global().async(group: group) {
        //            self.request(url: self.url1) { image in
        //                imageList.append(image!)
        //                print("1")
        //            }
        //        }
        //
        //        DispatchQueue.global().async(group: group) {
        //            self.request(url: self.url2) { image in
        //                imageList.append(image!)
        //                print("2")
        //            }
        //        }
        //
        //        DispatchQueue.global().async(group: group) {
        //            self.request(url: self.url3) { image in
        //                imageList.append(image!)
        //                print("3")
        //            }
        //        }
        //
        //        group.notify(queue: .main) {
        //            self.firstImage.image = imageList[0]
        //            self.firstImage.image = imageList[1]
        //            self.firstImage.image = imageList[2]
        //            print("끝. 완료.")
        //        }
    }
    
    @IBAction func enterLeave(_ sender: UIButton) {
        let group = DispatchGroup()
        var imageList: [UIImage] = []
        
        group.enter()
        request(url: url1) { image in
            imageList.append(image!)
            group.leave()
        }
        
        group.enter()
        request(url: url2) { image in
            imageList.append(image!)
            group.leave()
        }
        
        group.enter()
        request(url: url3) { image in
            imageList.append(image!)
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.firstImage.image = imageList[0]
            self.secondImage.image = imageList[1]
            self.thirdImage.image = imageList[2]
            
            print("끝. 완료.")
        }
    }
    
    func request(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                completionHandler(UIImage(systemName: "star"))
                return
            }
            
            let image = UIImage(data: data)
            completionHandler(image)
            
        }.resume()
    }
    
    @IBAction func raceCondition(_ sender: UIButton) {
        let group = DispatchGroup()
        var nickname = "SeSaC"
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "고래밥"
            print("First: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "칙촉"
            print("First: \(nickname)")
        }
        
        DispatchQueue.global(qos: .userInteractive).async(group: group) {
            nickname = "올라프"
            print("First: \(nickname)")
        }
        
        group.notify(queue: .main) {
            print("result: \(nickname)")
        }
    }
}
