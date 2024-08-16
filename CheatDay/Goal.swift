import Foundation

struct Goal: Identifiable {
    let id = UUID()
    var name: String
    var purpose: String
    var nextCheatDay: Date
    var cycle: Int
}
