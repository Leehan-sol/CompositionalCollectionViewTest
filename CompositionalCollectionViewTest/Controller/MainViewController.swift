//
//  ViewController.swift
//  CompositionalCollectionViewTest
//
//  Created by hansol on 2024/02/02.
//

import UIKit

// MARK: - Model
struct Section: Hashable {
    let id: Int
}

enum Item: Hashable {
    case category
    case product(ProductModel)
    case circleItem(CircleItemModel)
}

// MARK: - UIViewController
class MainViewController: UIViewController {
    private let searchBar = UISearchBar()
    private var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>
    
    private let categoryImage = [#imageLiteral(resourceName: "프리미엄블랙"), #imageLiteral(resourceName: "모텔"), #imageLiteral(resourceName: "호텔"), #imageLiteral(resourceName: "펜션,풀빌라"), #imageLiteral(resourceName: "리조트"), #imageLiteral(resourceName: "캠핑,글램핑"), #imageLiteral(resourceName: "게하,한옥"), #imageLiteral(resourceName: "반나절호캉스"), #imageLiteral(resourceName: "공간대여"), #imageLiteral(resourceName: "렌터카"), #imageLiteral(resourceName: "레저,티켓"), #imageLiteral(resourceName: "맛집")]
    
    private let productList =
    [ProductModel(image: #imageLiteral(resourceName: "호텔2"), title: "[반짝특가] 라마다 서울 신도림", rating: "1.5", reviewCount: "2,621", location: "신도림역 5분 거리", price: "169,400"),
     ProductModel(image: #imageLiteral(resourceName: "호텔1"), title: "★반짝특가★ 오크우드 프리미엄 호텔", rating: "3.4", reviewCount: "3,521", location: "송도 센트럴 파크 앞", price: "125,900"),
     ProductModel(image: #imageLiteral(resourceName: "호텔3"), title: "[반짝특가] 호텔 리베라", rating: "4.5", reviewCount: "798",location: "청담역 도보 5분", price: "113,700"),
     ProductModel(image: #imageLiteral(resourceName: "호텔4"), title: "[반짝특가] 킨텍스 바이 호텔", rating: "5.0", reviewCount: "1,589",location: "대전역 차량 5분", price: "198,200"),]
    
    private let circleItemList =
    [CircleItemModel(image: #imageLiteral(resourceName: "호텔4"), title: "지금, 여기"),
     CircleItemModel(image: #imageLiteral(resourceName: "호텔2"), title: "경주여행"),
     CircleItemModel(image: #imageLiteral(resourceName: "호텔1"), title: "강원여행"),
     CircleItemModel(image: #imageLiteral(resourceName: "헤더"), title: "제주여행"),
     CircleItemModel(image: #imageLiteral(resourceName: "dog"), title: "반려견과 함께")
    ]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setCV()
        setupSearchBar()
    }
    
    // MARK: - Method
    func setUI() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: getLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
    }
    
    func setCV() {
      //  collectionView.dataSource = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: "ProductCell")
        collectionView.register(CircleItemCell.self, forCellWithReuseIdentifier: "CircleItemCell")
        collectionView.register(ItemHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        collectionView.collectionViewLayout = getLayout()
    }
    
    func setupSearchBar() {
        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.delegate = self
        navigationItem.titleView = searchBar
    }
    
    
    func getLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
            switch section {
                // Title 섹션
            case 0:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(68))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 14, bottom: 16, trailing: 14)
                return section
                
                // Product 섹션
            case 1:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(240), heightDimension: .estimated(316))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 10, trailing: 20)
                section.orthogonalScrollingBehavior = .continuous
                return section
                
                // CircleItem 섹션
            case 2:
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(80), heightDimension: .estimated(130))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                // SupplementaryView
                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50.0))
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = 10
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 25, bottom: 24, trailing: 25)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [header]
                section.supplementariesFollowContentInsets = false
                
                let decorationView = NSCollectionLayoutDecorationItem.background(elementKind: "DecoView")
                section.decorationItems = [decorationView]
                return section
            default:
                return nil
            }
            
        }
        // DecorationView
        layout.register(DecoView.self, forDecorationViewOfKind: "DecoView")
        return layout
        
    }
    
}



// MARK: - UICollectionViewDataSource
extension MainViewController {
    // 1. func numberOfSections(in collectionView: UICollectionView) -> Int { }
    // 2. func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { }
    // 3. func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { }


    
    // HeaderView
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderView", for: indexPath) as! ItemHeaderView
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let currentSection = Item(rawValue: indexPath.section)
        
        switch currentSection {
        case .category:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell()}
            cell.titleButton.setImage(categoryImage[indexPath.row], for: .normal)
            return cell
            
        case .product:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as? ProductCell else { return UICollectionViewCell() }
            
            let product = productList[indexPath.row]
            cell.productImageView.image = product.image
            cell.contentTitleLabel.text = product.title
            cell.ratingLabel.text = product.rating
            cell.reviewCountLabel.text = "(\(product.reviewCount))"
            cell.locationLabel.text = product.location
            cell.priceLabel.text = product.price
            
            return cell
            
        case .circleItem:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CircleItemCell", for: indexPath) as? CircleItemCell else { return UICollectionViewCell() }
            
            let item = circleItemList[indexPath.row]
            cell.circleImageView.image = item.image
            cell.circleItemLabel.text = item.title
            
            return cell
        case .none:
            return UICollectionViewCell()
        }
    }
    
    
}

// MARK: - UISearchBarDelegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // 검색어가 변경될 때마다 호출되는 메서드
        // 여기서 검색 로직을 구현하고, 검색 결과를 업데이트합니다.
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 사용자가 검색 버튼을 눌렀을 때 호출되는 메서드
        // 여기서 검색 로직을 구현하고, 검색 결과를 업데이트합니다.
        searchBar.resignFirstResponder() // 키보드를 숨깁니다.
    }
}
