

import UIKit

class AlbumController: BaseController {
    let trekStoryboard = UIStoryboard(name: "TrekStoryBoard", bundle: nil)

    var listAlbum : [AlbumModel] = [AlbumModel]()
    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Album ảnh"
        self.navigationController?.navigationBar.isHidden = false

        let nib = UINib(nibName: "AlbumCollectionViewCell", bundle: nil)
        self.albumCollectionView.register(nib, forCellWithReuseIdentifier: "AlbumCollectionViewCell")
        //self.albumCollectionView!.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: "AlbumCollectionViewCell")

        guard let layout = albumCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else
        {
            return
        }
        
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                //constraintLbLoanValue.constant = -80
                
                var cellSize =  CGSize(width:  albumCollectionView.bounds.width/2.5 , height: 208)
                layout.itemSize = cellSize
                //layout.minimumLineSpacing = space
                layout.prepare()  // <-- call prepare before invalidateLayout
                layout.invalidateLayout()
            case 1334:
                print("iPhone 6/6S/7/8")
                var cellSize =  CGSize(width:  albumCollectionView.bounds.width/2.5 + 10, height: 208)
                layout.itemSize = cellSize
                //layout.minimumLineSpacing = space
                layout.prepare()  // <-- call prepare before invalidateLayout
                layout.invalidateLayout()
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                var cellSize =  CGSize(width:  albumCollectionView.bounds.width/2 - 10, height: 208)
                layout.itemSize = cellSize
                //layout.minimumLineSpacing = space
                layout.prepare()  // <-- call prepare before invalidateLayout
                layout.invalidateLayout()
            case 2436:
                var cellSize =  CGSize(width:  albumCollectionView.bounds.width/2 + 10, height: 208)
                layout.itemSize = cellSize
                //layout.minimumLineSpacing = space
                layout.prepare()  // <-- call prepare before invalidateLayout
                layout.invalidateLayout()
            case 2688:
                print("iPhone XS Max")
                var cellSize =  CGSize(width:  albumCollectionView.bounds.width/2 - 10, height: 208)
                layout.itemSize = cellSize
                //layout.minimumLineSpacing = space
                layout.prepare()  // <-- call prepare before invalidateLayout
                layout.invalidateLayout()
            case 1792:
                
