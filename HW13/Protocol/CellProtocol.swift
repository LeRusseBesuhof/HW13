import Foundation
import UIKit

protocol CellProtocol {
    static var reuseID : String { get }
    var label : UILabel! { get }
}
