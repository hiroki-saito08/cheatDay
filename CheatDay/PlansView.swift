import SwiftUI

struct PlansView: View {
    @Binding var goals: [Goal]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    ForEach(generateFutureDays(), id: \.self) { day in
                        if isFirstDayOfMonth(day) {
                            Text(monthHeader(for: day))
                                .font(.yomogiHeadline())
                                .padding(.top, 20)
                        }
                        VStack(alignment: .leading) {
                            HStack(alignment: .center) {
                                Text(dayHeader(for: day))
                                    .font(isCheatDay(day) ? .yomogiTitle() : day == Date() ? .yomogiHeadline().bold() : .yomogiSubheadline())
                                    .foregroundColor(isCheatDay(day) ? .white : day == Date() ? .red : .gray)
                                    .lineLimit(1)
                                    .padding()
                                    .background(isCheatDay(day) ? Color.green : Color.clear)
                                    .cornerRadius(10)
                                
                                Spacer()

                                if let goal = goalForDay(day) {
                                    Text(daysUntil(day) == 0 ? "今日は \(goal.title) のチートデイです！！" : "\(daysUntil(day)) 日後は \(goal.title) のチートデイ")
                                        .font(.yomogiBody())
                                        .foregroundColor(.primary)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)
                                        .padding(.leading, 15)
                                        .padding(.trailing, 15)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                        .padding(.vertical, 5)
                        .background(day == Date() || isCheatDay(day) ? Color(UIColor.systemGroupedBackground) : Color.clear)
                        .cornerRadius(8)
                        .id(day)
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitle(formattedDate(Date()), displayMode: .inline) // Match title style with Rewards and Battle History
        }
    }
    
    // Generate a list of future days starting from today
    func generateFutureDays() -> [Date] {
        let calendar = Calendar.current
        let today = Date()
        let endDate = calendar.date(byAdding: .month, value: 1, to: today) ?? today // 1 month in the future
        
        var dates: [Date] = []
        var currentDate = today
        
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }
        
        return dates
    }
    
    // Check if the day is the first day of the month
    func isFirstDayOfMonth(_ day: Date) -> Bool {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: day)
        return components.day == 1
    }
    
    // Determine if the day is a cheat day
    func isCheatDay(_ day: Date) -> Bool {
        return goals.contains { Calendar.current.isDate($0.nextCheatDay, inSameDayAs: day) }
    }
    
    // Get the goal associated with a specific day (if any)
    func goalForDay(_ day: Date) -> Goal? {
        return goals.first { Calendar.current.isDate($0.nextCheatDay, inSameDayAs: day) }
    }
    
    // Helper function to format the day header
    func dayHeader(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d日 (E)"
        return formatter.string(from: date)
    }
    
    // Helper function to format the month header
    func monthHeader(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年 M月"
        return formatter.string(from: date)
    }
    
    // Helper function to format the current date at the top
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年 M月 d日 (E)"
        return formatter.string(from: date)
    }
    
    // Helper function to calculate days until the next cheat day
    func daysUntil(_ date: Date) -> Int {
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: Date())
        let startOfTargetDay = calendar.startOfDay(for: date)
        
        let components = calendar.dateComponents([.day], from: startOfToday, to: startOfTargetDay)
        
        return components.day ?? 0 // 1日を加算しない
    }
}

struct PlansView_Previews: PreviewProvider {
    static var previews: some View {
        PlansView(goals: .constant([
            Goal(title: "読書の習慣をつける", purpose: "リラクゼーション", reward: "もっと読む", encouragement: nil, cycleDays: 7, nextCheatDay: Date(), category: "Reading"),
            Goal(title: "映画鑑賞を楽しむ", purpose: "エンターテインメント", reward: "別の映画を見る", encouragement: "楽しみ続けてください！", cycleDays: 10, nextCheatDay: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, category: "Entertainment")
        ]))
    }
}
