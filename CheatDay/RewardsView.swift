import SwiftUI
import GoogleMobileAds

struct RewardsView: View {
    @Binding var goals: [Goal]
    @State private var bannerView: GADBannerView?

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if goals.isEmpty {
                    Spacer()
                    Text("目標を登録してください！")
                        .font(.yomogiHeadline())
                        .foregroundColor(.gray)
                    Spacer()
                } else {
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
                }

                // 広告を表示（目標がある場合のみ）
                if let bannerView = bannerView, !goals.isEmpty {
                    BannerAdView(bannerView: bannerView)
                        .frame(width: bannerView.frame.width, height: bannerView.frame.height * 2)
                        .padding(.bottom, 30)
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
                if !goals.isEmpty {
                    setupAd() // 目標がある場合のみ広告をセットアップ
                }
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
