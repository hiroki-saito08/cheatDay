import SwiftUI

struct AffiliateAd {
    var id: UUID
    var productName: String
    var productImage: String // URL or local asset name
    var description: String
    var price: String
    var affiliateLink: String
    var goalCategory: String // The goal category this ad is associated with
}

let affiliateAds = [
    AffiliateAd(id: UUID(), productName: "Yoga Mat", productImage: "yoga_mat", description: "High-quality yoga mat", price: "$20", affiliateLink: "https://example.com/yoga-mat", goalCategory: "Fitness"),
    AffiliateAd(id: UUID(), productName: "Cookbook", productImage: "cookbook", description: "Healthy recipes", price: "$15", affiliateLink: "https://example.com/cookbook", goalCategory: "Cooking"),
    // More ads...
]

func getAdsForGoal(goalCategory: String) -> [AffiliateAd] {
    return affiliateAds.filter { $0.goalCategory == goalCategory }
}

