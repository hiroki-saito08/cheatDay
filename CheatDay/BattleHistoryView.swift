import SwiftUI

struct BattleHistoryView: View {
    @Binding var goals: [Goal]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(goals) { goal in
                    NavigationLink(destination: GoalGraphView(goal: goal)) {
                        HStack {
                            Text(goal.title)
                                .font(.yomogiHeadline())
                            Spacer()
                            Text("現在の周期は \(goal.cycleDays) 日")
                                .font(.yomogiSubheadline())
                                .foregroundColor(.gray)
                        }
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
}

struct BattleHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        BattleHistoryView(goals: .constant([
            Goal(title: "読書", purpose: "リラクゼーション", reward: "もっと読む", encouragement: nil, cycleDays: 7, nextCheatDay: Date()),
            Goal(title: "映画鑑賞", purpose: "エンターテインメント", reward: "別の映画を見る", encouragement: "楽しみ続けてください！", cycleDays: 10, nextCheatDay: Calendar.current.date(byAdding: .day, value: 3, to: Date())!)
        ]))
    }
}
