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
                                .font(.headline)
                                .padding(.top, 20)
                        }
                        VStack(alignment: .leading) {
                            HStack {
                                if isCheatDay(day) {
                                    Text(dayHeader(for: day))
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                                    Spacer()
                                    if let goal = goalForDay(day) {
                                        Text(daysUntil(day) == 0 ? "今日は \(goal.title) チートデイ" : "\(daysUntil(day)) 日後は \(goal.title) チートデイ")
                                            .font(.subheadline)
                                            .foregroundColor(.primary)
                                            .multilineTextAlignment(.leading)
                                            .padding(.leading, 15) // Increase padding for more margin
                                            .padding(.trailing, 15) // Add trailing padding to prevent overflow
                                            .lineLimit(nil) // Allow text to wrap to multiple lines
                                            .frame(maxWidth: .infinity, alignment: .leading) // Ensure text stays within bounds
                                    }
                                } else if day == Date() {
                                    Text(dayHeader(for: day))
                                        .font(.headline.bold())
                                        .foregroundColor(.red)
                                        .textCase(.uppercase)
                                    Spacer()
                                } else {
                                    Text(dayHeader(for: day))
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                        .padding(.leading, 20)
                                        .padding(.top, 5)
                                    Spacer()
                                }
                            }
                        }
                        .padding(.vertical, 5)
                        .background(day == Date() || isCheatDay(day) ? Color(UIColor.systemGroupedBackground) : Color.clear)
                        .cornerRadius(8)
                        .id(day) // Assign an ID for scrolling purposes
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarTitle(formattedDate(Date()), displayMode: .inline) // Display current date at the top
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
        let components = calendar.dateComponents([.day], from: Date(), to: date)
        return components.day ?? 0
    }
}

struct PlansView_Previews: PreviewProvider {
    static var previews: some View {
        PlansView(goals: .constant([
            Goal(title: "読書", purpose: "リラクゼーション", reward: "もっと読む", encouragement: nil, cycleDays: 7, nextCheatDay: Date()),
            Goal(title: "映画鑑賞", purpose: "エンターテインメント", reward: "別の映画を見る", encouragement: "楽しみ続けてください！", cycleDays: 10, nextCheatDay: Calendar.current.date(byAdding: .day, value: 3, to: Date())!)
        ]))
    }
}
