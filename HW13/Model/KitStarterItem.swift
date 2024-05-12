import Foundation

struct KitStarterItem : Identifiable {
    var id : String = UUID().uuidString
    let image : String
    let itemName : String
    let itemDescription : String
}
