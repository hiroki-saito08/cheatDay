import Foundation

struct Activity: Identifiable, Codable {
    var id = UUID() // 各 Activity の一意の識別子
    var name: String // アクティビティの名前
    var description: String // アクティビティの説明
}
