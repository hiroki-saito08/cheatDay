import SwiftUI

struct RewardsView: View {
    @Binding var goals: [Goal]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(goals) { goal in
                        VStack(alignment: .leading, spacing: 10) {
                            Text(goal.title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.bottom, 5)
                            
                            if isCheatDay(for: goal) {
                                HStack {
                                    Spacer()
                                    Text("⭐️ がんばったね！ ⭐️")
                                        .font(.largeTitle)
                                        .foregroundColor(.yellow)
                                    Spacer()
                                }
                                Text(goal.reward)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .cornerRadius(10)
                            } else {
                                Text(goal.reward)
                                    .font(.title3)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding(.vertical)
            }
            .navigationBarTitle("褒美", displayMode: .inline)
        }
    }
    
    // Determine if today is the cheat day for a given goal
    func isCheatDay(for goal: Goal) -> Bool {
        Calendar.current.isDateInToday(goal.nextCheatDay)
    }
}

struct RewardsView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsView(goals: .constant([
            Goal(title: "読書", purpose: "リラクゼーション", reward: "新しい本を買う", encouragement: nil, cycleDays: 7, nextCheatDay: Date()),
            Goal(title: "映画鑑賞", purpose: "エンターテインメント", reward: "ポップコーンを食べる", encouragement: "楽しみ続けてください！", cycleDays: 10, nextCheatDay: Calendar.current.date(byAdding: .day, value: 3, to: Date())!)
        ]))
    }
}
