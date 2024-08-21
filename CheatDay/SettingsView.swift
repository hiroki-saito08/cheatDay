import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("通知設定")) {
                    Toggle("通知を有効にする", isOn: .constant(true))
                }
                
                Section(header: Text("著作権情報")) {
                    Text("アイコン提供: Flaticon")
                    Link("Flaticonのウェブサイト", destination: URL(string: "https://www.flaticon.com")!)
                }
            }
            .navigationBarTitle("設定", displayMode: .inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
