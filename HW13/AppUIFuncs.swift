import Foundation
import UIKit

final class AppUIFuncs {
    
    static func createLabel(alignment: NSTextAlignment, font: UIFont, text: String? = nil) -> UILabel {
        .config(view: UILabel()) {
            $0.textAlignment = alignment
            $0.font = font
            $0.text = text
            $0.numberOfLines = .zero
        }
    }
    
    static func createImageView() -> UIImageView {
        .config(view: UIImageView()) { image in
            image.contentMode = .scaleAspectFill
            image.clipsToBounds = true
            image.isUserInteractionEnabled = true
        }
    }
}
