import Foundation

struct Goal: Identifiable, Codable {
    let id = UUID()
    var title: String
    var purpose: String
    var reward: String
    var encouragement: String?
    var cycleDays: Int
    var nextCheatDay: Date
    var category: String // 予測されたカテゴリを保持
    var cheatDayHistory: [Date] = [] // チートデイの履歴を保存するためのプロパティを追加
}
