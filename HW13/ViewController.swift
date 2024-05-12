import UIKit

final class ViewController: UIViewController {

    private lazy var scrollView : UIScrollView = {
        $0.addSubview(scrollContentView)
        return $0
    }(UIScrollView(frame: view.frame))
    
    private lazy var scrollContentView : UIView = {
        .config(view: $0) { [weak self] v in
            v.backgroundColor = .lightGray
            guard let self = self else { return }
            [self.pageTitleLabel, self.moneyTitle, self.collectionView].forEach { v.addSubview($0) }
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
    
    private lazy var collectionView : UICollectionView = {
        .config(view: $0) { [weak self] collection in
            guard let self = self else { return }
            collection.dataSource = self
            collection.delegate = self
            collection.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCell.reuseID)
            collection.bouncesVertically = false
            collection.backgroundColor = .clear
            [boxImage, boxLabel].forEach {
                collection.addSubview($0)
            }
        }
    }(UICollectionView(frame: .zero, collectionViewLayout: createCollectionCompositionalLayout()))
    
    private let collectionData = KitStarterSection.getMockSectionData()
    
    private let reusableData = HeaderItem.getMockHeaderData()
    
    private lazy var boxImage : UIImageView = AppUIFuncs.createImageView()
    
    private lazy var boxLabel : UILabel = AppUIFuncs.createLabel(alignment: .center, font: UIFont.systemFont(ofSize: 18, weight: .semibold), text: "Inventory")
     
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .appWhite
        view.addSubview(scrollView)
        
        boxImage.image = UIImage(named: "package")
        
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
            collectionView.heightAnchor.constraint(equalToConstant: 650),
            
            boxImage.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 520),
            boxImage.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            boxImage.widthAnchor.constraint(equalToConstant: 100),
            boxImage.heightAnchor.constraint(equalToConstant: 100),
            
            boxLabel.topAnchor.constraint(equalTo: boxImage.bottomAnchor),
            boxLabel.leadingAnchor.constraint(equalTo: boxImage.leadingAnchor),
            boxLabel.trailingAnchor.constraint(equalTo: boxImage.trailingAnchor),
            
            boxLabel.bottomAnchor.constraint(equalTo: scrollContentView.bottomAnchor)
        ])
    }
}

extension ViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionData[section].group.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionData[indexPath.section].group[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCell.reuseID, for: indexPath) as? ItemCell else { return UICollectionViewCell() }
        cell.backgroundColor = .yellow
        cell.setUpCell(from: item)
        return cell
    }
}

extension ViewController : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let item = reusableData[indexPath.section]
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderCell.reuseID, for: indexPath) as? HeaderCell else { return UICollectionReusableView() }
        cell.setUpHeader(from: item)
        return cell
    }
}

extension ViewController {
    private func createCollectionCompositionalLayout() -> UICollectionViewCompositionalLayout {
        
        return UICollectionViewCompositionalLayout(sectionProvider: { section, _ in
            switch section {
            case 3:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(140))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(120), heightDimension: .fractionalHeight(1))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 1)
                
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPagingCentered
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 30, bottom: 0, trailing: 30)
                return section
                
            default:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(140), heightDimension: .absolute(120))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 30)

                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 30, leading: 30, bottom: 20, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [self.createHeaderSize()]
                return section
            }
        })
    }
    
    private func createHeaderSize() -> NSCollectionLayoutBoundarySupplementaryItem {
        
        let headerSize = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(0)), elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        return headerSize
    }
}

