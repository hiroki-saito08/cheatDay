import SwiftUI
import Charts

struct GoalGraphView: View {
    var goal: Goal
    
    var body: some View {
        VStack {
            Text("\(goal.title) 戦歴")
                .font(.largeTitle)
                .padding()
            
            LineChart(goal: goal)
                .frame(height: 300)
                .padding()
            
            Spacer()
        }
        .navigationBarTitle("\(goal.title) の戦歴", displayMode: .inline)
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
    
    // Generate data for the line graph based on the cheat day cycle for a specific goal
    func generateCycleData(for goal: Goal) -> [CycleData] {
        var cycleData: [CycleData] = []
        var startDate = goal.nextCheatDay
        let cycleDays = goal.cycleDays
        
        // Simulate cycle data with a set number of intervals
        for increment in stride(from: cycleDays, to: cycleDays + 9, by: 3) {
            cycleData.append(CycleData(date: startDate, daysBetween: increment))
            startDate = Calendar.current.date(byAdding: .day, value: increment, to: startDate) ?? startDate
        }
        
        return cycleData
    }
}

struct CycleData: Identifiable {
    let id = UUID()
    let date: Date
    let daysBetween: Int
}

struct GoalGraphView_Previews: PreviewProvider {
    static var previews: some View {
        GoalGraphView(goal: Goal(title: "読書", purpose: "リラクゼーション", reward: "もっと読む", encouragement: nil, cycleDays: 7, nextCheatDay: Date()))
    }
}
