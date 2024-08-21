import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTab: Int
    let icons: [String]
    let titles: [String]
    
    var body: some View {
        HStack(spacing: 0) { // Remove spacing between items
            ForEach(0..<icons.count, id: \.self) { index in
                Button(action: {
                    selectedTab = index
                }) {
                    VStack {
                        Image(icons[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                    }
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity) // Ensure each item takes up equal space
                    .background(selectedTab == index ? Color.green.opacity(0.2) : Color.clear)
                    .foregroundColor(selectedTab == index ? .green : .gray)
                }
            }
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}
