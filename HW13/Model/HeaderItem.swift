import Foundation

struct HeaderItem : Identifiable {
    var id : String = UUID().uuidString
    let header : String
    
    static func getMockHeaderData() -> [HeaderItem] {
        [
            HeaderItem(header: "\u{25E6} choose your weapon:"),
            HeaderItem(header: "\u{25E6} choose your armour:"),
            HeaderItem(header: "\u{25E6} choose your race:"),
        ]
    }
}
