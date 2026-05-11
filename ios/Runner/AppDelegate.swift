import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if let controller = window?.rootViewController as? FlutterViewController {
      let channel = FlutterMethodChannel(
        name: "trading_signal_app/device_info",
        binaryMessenger: controller.binaryMessenger
      )

      channel.setMethodCallHandler { call, result in
        guard call.method == "getDeviceInfo" else {
          result(FlutterMethodNotImplemented)
          return
        }

        let device = UIDevice.current
        let deviceName = [device.name, device.model]
          .filter { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }
          .joined(separator: " ")
        let vendorId = device.identifierForVendor?.uuidString

        result([
          "device_name": deviceName.isEmpty ? "iPhone" : deviceName,
          "device_type": "ios",
          "device_id": vendorId ?? device.model
        ])
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
