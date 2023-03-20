import UIKit
import ScreenshotPreventing
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        if let controller = window?.rootViewController as? FlutterViewController {
            if let contentView = controller.view {
                let screenshotPreventingView = ScreenshotPreventingView()
                screenshotPreventingView.setup(contentView: contentView)
                screenshotPreventingView.preventScreenCapture = false
                controller.view = screenshotPreventingView
            }
            
            let methodChannel = FlutterMethodChannel(name: "io.alexmelnyk.utils", binaryMessenger: controller.binaryMessenger)
            methodChannel.setMethodCallHandler(methodHandler)
        }

        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func methodHandler(call: FlutterMethodCall, result: FlutterResult ) {
        switch call.method {
        case "preventScreenCapture":
            guard let args = call.arguments as? Dictionary<String, Any>,
                  let enable = args["enable"] as? Bool else {
                result(FlutterError(code: "-14", message: "Missing parameters", details: "Missing parameter 'enable'"))
                return
            }
            
            let controller = window!.rootViewController as! FlutterViewController
            let contentView = controller.view as! ScreenshotPreventingView
            contentView.preventScreenCapture = enable
            
            result(nil)
            break;
        default:
            result(FlutterMethodNotImplemented)
            break;
        }
    }
}
