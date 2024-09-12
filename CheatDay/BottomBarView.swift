import SwiftUI
import GoogleMobileAds

struct BottomBarView: View {
    @Binding var selectedTab: Int
    var category: String
    
    var body: some View {
        VStack {
            Divider() // Optional: Divider line above the bar
            HStack {
                Spacer()
                AdBannerView(category: category) // Pass the category to the ad view
                Spacer()
            }
            .padding()
            .background(Color.white)
            .shadow(radius: 5)
        }
    }
}
