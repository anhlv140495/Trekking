

import UIKit

class MenuTrekController: UIViewController {
    let trekStoryboard = UIStoryboard(name: "TrekStoryBoard", bundle: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tapAlbum(_ sender: Any) {
        let albumVC = trekStoryboard.instantiateViewController(withIdentifier: "AlbumController")as! AlbumController
        albumVC.hidesBottomBarWhenPushed = true
               self.navigationController?.pushViewController(albumVC, animated: true)
    }
    
    @IBAction func tapShareExp(_ sender: Any) {
        let expVC = trekStoryboard.instantiateViewController(withIdentifier: "ShareExperienceController")as! ShareExperienceController
        expVC.hidesBottomBarWhenPushed = true
               self.navigationController?.pushViewController(expVC, animated: true)
    }
    

    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false

    }
}
