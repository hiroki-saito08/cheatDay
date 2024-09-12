import SwiftUI
import GoogleMobileAds

struct RewardsView: View {
    @Binding var goals: [Goal]
    @State private var bannerView: GADBannerView?

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(goals) { goal in
                            VStack(alignment: .leading, spacing: 10) {
                                Text(goal.title)
                                    .font(.yomogiHeadline())
                                    .fontWeight(.bold)
                                    .padding(.bottom, 5)
                                
                                if isCheatDay(for: goal) {
                                    HStack {
                                        Spacer()
                                        HStack(spacing: 5) {
                                            Image("star_color")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .rotationEffect(.degrees(15))
                                            Text("がんばったね！")
                                                .font(.yomogiTitle())
                                                .foregroundColor(Color(red: 0.85, green: 0.65, blue: 0.0))
                                                .fontWeight(.bold)
                                            Image("star_color")
                                                .resizable()
                                                .frame(width: 24, height: 24)
                                                .rotationEffect(.degrees(15))
                                        }
                                        Spacer()
                                    }
                                    Text(goal.reward)
                                        .font(.yomogiTitle())
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.green)
                                        .cornerRadius(10)
                                } else {
                                    Text(goal.reward)
                                        .font(.yomogiBody())
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                }

                // Ad space positioned just above the bottom menu
                if let bannerView = bannerView {
                    BannerAdView(bannerView: bannerView)
                        .frame(width: bannerView.frame.width, height: bannerView.frame.height * 2)
                        .padding(.bottom, 30) // Adjusted padding to move the ad closer to the bottom menu
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    VStack(spacing: 0) {
                        Text("褒美")
                            .font(.custom("Yomogi-Regular", size: 28))
                            .bold()
                            .padding(.bottom, 0)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                setupAd()
            }
        }
    }

    func setupAd() {
        let adSize = GADAdSizeBanner
        let newBannerView = GADBannerView(adSize: adSize)
        newBannerView.adUnitID = "ca-app-pub-9263407369400599~2833694935"
        newBannerView.rootViewController = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }?.rootViewController
        newBannerView.load(GADRequest())
        self.bannerView = newBannerView
    }

    func isCheatDay(for goal: Goal) -> Bool {
        Calendar.current.isDateInToday(goal.nextCheatDay)
    }
}

struct BannerAdView: UIViewRepresentable {
    let bannerView: GADBannerView

    func makeUIView(context: Context) -> GADBannerView {
        return bannerView
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {
        // Update the view if needed
    }
}

struct RewardsView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsView(goals: .constant([
            Goal(title: "読書の習慣をつける", purpose: "リラクゼーション", reward: "もっと読む", encouragement: nil, cycleDays: 7, nextCheatDay: Date(), category: "Reading"),
            Goal(title: "映画鑑賞を楽しむ", purpose: "エンターテインメント", reward: "別の映画を見る", encouragement: "楽しみ続けてください！", cycleDays: 10, nextCheatDay: Calendar.current.date(byAdding: .day, value: 3, to: Date())!, category: "Entertainment")
        ]))
    }
}
