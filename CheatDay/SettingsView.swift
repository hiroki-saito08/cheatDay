import SwiftUI

struct SettingsView: View {
    @State private var notificationsEnabled: Bool = UserDefaults.standard.bool(forKey: "notificationsEnabled")
    
    var body: some View {
        NavigationView {
            Form {
                // 1. Notification Settings
                Section(header: Text("通知設定")) {
                    Toggle("通知を有効にする", isOn: $notificationsEnabled)
                        .onChange(of: notificationsEnabled) { value in
                            UserDefaults.standard.set(value, forKey: "notificationsEnabled")
                            if value {
                                requestNotificationPermission()
                            } else {
                                disableNotifications()
                            }
                        }
                }
                
                // Help & Support
                Section(header: Text("ヘルプとサポート")) {
                    NavigationLink(destination: FAQView()) {
                        Text("よくある質問")
                    }
                    Link("お問い合わせ", destination: URL(string: "https://hiroki-saito.com/cheatday-support-page")!)
                    HStack {
                        Text("アプリバージョン")
                        Spacer()
                        Text("1.0.0")
                    }
                }
                
                // Legal Information
                Section(header: Text("法的情報")) {
                    Link("プライバシーポリシー", destination: URL(string: "https://hiroki-saito.com/cheatday-privacy-policy")!)
                    NavigationLink(destination: TermsOfServiceView()) {
                        Text("利用規約")
                    }
                    NavigationLink(destination: OpenSourceLicensesView()) {
                        Text("オープンソースライセンス")
                    }
                }
                // Feedback
                Section(header: Text("フィードバック")) {
                    Button(action: {
                        // Replace with actual link to the App Store page for your app
                        if let url = URL(string: "https://www.apple.com/jp/app-store/") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Text("アプリを評価する")
                    }
                }
                
                // 11. Copyright Information
                Section(header: Text("著作権情報")) {
                    Text("アイコン提供: Flaticon")
                    Link("Flaticonのウェブサイト", destination: URL(string: "https://www.flaticon.com")!)
                    Text("アプリ開発者: Hiroki Saito") // Replace with your company or name
                    Text("© 2024 Hiroki Saito. All rights reserved.") // Replace with appropriate copyright info
                }
            }
            .navigationBarTitle("設定", displayMode: .inline)
        }
    }
    
//    func clearCache() {
//        // Implement cache clearing logic here
//        print("Cache cleared")
//        // You can show a confirmation dialog or toast message if needed
//    }
    
    // 通知許可をリクエスト
    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("通知が許可されました")
                scheduleNotifications() // 許可されたら通知をスケジュール
            } else {
                print("通知が拒否されました")
            }
        }
    }
    
    // スケジュールされた通知を無効化
    func disableNotifications() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
        print("通知が無効化されました")
    }

    // 通知をスケジュール（詳細は後で実装）
    func scheduleNotifications() {
        print("通知がスケジュールされました")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
