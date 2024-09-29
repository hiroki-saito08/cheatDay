import SwiftUI

struct GoalsView: View {
    @Binding var goals: [Goal]
    @State private var showGoalForm = false
    @State private var editingGoal: Goal? = nil
    @State private var showSettings = false
    
    // State to manage the delete confirmation alert
    @State private var showDeleteConfirmation = false
    @State private var goalToDelete: Goal? = nil
    
    // Daily Quote
    @State private var dailyQuote: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Text(dailyQuote)
                    .font(.yomogiSubheadline())
                    .foregroundColor(.gray)
                    .padding()
                    .multilineTextAlignment(.center)
                
                if goals.isEmpty {
                    Text("目標を登録してください！")
                        .font(.yomogiTitle())
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    List {
                        ForEach(goals) { goal in
                            VStack(alignment: .leading, spacing: 8) {
                                // 目標のタイトルを太字にし、引用符で囲む
                                Text("「\(goal.title)」")
                                    .font(.yomogiHeadline().bold()) // 太字に変更
                                    .padding(.bottom, 2)
                                Text("目的: \(goal.purpose)")
                                    .font(.yomogiBody())
                                    .padding(.bottom, 2)
                                HStack {
                                    Text("次のチートデイ: ")
                                        .font(.yomogiBody())
                                    Text("\(formattedDate(goal.nextCheatDay))")
                                        .font(.yomogiBody())
                                        .underline()
                                }
                                .padding(.bottom, 2)
                                Text("サイクル: \(goal.cycleDays) 日ごと")
                                    .font(.yomogiBody())
                                    .padding(.bottom, 2)
                                if let encouragement = goal.encouragement, !encouragement.isEmpty {
                                    // 励ましの言葉も太字に変更
                                    Text("励ましの言葉: \(encouragement)")
                                        .font(.yomogiSubheadline().bold()) // 太字に変更
                                        .padding(.bottom, 2)
                                }
                            }
                            .padding(.vertical, 4)
                            // スワイプで削除と編集を追加
                            .swipeActions(edge: .trailing) {
                                Button(role: .destructive) {
                                    goalToDelete = goal
                                    showDeleteConfirmation = true
                                } label: {
                                    Label("削除", systemImage: "trash")
                                }
                            }
                            .swipeActions(edge: .leading) {
                                Button {
                                    editingGoal = goal
                                    showGoalForm = true
                                } label: {
                                    Label("編集", systemImage: "pencil")
                                }
                                .tint(.blue)
                            }
                        }
                        .onDelete(perform: deleteGoal) // スワイプで削除が動作する
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 0) {
                        Text("目標")
                            .font(.custom("Yomogi-Regular", size: 28))
                            .bold()
                            .padding(.bottom, 0)
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
                            .font(.title2)
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
                SettingsView()
            }
            .navigationBarTitleDisplayMode(.inline)
            .alert(isPresented: $showDeleteConfirmation) {
                Alert(
                    title: Text("目標を削除しますか？"),
                    message: Text("この操作は取り消せません。"),
                    primaryButton: .destructive(Text("削除")) {
                        if let goal = goalToDelete {
                            deleteGoalDirect(goal)
                        }
                    },
                    secondaryButton: .cancel()
                )
            }
            .onAppear {
                dailyQuote = DailyQuotes.getDailyQuote() // Fetch a daily quote
            }
        }
    }
    
    // 削除アクションで IndexSet を受け取り、goals から削除
    func deleteGoal(at offsets: IndexSet) {
        goals.remove(atOffsets: offsets)
    }
    
    // 削除の直接処理用の関数
    func deleteGoalDirect(_ goal: Goal) {
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

struct GoalsView_Previews: PreviewProvider {
    static var previews: some View {
        GoalsView(goals: .constant([]))
    }
}
