import Foundation

struct KitStarter : Identifiable {
    var id : String = UUID().uuidString
    let image : String
    let itemName : String
    let itemDescription : String
}
