import SwiftUI

struct GoalsView: View {
    @Binding var goals: [Goal]
    @State private var showGoalForm = false
    @State private var editingGoal: Goal? = nil
    @State private var showSettings = false
    
    var body: some View {
        NavigationView {
            VStack {
                if goals.isEmpty {
                    Text("目標を登録してください！")
                        .font(.yomogiTitle())
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(goals) { goal in
                            VStack(alignment: .leading) {
                                Text(goal.title)
                                    .font(.yomogiHeadline())
                                Text("目的: \(goal.purpose)")
                                    .font(.yomogiBody())
                                Text("次のチートデイ: \(formattedDate(goal.nextCheatDay))")
                                    .font(.yomogiBody())
                                Text("サイクル: \(goal.cycleDays) 日ごと")
                                    .font(.yomogiBody())
                                if let encouragement = goal.encouragement {
                                    Text("励ましの言葉: \(encouragement)")
                                        .italic()
                                        .foregroundColor(.secondary)
                                        .font(.yomogiSubheadline())
                                }
                            }
                            .contextMenu {
                                Button(action: {
                                    editingGoal = goal
                                    showGoalForm = true
                                }) {
                                    Text("編集")
                                    Image(systemName: "pencil")
                                }
                                Button(role: .destructive, action: {
                                    deleteGoal(goal)
                                }) {
                                    Text("削除")
                                    Image(systemName: "trash")
                                }
                            }
                        }
                        .onDelete(perform: delete)
                    }
                }
            }
            .navigationBarTitle("目標", displayMode: .inline) // Match title style with Rewards and Battle History
            .navigationBarItems(
                leading: Button(action: {
                    showSettings.toggle()
                }) {
                    Image(systemName: "gearshape")
                        .foregroundColor(.black)
                        .imageScale(.large)
                },
                trailing: HStack {
                    Image(systemName: "plus")
                        .foregroundColor(.black)
                    Text("\(3 - goals.count)")
                        .foregroundColor(.black)
                }
                .onTapGesture {
                    editingGoal = nil
                    showGoalForm = true
                }
                .disabled(goals.count >= 3)
            )
            .sheet(isPresented: $showGoalForm) {
                GoalFormView(goals: $goals, editingGoal: $editingGoal)
            }
            .sheet(isPresented: $showSettings) {
                SettingsView() // Your SettingsView implementation
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        goals.remove(atOffsets: offsets)
    }
    
    func deleteGoal(_ goal: Goal) {
        if let index = goals.firstIndex(where: { $0.id == goal.id }) {
            goals.remove(at: index)
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}

struct GoalFormView: View {
    @Binding var goals: [Goal]
    @Binding var editingGoal: Goal?
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title: String = ""
    @State private var purpose: String = ""
    @State private var reward: String = ""
    @State private var encouragement: String = ""
    @State private var cycleDays: String = ""
    
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
                
                Button(action: {
                    saveGoal()
                }) {
                    Text(editingGoal == nil ? "目標を追加" : "目標を更新")
                }
                .disabled(title.isEmpty || purpose.isEmpty || reward.isEmpty || cycleDays.isEmpty)
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

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView(goals: .constant([]))
    }
}
