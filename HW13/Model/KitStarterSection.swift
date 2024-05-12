import Foundation

struct KitStarterSection : Identifiable {
    var id : String = UUID().uuidString
    var header : String? = nil
    let group : [KitStarterItem]
    
    static func getMockSectionData() -> [KitStarterSection] {
        let weaponGroup = [
            KitStarterItem(image: "sword", itemName: "Sword", itemDescription: ""),
            KitStarterItem(image: "axe", itemName: "Axe", itemDescription: ""),
            KitStarterItem(image: "bow", itemName: "Bow", itemDescription: ""),
            KitStarterItem(image: "mace", itemName: "Mace", itemDescription: ""),
            KitStarterItem(image: "spear", itemName: "Spear", itemDescription: "")
        ]
        
        let armourGroup = [
            KitStarterItem(image: "shield", itemName: "Shield", itemDescription: ""),
            KitStarterItem(image: "armourLight", itemName: "Light Armour", itemDescription: ""),
            KitStarterItem(image: "armourMedium", itemName: "Medium Armour", itemDescription: ""),
            KitStarterItem(image: "armourHeavy", itemName: "Heavy Armour", itemDescription: ""),
            KitStarterItem(image: "helmet", itemName: "Helmet", itemDescription: "")
        ]
        
        let raceGroup = [
            KitStarterItem(image: "human", itemName: "Human", itemDescription: ""),
            KitStarterItem(image: "orc", itemName: "Orc", itemDescription: ""),
            KitStarterItem(image: "dwarf", itemName: "Dwarf", itemDescription: ""),
            KitStarterItem(image: "elf", itemName: "Elf", itemDescription: ""),
            KitStarterItem(image: "goblin", itemName: "Goblin", itemDescription: "")
        ]
        
        let weaponSection = KitStarterSection(header: "Choose your weapon", group: weaponGroup)
        let amourSection = KitStarterSection(header: "Choose your armour set", group: armourGroup)
        let raceSection = KitStarterSection(header: "Choose your race", group: raceGroup)
        
        return [weaponSection, amourSection, raceSection]
    }
}
