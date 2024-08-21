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
                        }
                }
                
                // Help & Support
                Section(header: Text("ヘルプとサポート")) {
                    NavigationLink(destination: FAQView()) {
                        Text("よくある質問")
                    }
                    NavigationLink(destination: ContactSupportView()) {
                        Text("お問い合わせ")
                    }
                    HStack {
                        Text("アプリバージョン")
                        Spacer()
                        Text("1.0.0")
                    }
                }
                
                // Legal Information
                Section(header: Text("法的情報")) {
                    NavigationLink(destination: PrivacyPolicyView()) {
                        Text("プライバシーポリシー")
                    }
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
                    NavigationLink(destination: SendFeedbackView()) {
                        Text("フィードバックを送る")
                    }
                }
                
                // Storage & Data
                Section(header: Text("ストレージとデータ")) {
                    Button(action: {
                        clearCache()
                    }) {
                        Text("キャッシュをクリアする")
                    }
                    NavigationLink(destination: DataUsageView()) {
                        Text("データ使用量")
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
    func clearCache() {
        // Implement cache clearing logic here
        print("Cache cleared")
        // You can show a confirmation dialog or toast message if needed
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
