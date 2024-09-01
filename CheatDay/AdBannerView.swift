import SwiftUI
import GoogleMobileAds

// Custom Ad Banner View for Google AdMob with Category Targeting
struct AdBannerView: UIViewRepresentable {
    var category: String
    
    func makeUIView(context: Context) -> GADBannerView {
        let bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-9263407369400599~2833694935" // Replace with your actual ad unit ID
        bannerView.rootViewController = UIApplication.shared.windows.first?.rootViewController
        
        // Create a GADRequest and add keywords based on the category
        let request = GADRequest()
        request.keywords = [category] // Use the category as a keyword
        
        bannerView.load(request)
        return bannerView
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {
        // Update UI if needed
    }
}
