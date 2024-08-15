import Foundation

struct CheatDay: Identifiable, Codable {
    var id: UUID = UUID() // Identifiable に必要な、各 CheatDay の一意の識別子
    var date: Date // チート デーの日付
    var activities: [Activity] // チート デーのアクティビティのリスト
}

