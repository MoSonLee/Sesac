//
//  MapViewController.swift
//  SeSacTMDBProject
//
//  Created by 이승후 on 2022/08/11.
//

import UIKit
import MapKit
//Location 1. import
import CoreLocation

import Kingfisher
/*
 MapVIew
 - 지도와 위치 권한은 상관X
 - 만약 지도에 현재 위치 등을 표현하고 싶다면 위치 권한을 등록해주어야 함
 - 중심 범위 지정
 - 핀(어노테이션)
 */
final class MapViewController: UIViewController {
    
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var moveToWeatherButton: UIButton!
    
    var weatherImageData: String = ""
    var locationNameData: String = ""
    var tempData: Double = 0.0
    var windSpeedData: Double = 0.0
    var humidityData: Int = 0
    var longtitude: Double = 0.0
    var latitude: Double = 0.0
    
    //Location2. 위치에 대한 대부분을 담당
    private lazy var locationManager = CLLocationManager()
    private lazy var annotation = MKPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Location3. 프로토콜 연결
        locationManager.delegate = self
        setViewAndData()
    }
    
    private func setRegionAndAnnotation(center: CLLocationCoordinate2D) {
        // 지도 중심 설정: 애플맵 활용하여 좌표 복사
        //지도 중심 기반으로 보여질 범위 설정
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
        annotation.coordinate = center
        annotation.title = "이곳이 나의 캠퍼스다!"
        //지도에 핀 추가
        mapView.addAnnotation(annotation)
    }
    
    private func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            //설정까지 이동하거나 설정 세부화면까지 이동하거나
            //한번도 설정 앱에 들어가지 않았거나, 막 다운받은 앱이거나
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
    
    private func setWeatherData(ceneterData: CLLocationCoordinate2D) {
        APIManager.shared.requestWeather(latitude: ceneterData.latitude, longtitude: ceneterData.longitude) { weatherImage, locationName, temp, windSpeed, longtitude, latitude, humidity in
            self.weatherImageData = weatherImage
            self.locationNameData = locationName
            self.tempData = temp
            self.windSpeedData = windSpeed
            self.humidityData = humidity
            self.longtitude = longtitude
            self.latitude = latitude
        }
    }
    
    private func setViewAndData() {
        checkUserDeviceLocationServiceAuthorization()
        let center = CLLocationCoordinate2D(latitude: 37.546632, longitude: 126.949819)
        setRegionAndAnnotation(center: center)
        setWeatherData(ceneterData: center)
        moveToWeatherButton.setTitle("날짜 정보 보러가기", for: .normal)
        moveToWeatherButton.tintColor = .black
        moveToWeatherButton.backgroundColor = .systemCyan
    }
    
    @IBAction private func moveToWeatherButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Sesac6Assignment", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController else { return }
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .automatic
        vc.windSpeed = windSpeedData
        vc.temp = tempData
        vc.locationNameString = locationNameData
        vc.weatherImageString = weatherImageData
        vc.humidity = humidityData
        self.present(nav, animated: true)
    }
    
    @IBAction private func mapTapped(_ sender: UITapGestureRecognizer) {
        if sender.state != UIGestureRecognizer.State.ended {
            return
        }
        if sender.state != UIGestureRecognizer.State.began {
            print("location Changed")
            let touchLocation = sender.location(in: mapView)
            let locationCoordinate = mapView.convert(touchLocation,toCoordinateFrom: mapView)
            let center = CLLocationCoordinate2D(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
            setRegionAndAnnotation(center: center )
            return
        }
    }
}

//위치 관련된 User Defind 메서드
extension MapViewController {
    //Location7. iOS 버전에 따른 분기 처리 및 iOS 위치 서비스 활성화 여부 확인
    //위치 서비스가 켜져 있다면 권한을 요청하고, 까져 있다면 커스텀 얼럿으로 상황 알려주기
    //CLAuthrizationStatus
    //- denied: 허용 안 함 / 설정에서 추후에 거부 / 위치 서비스 중지 /비행기 모드
    //- restricted: 앱 권한 자체가 없는 경우/ 자녀 보호 기능 같은걸로 아예 제한
    func checkUserDeviceLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        //프로퍼티를 통해 locationManager가 가지고 있는 상태를 가져옴
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        //iOS 위치 서비스 활성화 여부 체크
        if CLLocationManager.locationServicesEnabled() {
            //위치 서비스가 활성화 되어 있으므로, 위치 권한 요청 가능해서 위치 권한을 요청함
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            showRequestLocationServiceAlert()
            print("위치 서비스가 꺼져 있어서 위치 권한 요청을 할 수 없습니다.")
        }
    }
    //Location8. 사용자의 위치 권한 상태 확인
    //사용자가 위치를 허용했는 지, 거부했는 지, 아직 선택하지 않았는 지 등을 확인(단, 사전에 iOS 위치 서비스 활성화 꼭 확인)
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOTDETERMINED")
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() //앱을 사용하는 동안에 대한 위치 권한 요청
            //Plist whenInUse -> request 메서드 OK
        case .restricted, .denied:
            print("DENIED, 아이폰 설정으로 유도")
            showRequestLocationServiceAlert()
        case .authorizedWhenInUse:
            print("WHEN IN USE")
            // 사용자가 위치를 허용해둔 상태라면, startUpdatingLocation을 통해 didUpdateLocations 메서드가 실행
            locationManager.startUpdatingLocation()
        default: print("DEFAULT")
        }
    }
}

//Locatioon4. 프로토콜 선언
extension MapViewController: CLLocationManagerDelegate {
    //Location5. 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
        //ex. 위도 경도 기반으로 날씨 정보를 좋회
        //ex. 지도를 다시 세팅
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate)
        }
        //위치 업데이트 멈춰!
        locationManager.stopUpdatingLocation()
    }
    //Location6. 사용자의 위치를 못 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    //Location9. 사용자의 권한 상태가 바뀔 때를 알려줌
    //거부했다가 설정에서 변경했거나, 혹은 notDetermined에서 허용을 했거나 등
    //허용했어서 위치를 가지고 오는 중에 설정에서 거부하고 돌아온다면??
    //iOS 14 이상: 사용자의 권한 상태가 변경이 될 때, 위치 관리자 생성할 때 호출됨
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserDeviceLocationServiceAuthorization()
    }
    //iOS 14미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    }
}

extension MapViewController: MKMapViewDelegate {
    //지도에 커스텀 핀 추가
    //    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    //        <#code#>
    //    }
    
    //    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
    //        <#code#>
    //    }
}
