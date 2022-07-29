//
//  LocationViewController.swift
//  SeSacNetworkBasic
//
//  Created by 이승후 on 2022/07/29.
//

import UIKit

class LocationViewController: UIViewController {
    
    // Notification 1.
    let notificationCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestAuthorization()
        
        for family in UIFont.familyNames {
            print("=============\(family)============")
            for name in UIFont.fontNames(forFamilyName: family) {
                print(name)
            }
        }
    }
    
    @IBAction func notificationButtonClicked(_ sender: UIButton) {
//        sendNotification()
    }
    
    //Notification 2. 권한 요청
    func requestAuthorization() {
        let authorizationOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        notificationCenter.requestAuthorization(options: authorizationOptions) { success, error in
            if success {
//                self.sendNotification()
            }
        }
    }
    //Notofication 3. 권한을 허용한 사용자에게 알림 요청(언제? 어떤 콘텐츠?)
    //iOS 시스템에서 알림을 담당 > 알림 등록하는 코드가 필요함
    
    /*
     - 권한 허용해야하만 알림이 온다.
     - 권한 허용 문구 시스템적으로 최초 한번만 뜬다.
     - 허용 안 된 경우 애플 설정으로 직접 유도하는 코드를 구성해야 한다.
     - 기본벅으로 알림은 포그라운드에서 수신되지 않는다.
     - 로컬 알림에서 60초 이상 반복 가능 / 갯수 제한 64개 / 커스텀 사운드 30초
     */
    
    // 1. 뱃지 제거? - 언제 제거하는게 맞을까?
    // 2. 노티 제거? - 노티의 유효 기간은?
    // 3. 포그라운드 수신? > delegate 메서드로 해결!
    
    // - 노티드 앱 실행이 기본인데, 특정 노티를 클릭할 때 특정화면으로 가고 싶다면?
    // - 포그라운드 수신, 특정 화면에서는 안받고 특정 조건에 대해서만 포그라운드 수신을 하고 싶다면?
    // - ios15 집중모드 등 5~6 우선순위 존재!
    
//    func sendNotification() {
//       let notificationContent = UNMutableNotificationContent()
//        notificationContent.title = "다마고치를 키워보세요"
//        notificationContent.subtitle = "오늘의 행운 숫자는 \(Int.random(in: 1...100))입니다."
//        notificationContent.body = "저는 따끔따끔 다마고치입니당. 배고파요"
//        notificationContent.badge = 40
//
////        var datacomponent = DateComponents()
////        datacomponent.minute = 15
//
//        //언제 보낼것이낙? 1. 시간 간격 2. 캘린더 3. 위치에 따라 설정 가능.
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)
////        let trigger = UNCalendarNotificationTrigger(dateMatching: datacomponent, repeats: true)
//        // 알림 요청
//        // identifier: 만약 알림 관리 할 필요 X -> 알림 클릭하면 앱을 켜줌
//        // 만약 알림 관리 할 필요 O -> +1, 고유한 이름, 규칙
//        let request = UNNotificationRequest(identifier: "\(Date())" , content: notificationContent , trigger: trigger)
//        notificationCenter.add(request)
//    }
}
