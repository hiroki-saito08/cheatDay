import SwiftUI

struct GoalsView: View {
    @Binding var goals: [Goal]
    @State private var showGoalForm = false
    @State private var editingGoal: Goal? = nil
    @State private var showSettings = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) { // Set spacing to 0 to reduce vertical space
                if goals.isEmpty {
                    Text("目標を登録してください！")
                        .font(.yomogiTitle())
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(goals) { goal in
                            VStack(alignment: .leading, spacing: 8) { // Added spacing between lines
                                Text(goal.title)
                                    .font(.yomogiHeadline().bold())
                                    .padding(.bottom, 2) // Additional spacing
                                Text("目的: \(goal.purpose)")
                                    .font(.yomogiBody())
                                    .padding(.bottom, 2) // Additional spacing
                                HStack {
                                    Text("次のチートデイ: ")
                                        .font(.yomogiBody())
                                    Text("\(formattedDate(goal.nextCheatDay))")
                                        .font(.yomogiBody())
                                        .underline() // Underline only the date
                                }
                                .padding(.bottom, 2) // Additional spacing
                                Text("サイクル: \(goal.cycleDays) 日ごと")
                                    .font(.yomogiBody())
                                    .padding(.bottom, 2) // Additional spacing
                                if let encouragement = goal.encouragement, !encouragement.isEmpty {
                                    Text("励ましの言葉: \(encouragement)")
                                        .font(.yomogiSubheadline()) // Normal text color
                                        .padding(.bottom, 2) // Additional spacing
                                }
                            }
                            .padding(.vertical, 4) // Additional padding between goal entries
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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 0) { // Reduce spacing under the title
                        Text("目標")
                            .font(.custom("Yomogi-Regular", size: 28)) // Use Yomogi-Regular and larger size
                            .bold() // Make the title bold if needed
                            .padding(.bottom, 0) // Reduce or remove padding
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        showSettings.toggle()
                    }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.black)
                            .imageScale(.large)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                        Text("\(3 - goals.count)")
                            .font(.title2) // Increase font size
                            .foregroundColor(.black)
                    }
                    .onTapGesture {
                        editingGoal = nil
                        showGoalForm = true
                    }
                    .disabled(goals.count >= 3)
                }
            }
            .sheet(isPresented: $showGoalForm) {
                GoalFormView(goals: $goals, editingGoal: $editingGoal)
            }
            .sheet(isPresented: $showSettings) {
                SettingsView() // Your SettingsView implementation
            }
            .navigationBarTitleDisplayMode(.inline) // Make sure title is inline to reduce spacing
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
        formatter.dateFormat = "M月d日" // Japanese month and day format
        return formatter.string(from: date)
    }
}
