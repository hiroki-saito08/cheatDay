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
                                .font(.yomogiHeadline())
                                .fontWeight(.bold)
                                .padding(.bottom, 5)
                            
                            if isCheatDay(for: goal) {
                                HStack {
                                    Spacer()
                                    HStack(spacing: 5) {
                                        Image("star_color") // Your star image
                                            .resizable()
                                            .frame(width: 24, height: 24) // Adjust size as needed
                                            .rotationEffect(.degrees(15)) // Tilt the star 15 degrees to the right
                                        Text("がんばったね！")
                                            .font(.yomogiTitle())
                                            .foregroundColor(Color(red: 0.85, green: 0.65, blue: 0.0)) // Darker yellow
                                            .fontWeight(.bold) // Make the text bold
                                        Image("star_color") // Your star image
                                            .resizable()
                                            .frame(width: 24, height: 24) // Adjust size as needed
                                            .rotationEffect(.degrees(15)) // Tilt the star 15 degrees to the right
                                    }
                                    Spacer()
                                }
                                Text(goal.reward)
                                    .font(.yomogiTitle())
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.green)
                                    .cornerRadius(10)
                            } else {
                                Text(goal.reward)
                                    .font(.yomogiBody())
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
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 0) { // Reduce spacing under the title
                        Text("褒美")
                            .font(.custom("Yomogi-Regular", size: 28)) // Use Yomogi-Regular and larger size
                            .bold() // Make the title bold if needed
                            .padding(.bottom, 0) // Reduce or remove padding
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
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
