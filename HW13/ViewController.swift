import UIKit

final class ViewController: UIViewController {

    private lazy var scrollView : UIScrollView = {
        $0.addSubview(scrollContentView)
        return $0
    }(UIScrollView(frame: view.frame))
    
    private lazy var scrollContentView : UIView = {
        .config(view: $0) { [weak self] v in
            v.backgroundColor = .white
            guard let self = self else { return }
            [
                self.pageTitleLabel,
                self.moneyTitle,
                self.collectionView,
                self.characteristicTitleLabel,
                self.tableView,
                self.startLocationTitleLabel,
                self.startLocationSegmentedControl,
                self.tutorialTitleLabel,
                self.switchControl,
                self.playButton
            ].forEach { v.addSubview($0) }
        }
    }(UIView())
    
    private lazy var pageTitleLabel : UILabel = AppUIFuncs.createLabel(
        alignment: .center,
        font: UIFont.systemFont(ofSize: 26, weight: .semibold),
        text: "Create your own character!")
    
    private lazy var moneyTitle : UILabel = AppUIFuncs.createLabel(
        alignment: .center,
        font: UIFont.systemFont(ofSize: 20, weight: .thin),
        text: "You have 300$")
    
    private lazy var origin = CGPoint(x: 10, y: 10)
    
