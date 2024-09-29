import SwiftUI
import CoreML

struct GoalFormView: View {
    @Binding var goals: [Goal]
    @Binding var editingGoal: Goal?
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String = ""
    @State private var purpose: String = ""
    @State private var reward: String = ""
    @State private var encouragement: String = ""
    @State private var cycleDays: String = ""
    
    @State private var errorMessage: String? = nil
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("目標の詳細")) {
                    TextField("タイトル", text: $title)
                    TextField("目的", text: $purpose)
                    TextField("褒美", text: $reward)
                    TextField("励ましの言葉 (オプション)", text: $encouragement)
                    TextField("サイクル日数", text: $cycleDays)
                        .keyboardType(.numberPad)
                        .onChange(of: cycleDays) { newValue in
                            // 2桁を超えないように制限
                            if newValue.count > 2 {
                                cycleDays = String(newValue.prefix(2))
                            }
                        }
                }
                
                if let errorMessage = errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.body)
                        .padding(.top, 10)
                }
                
                Button(action: {
                    if validateForm() {
                        saveGoal()
                    }
                }) {
                    Text(editingGoal == nil ? "目標を追加" : "目標を更新")
                }
            }
            .navigationBarTitle(editingGoal == nil ? "新しい目標" : "目標を編集")
            .navigationBarItems(trailing: Button("キャンセル") {
                presentationMode.wrappedValue.dismiss()
            })
            .onAppear {
                if let goal = editingGoal {
                    title = goal.title
                    purpose = goal.purpose
                    reward = goal.reward
                    encouragement = goal.encouragement ?? ""
                    cycleDays = String(goal.cycleDays)
                }
            }
        }
    }
    
    func validateForm() -> Bool {
        if title.isEmpty {
            errorMessage = "タイトルは必須です。"
            return false
        } else if title.count > 15 {
            errorMessage = "タイトルは15文字以内で入力してください。"
            return false
        }
        
        if purpose.isEmpty {
            errorMessage = "目的は必須です。"
            return false
        } else if purpose.count > 15 {
            errorMessage = "目的は15文字以内で入力してください。"
            return false
        }
        
        if reward.isEmpty {
            errorMessage = "褒美は必須です。"
            return false
        } else if reward.count > 15 {
            errorMessage = "褒美は15文字以内で入力してください。"
            return false
        }
        
        if !encouragement.isEmpty && encouragement.count > 50 {
            errorMessage = "励ましの言葉は50文字以内で入力してください。"
            return false
        }
        
        if cycleDays.isEmpty {
            errorMessage = "サイクル日数は必須です。"
            return false
        } else if let days = Int(cycleDays), days <= 0 {
            errorMessage = "サイクル日数は1日以上で入力してください。"
            return false
        } else if Int(cycleDays) == nil {
            errorMessage = "サイクル日数は数字で入力してください。"
            return false
        }
        
        errorMessage = nil
        return true
    }
    
    func saveGoal() {
        // Core MLモデルを使用して目標のカテゴリを予測
        let goalCategory = predictCategory(from: title)
        
        print("Predicted Category for Goal '\(title)': \(goalCategory)") // デバッグログ

        if let editingGoal = editingGoal {
            if let index = goals.firstIndex(where: { $0.id == editingGoal.id }) {
                // 既存の目標を更新
                goals[index].title = title
                goals[index].purpose = purpose
                goals[index].reward = reward
                goals[index].encouragement = encouragement.isEmpty ? nil : encouragement
                goals[index].cycleDays = Int(cycleDays) ?? 0
                goals[index].nextCheatDay = Calendar.current.date(byAdding: .day, value: goals[index].cycleDays, to: Date()) ?? Date()
                goals[index].category = goalCategory // 予測されたカテゴリで更新
            }
        } else {
            if let days = Int(cycleDays) {
                // 新しい目標を作成
                let newGoal = Goal(
                    title: title,
                    purpose: purpose,
                    reward: reward,
                    encouragement: encouragement.isEmpty ? nil : encouragement,
                    cycleDays: days,
                    nextCheatDay: Calendar.current.date(byAdding: .day, value: days, to: Date()) ?? Date(),
                    category: goalCategory // 予測されたカテゴリを設定
                )
                goals.append(newGoal)
                
                // 通知が有効なら、通知をスケジュール
                if UserDefaults.standard.bool(forKey: "notificationsEnabled") {
                    scheduleNotifications(for: newGoal)
                }
            }
        }
        
        // 画面を閉じる
        presentationMode.wrappedValue.dismiss()
    }

    // 通知をスケジュールする関数
    func scheduleNotifications(for goal: Goal) {
        let center = UNUserNotificationCenter.current()
        
        // 同じ目標に対する古い通知を削除して重複を防ぐ
        center.removeAllPendingNotificationRequests()
        
        let calendar = Calendar.current
        let cheatDay = goal.nextCheatDay
        
        // 例: チートデイの7日前、3日前、1日前に通知
        let firstNotificationDate = calendar.date(byAdding: .day, value: -7, to: cheatDay)
        let secondNotificationDate = calendar.date(byAdding: .day, value: -3, to: cheatDay)
        let oneDayBeforeNotificationDate = calendar.date(byAdding: .day, value: -1, to: cheatDay)
        
        let dates = [firstNotificationDate, secondNotificationDate, oneDayBeforeNotificationDate]
        
        for (index, date) in dates.enumerated() {
            if let date = date {
                let daysUntil = calendar.dateComponents([.day], from: Date(), to: date).day ?? 0
                let content = UNMutableNotificationContent()
                content.title = "「\(goal.title)」のチートデイまであと\(daysUntil)日！！"
                content.body = "チートデイまでもう少し頑張ろう！"
                content.sound = .default

                let triggerDate = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)

                let request = UNNotificationRequest(identifier: "cheatDayNotification_\(index)_\(goal.id)", content: content, trigger: trigger)
                center.add(request) { error in
                    if let error = error {
                        print("通知のスケジュールに失敗しました: \(error.localizedDescription)")
                    }
                }
            }
        }
    }

    
    // Prediction function to get category from Core ML model
    func predictCategory(from goalTitle: String) -> String {
        guard let model = try? CheatDay_Machine_Learning(configuration: .init()) else {
            return "General" // Default category if prediction fails
        }

        do {
            let prediction = try model.prediction(text: goalTitle)
            return prediction.label // Return the predicted category label
        } catch {
            print("Prediction error: \(error.localizedDescription)")
            return "General" // Default category if prediction fails
        }
    }
}

struct GoalFormView_Previews: PreviewProvider {
    static var previews: some View {
        GoalFormView(goals: .constant([]), editingGoal: .constant(nil))
    }
}
