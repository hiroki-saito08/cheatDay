import SwiftUI
import Charts

struct BattleHistoryView: View {
    @Binding var goals: [Goal]
    
    var body: some View {
        NavigationView {
            VStack {
                Text("戦歴")
                    .font(.largeTitle)
                    .padding()
                
                LineChart(goals: goals)
                    .frame(height: 300)
                    .padding()
                
                // Display labels and current cycles for each goal
                ForEach(goals.indices, id: \.self) { index in
                    HStack {
                        Circle()
                            .fill(goalColor(for: index))
                            .frame(width: 10, height: 10)
                        Text("\(goals[index].title) - 現在の周期は \(goals[index].cycleDays) 日")
                            .font(.headline)
                    }
                    .padding(.bottom, 5)
                }
                
                Spacer()
            }
            .navigationBarTitle("戦歴", displayMode: .inline)
        }
    }
    
    // Assign a specific color to each goal based on index
    func goalColor(for index: Int) -> Color {
        let colors: [Color] = [.blue, .green, .red]
        return colors[index % colors.count]
    }
}

struct LineChart: View {
    var goals: [Goal]
    
    var body: some View {
        Chart {
            ForEach(goals.indices, id: \.self) { index in
                let goal = goals[index]
                let data = generateCycleData(for: goal)
                
                ForEach(data.indices, id: \.self) { dataIndex in
                    let entry = data[dataIndex]
                    LineMark(
                        x: .value("日付", entry.date),
                        y: .value("チートデイの間隔(日数)", entry.daysBetween)
                    )
                    .foregroundStyle(goalColor(for: index))
                    .symbol(Circle())
                }
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
        
        // Simulate cycle data with increasing intervals
        for increment in stride(from: cycleDays, to: cycleDays + 21, by: 3) {
            cycleData.append(CycleData(date: startDate, daysBetween: increment))
            startDate = Calendar.current.date(byAdding: .day, value: increment, to: startDate) ?? startDate
        }
        
        return cycleData
    }
    
    // Ensure the same color logic is applied to the graph
    func goalColor(for index: Int) -> Color {
        let colors: [Color] = [.blue, .green, .red]
        return colors[index % colors.count]
    }
}

struct CycleData: Identifiable {
    let id = UUID()
    let date: Date
    let daysBetween: Int
}