    private lazy var collectionView : UICollectionView = {
        .config(view: $0) { [weak self] collection in
            guard let self = self else { return }
            collection.dataSource = self
            collection.delegate = self
            collection.register(ItemCell.self, forCellWithReuseIdentifier: ItemCell.reuseID)
            collection.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.reuseID)
            collection.bouncesVertically = false
            collection.backgroundColor = .clear
            collection.addSubview(boxView)
        }
    }(UICollectionView(frame: .zero, collectionViewLayout: createCollectionCompositionalLayout()))
    
    internal let collectionData = KitStarterSection.getMockSectionData()
    
    internal let reusableData = HeaderItem.getMockHeaderData()
    
    private lazy var boxImage : UIImageView = AppUIFuncs.createImageView()
    
    private lazy var boxLabel : UILabel = AppUIFuncs.createLabel(alignment: .center, font: UIFont.systemFont(ofSize: 18, weight: .semibold), text: "Inventory")
    
    private lazy var boxView : UIView = {
        .config(view: $0) { [weak self] v in
            guard let self = self else { return }
            
            boxImage.image = UIImage(named: "package")
            [boxImage, boxLabel].forEach { v.addSubview($0) }
            NSLayoutConstraint.activate([
                boxImage.topAnchor.constraint(equalTo: v.topAnchor),
                boxImage.leadingAnchor.constraint(equalTo: v.leadingAnchor, constant: 10),
                boxImage.trailingAnchor.constraint(equalTo: v.trailingAnchor, constant: -10),
                boxImage.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: -25),
                
                boxLabel.topAnchor.constraint(equalTo: boxImage.bottomAnchor, constant: 5),
                boxLabel.leadingAnchor.constraint(equalTo: boxImage.leadingAnchor),
                boxLabel.trailingAnchor.constraint(equalTo: boxImage.trailingAnchor),
                boxLabel.heightAnchor.constraint(equalToConstant: 20),
                boxLabel.bottomAnchor.constraint(equalTo: v.bottomAnchor)
            ])
        }
    }(UIView())
    
    private lazy var characteristicTitleLabel : UILabel = AppUIFuncs.createLabel(alignment: .center, font: UIFont.systemFont(ofSize: 26, weight: .regular), text: "Set up the characteristics:")
    
    internal lazy var tableData : [(header: String, items: [TableItem])] = TableItem.getMockData()
    
    private lazy var tableView : UITableView = {
        .config(view: $0) { [weak self] t in
            guard let self = self else { return }
            t.register(TableCell.self, forCellReuseIdentifier: TableCell.reuseID)
            t.dataSource = self
            t.delegate = self
            t.separatorStyle = .none
        }
    }(UITableView())
    
    private lazy var startLocationTitleLabel : UILabel = AppUIFuncs.createLabel(alignment: .center, font: UIFont.systemFont(ofSize: 26, weight: .regular), text: "Choose your start location:")
    
    private let segmentedControlImages : [UIImage] = [UIImage(named: "cityscape")!, UIImage(named: "farm")!, UIImage(named: "desert")!]
    
    private lazy var startLocationSegmentedControl : UISegmentedControl = { [weak self] s in
        guard let self = self else { return s }
        s.translatesAutoresizingMaskIntoConstraints = false
        s.addTarget(self, action: #selector(segmentedControlAction(sender: )), for: .valueChanged)
        for i in 0..<segmentedControlImages.count {
            s.insertSegment(with: segmentedControlImages[i], at: i, animated: true)
        }
        s.layer.borderWidth = 1.0
        s.layer.borderColor = UIColor.lightGray.cgColor
        s.selectedSegmentTintColor = .appSegmented
        s.selectedSegmentIndex = 1
        return s
    }(UISegmentedControl())
    
    @objc
    private func segmentedControlAction(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: print("You will spawn in the city")
        case 1: print("You will spawn in the village")
        default: print("You will spawn in the desert")
        }
    }
    
    private lazy var tutorialTitleLabel : UILabel = AppUIFuncs.createLabel(alignment: .left, font: UIFont.systemFont(ofSize: 26, weight: .regular), text: "Tutorial:")
    
    private lazy var switchControl : UISwitch = { [weak self] s in
        guard let self = self else { return s }
        s.translatesAutoresizingMaskIntoConstraints = false
        s.setOn(false, animated: true)
        s.addTarget(self, action: #selector(switchAction(sender: )), for: .valueChanged)
        s.onTintColor = .black
        s.thumbTintColor = .white
        return s
    }(UISwitch())
    
    @objc
    private func switchAction(sender: UISwitch) {
        switch sender.isOn {
        case true: print("tutorial is ON")
        default: print("tutorial is OFF")
        }
    }
    
    private lazy var playButton : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setTitle("Play", for: .normal)
        $0.setTitleColor(.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 26, weight: .semibold)
        $0.layer.cornerRadius = 30
        $0.backgroundColor = .appGreen
        return $0
    }(UIButton(primaryAction: UIAction(handler: { _ in
        print("play the game")
    })))
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appWhite
        view.addSubview(scrollView)
        
        activateConstraints()
    }
    
    private func activateConstraints() -> Void {
        NSLayoutConstraint.activate([
            scrollContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            scrollContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            pageTitleLabel.topAnchor.constraint(equalTo: scrollContentView.topAnchor, constant: 30),
            pageTitleLabel.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor, constant: 30),
            pageTitleLabel.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor, constant: -30),
            
            moneyTitle.topAnchor.constraint(equalTo: pageTitleLabel.bottomAnchor, constant: 20),
            moneyTitle.leadingAnchor.constraint(equalTo: pageTitleLabel.leadingAnchor),
            moneyTitle.trailingAnchor.constraint(equalTo: pageTitleLabel.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: moneyTitle.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: scrollContentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: scrollContentView.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 800),
            
            boxView.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 520),
            boxView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            boxView.widthAnchor.constraint(equalToConstant: 140),
            boxView.heightAnchor.constraint(equalTo: boxView.widthAnchor),
            
            characteristicTitleLabel.topAnchor.constraint(equalTo: boxView.bottomAnchor, constant: 30),
            characteristicTitleLabel.leadingAnchor.constraint(equalTo: pageTitleLabel.leadingAnchor),
            characteristicTitleLabel.trailingAnchor.constraint(equalTo: pageTitleLabel.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: characteristicTitleLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: pageTitleLabel.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: pageTitleLabel.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 330),
            
            startLocationTitleLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 30),
            startLocationTitleLabel.leadingAnchor.constraint(equalTo: pageTitleLabel.leadingAnchor),
            startLocationTitleLabel.trailingAnchor.constraint(equalTo: pageTitleLabel.trailingAnchor),
            
            startLocationSegmentedControl.topAnchor.constraint(equalTo: startLocationTitleLabel.bottomAnchor, constant: 30),
            startLocationSegmentedControl.leadingAnchor.constraint(equalTo: pageTitleLabel.leadingAnchor),
            startLocationSegmentedControl.trailingAnchor.constraint(equalTo: pageTitleLabel.trailingAnchor),
            startLocationSegmentedControl.heightAnchor.constraint(equalToConstant: 40),
            
            tutorialTitleLabel.topAnchor.constraint(equalTo: startLocationSegmentedControl.bottomAnchor, constant: 30),
            tutorialTitleLabel.leadingAnchor.constraint(equalTo: pageTitleLabel.leadingAnchor, constant: 17),
            tutorialTitleLabel.trailingAnchor.constraint(equalTo: scrollContentView.centerXAnchor),
            
            switchControl.topAnchor.constraint(equalTo: tutorialTitleLabel.topAnchor),
            switchControl.leadingAnchor.constraint(equalTo: scrollContentView.centerXAnchor),
            switchControl.trailingAnchor.constraint(equalTo: pageTitleLabel.trailingAnchor),
            
            playButton.topAnchor.constraint(equalTo: switchControl.bottomAnchor, constant: 30),
            playButton.centerXAnchor.constraint(equalTo: scrollContentView.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 180),
            playButton.heightAnchor.constraint(equalToConstant: 80),
            playButton.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor, constant: -30)
        ])
    }
    
    @objc
    func panGest(sender: UIPanGestureRecognizer) {
        guard let panView = sender.view else { return }

        let newOrigin = sender.translation(in: view)
        
        panView.center = CGPoint(x: panView.center.x + newOrigin.x, y: panView.center.y + newOrigin.y)
        sender.setTranslation(.zero, in: view)
        switch sender.state {
        case .ended:
            UIView.animate(withDuration: 0.5) { [weak self] in
                guard let self = self else { return }
                panView.frame.origin = self.origin
            }
//            if panView.frame.intersects(boxView.frame) {
//                print("delete view")
//            }
        default: break
        }
    }
}
