import SwiftUI

struct RewardsView: View {
    // Example data - this would be dynamically fetched or stored in your app
    var rewards: [String] = ["Watch a movie", "Go out for dinner", "Play a video game"]

    var body: some View {
        NavigationView {
            List(rewards, id: \.self) { reward in
                Text(reward)
            }
            .navigationTitle("褒美")
        }
    }
}

struct RewardsView_Previews: PreviewProvider {
    static var previews: some View {
        RewardsView()
    }
}
