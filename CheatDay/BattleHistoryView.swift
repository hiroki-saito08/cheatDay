import SwiftUI

struct BattleHistoryView: View {
    @Binding var goals: [Goal]

    var body: some View {
        NavigationView {
            VStack {
                if goals.isEmpty {
                    Spacer()
                    Text("目標を登録してください！")
                        .font(.yomogiHeadline())
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    List {
                        ForEach(goals) { goal in
                            NavigationLink(destination: GoalGraphView(goal: goal)) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text(goal.title)
                                        .font(.yomogiHeadline())
                                        .padding(.bottom, 2)
                                    
                                    HStack {
                                        Text("現在の周期は \(goal.cycleDays) 日")
                                            .font(.yomogiSubheadline())
                                            .foregroundColor(.gray)
                                        Spacer()
                                        Text("次のチートデイ: \(formattedDate(goal.nextCheatDay))")
                                            .font(.yomogiSubheadline())
                                            .foregroundColor(.blue)
                                            .underline()
                                    }
                                }
                                .padding(.vertical, 8)
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 0) {
                        Text("戦歴")
                            .font(.custom("Yomogi-Regular", size: 28))
                            .bold()
                            .padding(.bottom, 0)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
        .background(Color(UIColor.systemGroupedBackground)) // 背景色の修正
    }
    
    // Helper function to format the date in Japanese month and day format
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M月d日" // Japanese month and day format
        return formatter.string(from: date)
    }
}

struct BattleHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BattleHistoryView(goals: .constant([]))
    }
}
