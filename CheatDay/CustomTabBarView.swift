import SwiftUI

struct CustomTabBarView: View {
    @Binding var selectedTab: Int
    let icons: [String]
    let titles: [String]
    
    var body: some View {
        HStack {
            ForEach(0..<icons.count, id: \.self) { index in
                Spacer()
                VStack {
                    Image(icons[index])
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                }
                .padding(.vertical, 10)
                .onTapGesture {
                    selectedTab = index
                }
                .foregroundColor(selectedTab == index ? .green : .gray)
                Spacer()
            }
        }
        .background(Color.white)
        .cornerRadius(15)
        .shadow(radius: 5)
        .padding(.horizontal)
    }
}
