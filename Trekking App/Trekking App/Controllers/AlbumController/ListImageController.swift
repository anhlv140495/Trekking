

import UIKit
import SDWebImage
import ImageViewer_swift
class ListImageController: BaseController {
    lazy var layout = GalleryFlowLayout()
    var images:[UIImage] = DataDemo.images.compactMap {
        $0.resize(targetSize: .thumbnail)
    }
    
    var albumModel : AlbumModel = AlbumModel()
    lazy var collectionView:UICollectionView = {
        // Flow layout setup
        let cv = UICollectionView(
            frame: .zero, collectionViewLayout: layout)
        cv.register(
            ThumbCell.self,
            forCellWithReuseIdentifier: ThumbCell.reuseIdentifier)
        cv.dataSource = self
        return cv
    }()
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor
            .constraint(equalTo: view.topAnchor)
            .isActive = true
        collectionView.leadingAnchor
            .constraint(equalTo: view.leadingAnchor)
            .isActive = true
        collectionView.trailingAnchor
            .constraint(equalTo: view.trailingAnchor)
            .isActive = true
        collectionView.bottomAnchor
            .constraint(equalTo: view.bottomAnchor)
            .isActive = true
        collectionView.backgroundColor = .white
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Gallery"
        SDImageCache.shared.clearMemory()
        // Do any additional setup after loading the view.
    }
    

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateLayout(view.frame.size)
    }
    
    private func updateLayout(_ size:CGSize) {
        if size.width > size.height {
            layout.columns = 4
        } else {
            layout.columns = 3
        }
    }
    
    override func viewWillTransition(
        to size: CGSize,
        with coordinator: UIViewControllerTransitionCoordinator) {
        updateLayout(size)
    }
    
   

}



extension ListImageController:UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int) -> Int {
        return (albumModel.images.count)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell:ThumbCell = collectionView
            .dequeueReusableCell(withReuseIdentifier: ThumbCell.reuseIdentifier,
                                 for: indexPath) as! ThumbCell
        cell.imageView.sd_setImage(with: URL(string: (albumModel.images[indexPath.row])), placeholderImage: UIImage.init(named: "ic_place_holder"))
        
        let imageUrls:[URL] = (albumModel.images.compactMap {i in
                                        URL(string: i)! })
        // Setup Image Viewer with [URL]
        cell.imageView.setupImageViewer(
            urls: imageUrls,
            initialIndex: indexPath.item,
            options: [
                .theme(.light),
                
            ],
            from: self)
        
        return cell
    }
}

//extension ListImageController:RightNavItemDelegate {
//    func imageViewer(_ imageViewer: ImageCarouselViewController, didTapRightNavItem index: Int) {
//        print("TAPPED", index)
//    }
//}
