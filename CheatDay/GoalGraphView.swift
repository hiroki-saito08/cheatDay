import SwiftUI
import Charts

struct GoalGraphView: View {
    var goal: Goal
    
    var body: some View {
        VStack {
            Text(goal.title)
                .font(.largeTitle)
                .padding(.top)
            Text("の戦歴")
                .font(.largeTitle)

            LineChart(goal: goal)
                .frame(height: 300)
                .padding()
            
            Spacer()
        }
    }
}

struct LineChart: View {
    var goal: Goal
    
    var body: some View {
        Chart {
            let data = generateCycleData(for: goal)
            
            ForEach(data.indices, id: \.self) { dataIndex in
                let entry = data[dataIndex]
                LineMark(
                    x: .value("日付", entry.date),
                    y: .value("チートデイの間隔(日数)", entry.daysBetween)
                )
                .foregroundStyle(Color.blue)
                .symbol(Circle())
            }
        }
        .chartXAxisLabel("日付")
        .chartYAxisLabel("チートデイの間隔(日数)")
    }
    
    // Generate data based on the actual cheat days
    func generateCycleData(for goal: Goal) -> [CycleData] {
        var cycleData: [CycleData] = []
        var previousCheatDay = goal.nextCheatDay // 最初のチートデイ
        let cycleDays = goal.cycleDays
        
        // チートデイの履歴が保存されていると仮定し、それに基づいてデータを生成
        for cheatDay in goal.cheatDayHistory {
            let daysBetween = Calendar.current.dateComponents([.day], from: previousCheatDay, to: cheatDay).day ?? cycleDays
            cycleData.append(CycleData(date: cheatDay, daysBetween: daysBetween))
            previousCheatDay = cheatDay
        }
        
        return cycleData
    }
}

// CycleData struct to store each cheat day and the interval between them
struct CycleData: Identifiable {
    let id = UUID()
    let date: Date
    let daysBetween: Int
}

struct GoalGraphView_Previews: PreviewProvider {
    static var previews: some View {
        GoalGraphView(goal: Goal(
            title: "Reading",
            purpose: "Relaxation",
            reward: "Read more",
            encouragement: nil,
            cycleDays: 7,
            nextCheatDay: Date(),
            category: "Reading",
            cheatDayHistory: [ // 実際のチートデイの履歴
                Calendar.current.date(byAdding: .day, value: -21, to: Date())!,
                Calendar.current.date(byAdding: .day, value: -14, to: Date())!,
                Calendar.current.date(byAdding: .day, value: -7, to: Date())!
            ]
        ))
    }
}
