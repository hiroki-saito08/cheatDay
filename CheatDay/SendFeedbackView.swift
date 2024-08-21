import SwiftUI
import MessageUI

struct SendFeedbackView: View {
    @State private var subject: String = ""
    @State private var feedback: String = ""
    @State private var isShowingMailView = false
    @State private var alertMessage = ""
    @State private var isShowingAlert = false
    
    var body: some View {
        Form {
            Section(header: Text("フィードバックの件名")) {
                TextField("件名を入力してください", text: $subject)
                    .autocapitalization(.sentences)
                    .disableAutocorrection(true)
            }
            
            Section(header: Text("フィードバック内容")) {
                TextEditor(text: $feedback)
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
                MailView(result: .constant(nil), subject: subject, body: feedback, recipient: "hirokisaito08job@gmail.com")
            }
        }
        .navigationBarTitle("フィードバックを送る", displayMode: .inline)
        .alert(isPresented: $isShowingAlert) {
            Alert(title: Text("エラー"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    func validateForm() -> Bool {
        if subject.isEmpty || feedback.isEmpty {
            alertMessage = "件名とフィードバック内容を入力してください。"
            isShowingAlert = true
            return false
        }
        return true
    }
    
    func canSendMail() -> Bool {
        MFMailComposeViewController.canSendMail()
    }
}
