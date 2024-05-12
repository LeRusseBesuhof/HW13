import UIKit

final class HeaderCell: UICollectionReusableView, CellProtocol {
    static let reuseID : String = "item"
    
    internal lazy var label : UILabel! = AppUIFuncs.createLabel(alignment: .left, font: UIFont.systemFont(ofSize: 18, weight: .light))
    
    func setUpHeader(from item: HeaderItem) {
        label.text = item.header
        label.frame = CGRect(x: 15, y: 0, width: frame.width, height: 20)
        
        addSubview(label)
    }
}
