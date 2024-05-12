import UIKit

final class TableCell: UITableViewCell, CellProtocol {
    
    static let reuseID : String = "table"
    
    internal var label: UILabel! = nil
    
    private lazy var slider : UISlider = { [weak self] s in
        guard let self = self else { return s }
        s.addTarget(self, action: #selector(sliderAction(sender: )), for: .touchUpInside)
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }(UISlider())
    
    @objc
    private func sliderAction(sender: UISlider) {
        print("value of selected scale is \(sender.value)")
    }
    
    func setUpCell(from item: TableItem) {
        slider.minimumValueImage = UIImage(named: item.minimumImage)
        slider.minimumValue = 0
        slider.maximumValueImage = UIImage(named: item.maximumImage)
        slider.maximumValue = 100
        slider.setThumbImage(UIImage(named: item.thumbImage), for: .normal)
        slider.value = Float.random(in: 0...100)
        slider.minimumTrackTintColor = .black
        
        selectionStyle = .none
        addSubview(slider)
        activateConstraints()
    }
    
    private func activateConstraints() {
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: topAnchor),
            slider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            slider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            slider.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
