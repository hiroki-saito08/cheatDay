import SwiftUI

struct BattleHistoryView: View {
    @Binding var goals: [Goal]

    var body: some View {
        NavigationView {
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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 0) { // Reduce spacing under the title
                        Text("戦歴")
                            .font(.custom("Yomogi-Regular", size: 28)) // Use Yomogi-Regular and larger size
                            .bold() // Make the title bold if needed
                            .padding(.bottom, 0) // Reduce or remove padding
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
        }
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
        BattleHistoryView(goals: .constant([
            Goal(title: "読書の習慣をつける", purpose: "リラクゼーション", reward: "もっと読む", encouragement: nil, cycleDays: 7, nextCheatDay: Date(), category: "Reading"),
            Goal(title: "映画鑑賞を楽しむ", purpose: "エンターテインメント", reward: "別の映画を見る", encouragement: "楽しみ続けてください！", cycleDays: 10, nextCheatDay: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, category: "Entertainment")
        ]))
    }
}
