import Foundation

struct TableItem : Identifiable {
    var id : String = UUID().uuidString
    let minimumImage : String
    let maximumImage : String
    let thumbImage : String
    
    static func getMockData() -> [(String, [TableItem])] {
        [
            ("\u{25E6} Power", [TableItem(minimumImage: "freedom", maximumImage: "motivation", thumbImage: "strength")]),
            ("\u{25E6} Stamina", [TableItem(minimumImage: "snail", maximumImage: "flash", thumbImage: "speedometer")]),
            ("\u{25E6} Stealth", [TableItem(minimumImage: "tank", maximumImage: "incognito", thumbImage: "eye")])
        ]
    }
}
