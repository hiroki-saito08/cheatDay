import UIKit
import GoogleMobileAds // Google Mobile Ads SDK

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // アプリ起動時に呼ばれる
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Google Mobile Ads SDKを初期化
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        
        return true
    }

    // MARK: UISceneSession ライフサイクル
    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // ユーザーがシーンセッションを破棄した際に呼ばれる
    }
}
