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
                                .font(.headline)
                            Spacer()
                            Text("現在の周期は \(goal.cycleDays) 日")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .navigationBarTitle("戦歴", displayMode: .inline)
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
