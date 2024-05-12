import Foundation

struct Header : Identifiable {
    var id : String = UUID().uuidString
    let header : String
    
    static func getMockHeaderData() -> [Header] {
        [
            Header(header: ""),
            
        ]
    }
}
