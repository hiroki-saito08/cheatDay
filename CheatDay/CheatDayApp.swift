import SwiftUI
import GoogleMobileAds // Google AdMob SDK

@main
struct CheatDayApp: App {
    // AppDelegateをSwiftUIアプリに統合
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var goalData = GoalData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(goalData)
                .font(.custom("Yomogi-Regular", size: 20)) // グローバルにフォントを適用
        }
    }
}
