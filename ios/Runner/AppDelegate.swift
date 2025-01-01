import Flutter
import GoogleMaps
import UIKit
import CoreLocation

@main
@objc class AppDelegate: FlutterAppDelegate, CLLocationManagerDelegate {
    var locationManager: CLLocationManager? // Sınıf seviyesi özellik
    var eventSink: FlutterEventSink? // Flutter'a veri göndermek için kullanılan özellik
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GMSServices.provideAPIKey("AIzaSyB4pl8pybeo6FV8dBbLp0N4fuebb5ERYNk")
        
        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        
        let locationChannel = FlutterMethodChannel(
            name: "com.gokalpyildiz.marti_location_tracking",
            binaryMessenger: controller.binaryMessenger
        )
        
        locationChannel.setMethodCallHandler { [weak self] (call, result) in
            guard let self = self else { return }
            
            if call.method == "startBackground" {
                self.setupLocationManager()
                result("Konum takibi başlatıldı.")
            }else if call.method == "stopBackground" {
                self.stopLocationUpdates()
                result("Konum takibi durduruldu.")
            } 
            
            else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        // EventChannel: Konum değişikliklerini dinlemek için
        let locationEventChannel = FlutterEventChannel(
            name: "com.gokalpyildiz.marti_location_updates",
            binaryMessenger: controller.binaryMessenger
        )
        
        locationEventChannel.setStreamHandler(self)
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    // Konum yöneticisini başlatma
    func setupLocationManager() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.distanceFilter = 10 
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.pausesLocationUpdatesAutomatically = false
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation() 
    }
    
    // Delegate: Konum güncellemeleri
 func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    print("Konum Güncellendi: \(location.coordinate.latitude), \(location.coordinate.longitude)")
    
    // eventSink'in mevcut olup olmadığını kontrol et
    if let eventSink = eventSink {
        let locationData: [String: Double] = [
            "latitude": location.coordinate.latitude,
            "longitude": location.coordinate.longitude
        ]
        eventSink(locationData) // Konum bilgilerini Flutter'a gönder
    } else {
        print("Flutter eventSink mevcut değil")
    }
}
    

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
      func stopLocationUpdates() {
        locationManager?.stopUpdatingLocation()
        locationManager?.stopMonitoringSignificantLocationChanges()
        eventSink = nil // Flutter ile bağlantıyı kes
    }
}


extension AppDelegate: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        eventSink = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        eventSink = nil
        return nil
    }
}
