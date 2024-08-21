import Foundation

struct Goal: Identifiable {
    let id = UUID()
    var title: String
    var purpose: String
    var reward: String
    var encouragement: String?
    var cycleDays: Int
    var nextCheatDay: Date
}
