//
//  MapPracticeViewController.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/12.
//

import UIKit
import MapKit

class MapPracticeViewController: UIViewController {
    
    @IBOutlet weak var mapKitView: MKMapView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        checkUserDeviceLocationServiceAuthorization()
        let center = CLLocationCoordinate2D(latitude: 37.546632, longitude: 126.949819)
        setRegionAndAnnotation(center: center)
    }
    
    private func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 37.546632, longitudinalMeters: 126.949819)
        mapKitView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "Center!"
        mapKitView.addAnnotation(annotation)
    }
    
    private func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}

extension MapPracticeViewController {
    private func checkUserDeviceLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            showRequestLocationServiceAlert()
            print("위치 서비스가 꺼져 있어서 위치 권한 요청을 할 수 없습니다.")
        }
    }
    
    private func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOTDETERMINED")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted, .denied:
            print("DENIED, 아이폰 설정으로 유도")
            showRequestLocationServiceAlert()
            
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            locationManager.startUpdatingLocation()
            
        default: print("DEFAULT")
        }
    }
}

extension MapPracticeViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAuthorization()
    }
}
