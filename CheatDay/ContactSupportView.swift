import SwiftUI
import MessageUI

struct ContactSupportView: View {
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var message: String = ""
    @State private var isShowingMailView = false
    @State private var alertMessage = ""
    @State private var isShowingAlert = false
    
    var body: some View {
        Form {
            Section(header: Text("お名前")) {
                TextField("お名前を入力してください", text: $name)
                    .autocapitalization(.words)
                    .disableAutocorrection(true)
            }
            
            Section(header: Text("メールアドレス")) {
                TextField("メールアドレスを入力してください", text: $email)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            
            Section(header: Text("お問い合わせ内容")) {
                TextEditor(text: $message)
                    .frame(height: 150)
            }
            
            Button(action: {
                if validateForm() {
                    isShowingMailView.toggle()
                }
            }) {
                Text("送信")
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .disabled(!canSendMail())
            .sheet(isPresented: $isShowingMailView) {
                MailView(result: .constant(nil), subject: "サポート依頼", body: buildEmailBody(), recipient: "hirokisaito08job@gmail.com")
            }
        }
        .navigationBarTitle("お問い合わせ", displayMode: .inline)
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("エラー"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func validateForm() -> Bool {
        if name.isEmpty || email.isEmpty || message.isEmpty {
            alertMessage = "すべてのフィールドに入力してください。"
            isShowingAlert = true
            return false
        }
        
        if !isValidEmail(email) {
            alertMessage = "有効なメールアドレスを入力してください。"
            isShowingAlert = true
            return false
        }
        
        return true
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: email)
    }
    
    func buildEmailBody() -> String {
        """
        お名前: \(name)
        メールアドレス: \(email)
        
        お問い合わせ内容:
        \(message)
        """
    }
    
    func canSendMail() -> Bool {
        MFMailComposeViewController.canSendMail()
    }
}
