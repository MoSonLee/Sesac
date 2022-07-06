//
//  AppDelegate.swift
//  LedBoard
//
//  Created by 이승후 on 2022/07/06.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        sleep(2)
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // youtube - 만약 사용자가 프리미엄이면 Play, else -> 정지
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // youtube - 프리미엄 아닌 사람들에게 팝업창을 띄우주기!
        //금융, Kakaotalk
    }
    
    // MARK: UISceneSession Lifecycle
    @available ( iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available ( iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func app() {
        if #unavailable(iOS 13) {
            // iOS 13 이하는 여기
        }
    }
    
}

