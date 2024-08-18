import SwiftUI

struct CheatDayScreen: View {
    @Binding var goal: Goal
    @Binding var isPresented: Bool
    @State private var selectedDays = 1
    private let daysOptions = [1, 2, 3, 4, 5, 6, 7] // Options for extending the cycle
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Text("今日は \(goal.title) チートデイ！")
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("おめでとうございます！よく頑張りました！")
                .font(.title2)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("次のチートデイを少し延ばしてみませんか？")
                .font(.headline)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Picker("延長日数を選択してください", selection: $selectedDays) {
                ForEach(daysOptions, id: \.self) { day in
                    Text("\(day) 日").tag(day)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.horizontal)
            .background(Color(UIColor.systemBackground).cornerRadius(10))
            
            Spacer()
            
            VStack(spacing: 15) {
                Button(action: {
                    extendCheatDay(for: &goal, by: selectedDays)
                    isPresented = false
                }) {
                    Text("次のチートデイを延ばす")
                        .font(.title2)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
                }
                
                Button(action: {
                    isPresented = false
                }) {
                    Text("今の周期のままにする")
                        .font(.title2)
                        .padding()
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal, 30)
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGroupedBackground))
        .ignoresSafeArea()
    }
    
    func extendCheatDay(for goal: inout Goal, by days: Int) {
        // Logic to extend the cheat day cycle for the goal
        goal.cycleDays += days // Extend by the selected number of days
    }
}
