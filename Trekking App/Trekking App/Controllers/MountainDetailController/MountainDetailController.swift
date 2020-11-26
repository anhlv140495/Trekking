

import UIKit
import ImageSlideshow
class MountainDetailController: BaseController {
    
    var sdWebImageSource = [SDWebImageSource(urlString: "https://trekkingguidle.files.wordpress.com/2020/10/86495125_633701044128968_512161926491406336_o-750x400-2.jpg")!, SDWebImageSource(urlString: "https://www.upsieutoc.com/images/2020/10/07/Du-lich-Ta-Lien-Son-Lai-Chau-mytour-6.jpg")!, SDWebImageSource(urlString: "https://www.upsieutoc.com/images/2020/10/07/ta-lien-son-4.jpg")!, SDWebImageSource(urlString: "https://www.upsieutoc.com/images/2020/10/07/trekking-ta-lien-son-12.jpg")!, SDWebImageSource(urlString: "https://www.upsieutoc.com/images/2020/10/07/IMG_2100.md.jpg")!]
    
    @IBOutlet weak var imgSlideShow: ImageSlideshow!
    var model : MountainModel?
    
    @IBOutlet weak var lbLocation: UILabel!
    
    @IBOutlet weak var lbTime: UILabel!
    
    @IBOutlet weak var lbDifficult: UILabel!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbContent: UILabel!
    
    @IBOutlet weak var lbHeight: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // Do any additional setup after loading the view.
    }
    
    
    func setupUI(){
        sdWebImageSource.removeAll()
        for i  in model!.image_urls{
            sdWebImageSource.append(SDWebImageSource(urlString:i)!)
        }
        
        self.navigationController?.navigationBar.isHidden = false

        imgSlideShow.slideshowInterval = 5.0
        imgSlideShow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        imgSlideShow.contentScaleMode = UIViewContentMode.scaleAspectFill

        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.lightGray
        pageControl.pageIndicatorTintColor = UIColor.black
        imgSlideShow.pageIndicator = pageControl

        // optional way to show activity indicator during image load (skipping the line will show no activity indicator)
        imgSlideShow.activityIndicator = DefaultActivityIndicator()
        imgSlideShow.delegate = self

        // can be used with other sample sources as `afNetworkingSource`, `alamofireSource` or `sdWebImageSource` or `kingfisherSource`
        imgSlideShow.setImageInputs(sdWebImageSource)

        lbContent.text = model?.content
        lbTime.text  = model?.time
        lbLocation.text = model?.location
        lbTitle.text = model?.name
        lbHeight.text = model?.height
        
        switch model?.difficult {
        case 3:
            lbDifficult.text = "Trung bình"
            break
        case 4:
            lbDifficult.text = "Trung bình - Khó"
            break
        case 5:
            lbDifficult.text = "Khó"
            break
        default:
            break
        }
        
    }
    
    @objc func didTap() {
        let fullScreenController = imgSlideShow.presentFullScreenController(from: self)
        // set the activity indicator for full screen controller (skipping the line will show no activity indicator)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .white, color: nil)
    }

}


extension MountainDetailController: ImageSlideshowDelegate {
    func imageSlideshow(_ imageSlideshow: ImageSlideshow, didChangeCurrentPageTo page: Int) {
        print("current page:", page)
    }
    
    
}
