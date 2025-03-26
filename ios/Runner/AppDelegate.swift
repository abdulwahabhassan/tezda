import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
     let controller = window?.rootViewController as! FlutterViewController
            let deviceInfoChannel = FlutterMethodChannel(name: "device_info",
                                                         binaryMessenger: controller.binaryMessenger)

            deviceInfoChannel.setMethodCallHandler { (call, result) in
                if call.method == "getDeviceInfo" {
                    let device = UIDevice.current
                    let deviceInfo: [String: String] = [
                        "model": device.model,
                        "systemVersion": device.systemVersion,
                        "name": device.name
                    ]
                    result(deviceInfo)
                } else {
                    result(FlutterMethodNotImplemented)
                }
            }
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
