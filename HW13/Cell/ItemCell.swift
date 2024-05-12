import UIKit

final class ItemCell: UICollectionViewCell, CellProtocol {
    
    static let reuseID : String = "item"
    
    private lazy var imageView : UIImageView = AppUIFuncs.createImageView()
    
    internal lazy var label : UILabel! = AppUIFuncs.createLabel(alignment: .center, font: UIFont.systemFont(ofSize: 16, weight: .bold))
    
    private let origin : CGPoint = .zero
    
    func setUpCell(from item: KitStarterItem) -> Void {
        label.text = item.itemName
        imageView.image = UIImage(named: item.image)
        backgroundColor = .appWhite
        layer.cornerRadius = 20
        
        [imageView, label].forEach { addSubview($0) }
        
        activateConstraints()
    }
    
    func getView() -> UIImageView { imageView }
    
    private func activateConstraints() -> Void {
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
}