                var cellSize =  CGSize(width:  albumCollectionView.bounds.width/2 - 10, height: 208)
                layout.itemSize = cellSize
                //layout.minimumLineSpacing = space
                layout.prepare()  // <-- call prepare before invalidateLayout
                layout.invalidateLayout()
            default:
                print("Unknown")
            }
        }
        self.createAlbum()
    }
    
    
    func createAlbum(){
        var album1 : AlbumModel = AlbumModel()
        album1.albumName = "Lảo Thẩn"
        album1.albumThumb  = "https://live.staticflickr.com/65535/50440822492_caee0281c5_k.jpg"
        album1.images = ["https://live.staticflickr.com/65535/50440822492_caee0281c5_k.jpg","https://live.staticflickr.com/65535/50440822537_83b5695c27_k.jpg","https://live.staticflickr.com/65535/50440822602_e25efd4ad6_k.jpg","https://live.staticflickr.com/65535/50440822647_85c1064fcb_k.jpg","https://live.staticflickr.com/65535/50439951423_7823626adf_k.jpg","https://live.staticflickr.com/65535/50440644241_4ebc164bb6_k.jpg","https://live.staticflickr.com/65535/50439951458_e34368db48_k.jpg","https://live.staticflickr.com/65535/50439951463_8d5b90d3fc_k.jpg","https://live.staticflickr.com/65535/50440644321_b7055ce5cb_k.jpg","https://live.staticflickr.com/65535/50440822767_573fb56a1d_k.jpg","https://live.staticflickr.com/65535/50439951563_3ea889d454_k.jpg","https://live.staticflickr.com/65535/50440822832_750a190499_k.jpg","https://live.staticflickr.com/65535/50440644561_d946b8f6de_k.jpg","https://live.staticflickr.com/65535/50440644606_772a70a357_k.jpg"]
        
        var album2 : AlbumModel = AlbumModel()
        album2.albumName = "PutaLeng"
        album2.albumThumb  = "https://live.staticflickr.com/65535/50440767971_49b6fe03a2_k.jpg"
        album2.images = ["https://live.staticflickr.com/65535/50440767971_49b6fe03a2_k.jpg","https://live.staticflickr.com/65535/50440077593_b36879180f_k.jpg","https://live.staticflickr.com/65535/50440767886_322e8759f7_k.jpg","https://live.staticflickr.com/65535/50440077538_bd700b5315_k.jpg","https://live.staticflickr.com/65535/50440947967_5adbbc740e_k.jpg","https://live.staticflickr.com/65535/50440767756_89c400c16b_k.jpg","https://live.staticflickr.com/65535/50440767716_468f446b0d_k.jpg","https://live.staticflickr.com/65535/50440947907_0fe48e689e_k.jpg","https://live.staticflickr.com/65535/50440767706_9b96aa6f6e_k.jpg","https://live.staticflickr.com/65535/50440947867_5e5a9608b7_k.jpg","https://live.staticflickr.com/65535/50440077383_3c1b10e345_k.jpg","https://live.staticflickr.com/65535/50440077323_5400bbcb7b_k.jpg","https://live.staticflickr.com/65535/50440767581_f3268a66b7_k.jpg","https://live.staticflickr.com/65535/50440947752_fcdbd960ec_k.jpg","https://live.staticflickr.com/65535/50440077153_479d29e427_k.jpg"]
        
        
        var album3 : AlbumModel = AlbumModel()
        album3.albumName = "Bạch Mộc"
        album3.albumThumb  = "https://live.staticflickr.com/65535/50449761283_6b7e040f89_k.jpg"
        album3.images = ["https://live.staticflickr.com/65535/50449761283_6b7e040f89_k.jpg","https://live.staticflickr.com/65535/50449760523_d5a8dab7c9_b.jpg","https://live.staticflickr.com/65535/50450627587_cbd089f85c_b.jpg","https://live.staticflickr.com/65535/50450458336_54170682ae_k.jpg","https://live.staticflickr.com/65535/50450627402_554298d5e2_k.jpg","https://live.staticflickr.com/65535/50449760363_fc81aea26d_k.jpg","https://live.staticflickr.com/65535/50450627612_ad6d91698c_h.jpg","https://live.staticflickr.com/65535/50449760668_7155458f24_h.jpg","https://live.staticflickr.com/65535/50450627767_d50c285d1d_k.jpg","https://live.staticflickr.com/65535/50449760873_ee398d09a1_k.jpg","https://live.staticflickr.com/65535/50449760863_4568eddddc_h.jpg","https://live.staticflickr.com/65535/50450628007_87eb5a7b92_k.jpg","https://live.staticflickr.com/65535/50450628237_45cd0cfe66_k.jpg","https://live.staticflickr.com/65535/50450459011_a1f471eace_k.jpg"]
        
        var album4 : AlbumModel = AlbumModel()
        album4.albumName = "Tà Chì Nhù"
        album4.albumThumb  = "https://live.staticflickr.com/65535/50449708958_53db579dfd_k.jpg"
        album4.images = ["https://live.staticflickr.com/65535/50449708958_53db579dfd_k.jpg","https://live.staticflickr.com/65535/50450577002_e4e90410c2_k.jpg","https://live.staticflickr.com/65535/50450407601_a17f301b21_k.jpg","https://live.staticflickr.com/65535/50450576852_eb4c40adef_k.jpg","https://live.staticflickr.com/65535/50449708803_cc6f57bf0a_k.jpg","https://live.staticflickr.com/65535/50450407496_5e4bf5ed3b_k.jpg","https://live.staticflickr.com/65535/50450407456_f236f583b0_k.jpg","https://live.staticflickr.com/65535/50450576677_8ce987b840_k.jpg","https://live.staticflickr.com/65535/50450576697_141c7ee62f_k.jpg","https://live.staticflickr.com/65535/50449708623_352bef2217_k.jpg","https://live.staticflickr.com/65535/50449708608_834100641f_k.jpg"]
        var album5 : AlbumModel = AlbumModel()
        album5.albumName = "Lùng Cúng"
        album5.albumThumb  = "https://live.staticflickr.com/65535/50442158503_645793613d_k.jpg"
        album5.images = ["https://live.staticflickr.com/65535/50442158503_645793613d_k.jpg","https://live.staticflickr.com/65535/50442852416_05e4a405ba_k.jpg","https://live.staticflickr.com/65535/50442158773_49b272ec69_k.jpg","https://live.staticflickr.com/65535/50443031162_3a8794de5e_k.jpg","https://live.staticflickr.com/65535/50442852236_85d356fd8e_k.jpg","https://live.staticflickr.com/65535/50443031092_24ea755d82_k.jpg","https://live.staticflickr.com/65535/50442158318_eef67d1bca_k.jpg","https://live.staticflickr.com/65535/50442851946_3c90412d09_k.jpg","https://live.staticflickr.com/65535/50442158218_cd2bb2958a_k.jpg"]
        
        var album6 : AlbumModel = AlbumModel()
        album6.albumName = "Tả Liên Sơn"
        album6.albumThumb  = "https://live.staticflickr.com/65535/50450366296_9160b2c539_k.jpg"
        album6.images = ["https://live.staticflickr.com/65535/50450366296_9160b2c539_k.jpg","https://live.staticflickr.com/65535/50449665768_07c5b61893_k.jpg","https://live.staticflickr.com/65535/50450533862_b418289cc7_k.jpg","https://live.staticflickr.com/65535/50450366401_529e95a4a2_k.jpg","https://live.staticflickr.com/65535/50450366421_c065e1a6b6_k.jpg","https://live.staticflickr.com/65535/50449665878_b3885e0128_k.jpg","https://live.staticflickr.com/65535/50449666023_e75c46e4f4_k.jpg","https://live.staticflickr.com/65535/50450366666_10632cee29_k.jpg","https://live.staticflickr.com/65535/50450366671_3bdc39daa4_b.jpg","https://live.staticflickr.com/65535/50449666128_1f7f81102b_k.jpg","https://live.staticflickr.com/65535/50450366776_68b0eeadc5_k.jpg","https://live.staticflickr.com/65535/50450525527_51254febfe_k.jpg","https://live.staticflickr.com/65535/50450525597_3f04187dd2_k.jpg","https://live.staticflickr.com/65535/50450525637_ac5faf40d8_k.jpg","https://live.staticflickr.com/65535/50449657383_972f298801_k.jpg","https://live.staticflickr.com/65535/50449657418_67952457c4_k.jpg"]
        
        listAlbum.append(album1)
        listAlbum.append(album2)
        listAlbum.append(album3)
        listAlbum.append(album4)
        listAlbum.append(album5)
        listAlbum.append(album6)



        self.albumCollectionView.reloadData()
    }
    

    

}


extension AlbumController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 170)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listAlbum.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:"AlbumCollectionViewCell", for: indexPath) as! AlbumCollectionViewCell
        cell.setupData(model: listAlbum[indexPath.row])
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let listImageVC = ListImageController()
        listImageVC.albumModel = self.listAlbum[indexPath.row]
        listImageVC.hidesBottomBarWhenPushed = true
               self.navigationController?.pushViewController(listImageVC, animated: true)
    }
    
    
    
    
}

