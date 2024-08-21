import SwiftUI

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
        } else if Int(cycleDays) == nil {
            errorMessage = "サイクル日数は数字で入力してください。"
            return false
        }
        
        errorMessage = nil
        return true
    }
    
    func saveGoal() {
        if let editingGoal = editingGoal {
            if let index = goals.firstIndex(where: { $0.id == editingGoal.id }) {
                goals[index].title = title
                goals[index].purpose = purpose
                goals[index].reward = reward
                goals[index].encouragement = encouragement.isEmpty ? nil : encouragement
                goals[index].cycleDays = Int(cycleDays) ?? 0
                goals[index].nextCheatDay = Calendar.current.date(byAdding: .day, value: goals[index].cycleDays, to: Date()) ?? Date()
            }
        } else {
            if let days = Int(cycleDays) {
                let newGoal = Goal(
                    title: title,
                    purpose: purpose,
                    reward: reward,
                    encouragement: encouragement.isEmpty ? nil : encouragement,
                    cycleDays: days,
                    nextCheatDay: Calendar.current.date(byAdding: .day, value: days, to: Date()) ?? Date()
                )
                goals.append(newGoal)
            }
        }
        presentationMode.wrappedValue.dismiss()
    }
}

struct GoalFormView_Previews: PreviewProvider {
    static var previews: some View {
        GoalFormView(goals: .constant([]), editingGoal: .constant(nil))
    }
}
