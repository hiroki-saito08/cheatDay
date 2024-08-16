import SwiftUI

struct CoursesView: View {
    // Example data for multiple goals, converted to CGFloat
    let goals = [
        (name: "目標1", data: [5, 3, 6, 8, 2, 7, 4, 6].map { CGFloat($0) }, color: Color.red),
        (name: "目標2", data: [4, 2, 5, 6, 9, 7, 3, 4].map { CGFloat($0) }, color: Color.green),
        (name: "目標3", data: [1, 4, 3, 5, 8, 6, 5, 4].map { CGFloat($0) }, color: Color.blue)
    ]

    var body: some View {
        NavigationView {
            VStack {
                Text("過去のチートデイサイクル")
                    .font(.headline)
                    .padding()

                GeometryReader { geometry in
                    ZStack {
                        ForEach(goals.indices, id: \.self) { index in
                            LineGraph(dataPoints: goals[index].data)
                                .stroke(goals[index].color, lineWidth: 2)
                                .frame(width: geometry.size.width, height: 200)
                        }
                    }
                }
                .frame(height: 220)

                ForEach(goals, id: \.name) { goal in
                    Text(goal.name)
                        .padding(.top, 2)
                        .foregroundColor(goal.color)
                }

                Spacer()
            }
            .navigationTitle("戦歷")
        }
    }
}

struct LineGraph: Shape {
    var dataPoints: [CGFloat]

    func path(in rect: CGRect) -> Path {
        var path = Path()

        if dataPoints.isEmpty {
            return path
        }

        let maxValue = dataPoints.max() ?? 0
        let minValue = dataPoints.min() ?? 0

        let normalizedPoints = dataPoints.map { point in
            (point - minValue) / (maxValue - minValue)
        }

        let pointOffset = rect.width / CGFloat(dataPoints.count - 1)

        for (index, point) in normalizedPoints.enumerated() {
            let xPosition = CGFloat(index) * pointOffset
            let yPosition = (1 - point) * rect.height

            let newPoint = CGPoint(x: xPosition, y: yPosition)
            if index == 0 {
                path.move(to: newPoint)
            } else {
                path.addLine(to: newPoint)
            }
        }

        return path
    }
}

struct CoursesView_Previews: PreviewProvider {
    static var previews: some View {
        CoursesView()
    }
}
