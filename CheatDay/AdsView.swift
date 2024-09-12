import SwiftUI

struct AdsView: View {
    var category: String
    var ads: [AffiliateAd]

    var body: some View {
        VStack {
            Text("Recommended for You")
                .font(.headline)
                .padding()

            List(ads.filter { $0.goalCategory == category }, id: \.id) { ad in
                VStack(alignment: .leading) {
                    HStack {
                        Image(ad.productImage)
                            .resizable()
                            .frame(width: 50, height: 50)
                        
                        VStack(alignment: .leading) {
                            Text(ad.productName)
                                .font(.title2)
                            Text(ad.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text(ad.price)
                            .font(.subheadline)
                            .foregroundColor(.green)
                    }
                    
                    Button(action: {
                        openAffiliateLink(ad.affiliateLink)
                    }) {
                        Text("Learn More")
                            .font(.body)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
            }
        }
    }

    func openAffiliateLink(_ url: String) {
        guard let url = URL(string: url) else { return }
        UIApplication.shared.open(url)
    }
}
