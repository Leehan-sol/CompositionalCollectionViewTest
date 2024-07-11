## ⚙️ Compositional Layout CollectionView
Compositional Layout으로 컬렉션뷰를 그리고, Diffable Data Source를 이용해 유연하게 데이터를 관리할 수 있게 구현했습니다.

<br/>

<div align="center">
  <img width="200" height="400" alt="image" src="https://github.com/Leehan-sol/CompositionalCollectionViewTest/assets/139109343/eeb90fad-45a8-48ee-99ec-f42582ace5a4">
</div>

<br/>

## 🛠️ Workflow

1. **Hashable 프로토콜을 준수하는 Model 정의 및 컬렉션뷰 셀, 헤더뷰 등록** <br/>
```swift
enum Item: Hashable {
    case category(UIImage)
    case product(ProductModel)
    case circleItem(CircleItemModel)
}

struct Section: Hashable {
    let id: String
}

private var collectionView: UICollectionView!

collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
collectionView.register(ItemHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
```
2. **init(sectionProvider: @escaping SectionProvider)을 이용해 레이아웃 설정** <br/>
```swift
collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: getLayout())

func getLayout() -> UICollectionViewCompositionalLayout {
   let layout = UICollectionViewCompositionalLayout { (section, env) -> NSCollectionLayoutSection? in
       switch section {
       case 0:
           let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1.0))
           let item = NSCollectionLayoutItem(layoutSize: itemSize)
           item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
                
           let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(68))
           let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
           let section = NSCollectionLayoutSection(group: group)
           section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 14, bottom: 16, trailing: 14)
           return section
       default:
           return nil
       }    
   }
   // DecorationView
   layout.register(DecoView.self, forDecorationViewOfKind: "DecoView")
   return layout       
}
```
   

3. **DiffableDataSource 제네릭 클래스를 사용해 DataSource 연결**  <br/>
dataSource를 전역변수로 생성하고 컬렉션뷰에 연결하고, cellProvider 클로저를 이용해 각 case에 맞는 셀을 반환해 생성합니다.
```swift
var dataSource: UICollectionViewDiffableDataSource<Section, Item>

override func viewDidLoad() {
    super.viewDidLoad()
    setDataSource()
    setSnapshot()
}

dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: self.collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
    switch item {
    case .category:
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as? CategoryCell else { return UICollectionViewCell() }
        cell.titleButton.setImage(self.categoryImage[indexPath.item], for: .normal)
        return cell
```

4. **Snapshot으로 데이터의 current state 생성, apply() 메서드를 사용해 데이터 표시**  <br/>
```swift
func setSnapshot() {
   var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()

   snapshot.appendSections([Section(id: "category")])
   let categoryItems = categoryImage.map { Item.category($0) }
   snapshot.appendItems(categoryItems, toSection: Section(id: "category"))
        
   snapshot.appendSections([Section(id: "product")])
   let productItems = productList.map { Item.product($0) }
   snapshot.appendItems(productItems, toSection: Section(id: "product"))
        
   dataSource?.apply(snapshot)
}
```


<br/>

## 🤓 Takeaway
- Compositional Layout을 사용하지 않을 때는 스크롤뷰에 컬렉션뷰를 여러개 만들어서 이어붙이는 방법이나, 컬렉션뷰와 테이블뷰를 동시에 사용해야해서 코드도 복잡하고 개발 피로도도 높았는데, 
Compositional Layout을 적용하니 깔끔하고 간단한 방법으로 복잡한 화면을 구현할 수 있었다.
또한 각 섹션과 항목의 레이아웃을 한눈에 파악할 수 있고, 유지 보수가 용이해졌다.
- 기존의 테이블뷰나 컬렉션뷰에서 사용하던 DataSource에서는 `reloadData()`를 통해 구현했던 것을 DiffableDataSource를 사용해서 DataSource가 변경될때마다 레이아웃과 데이터가 자동으로 동기화되도록 코드를 짜니, reloadData() 메서드를 수동으로 호출할 필요가 없어져서 코드가 훨씬 간결해지고 유지보수가 용이해졌다.

