

import UIKit



class CustomTabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        self.setupController()
        
    }
    

   
    
    func setupController(){
        
          
        let homeVC = HomeTrekController(nibName: "HomeTrekController", bundle: nil)
        homeVC.title = "Ký sự trekking"
        homeVC.tabBarItem.image = UIImage(named: "ic_tab_trek")
        homeVC.tabBarItem.selectedImage = UIImage(named: "ic_tab_trek")
                  let navHome =  UINavigationController(rootViewController: homeVC)
         
        let mapVC = MapController(nibName: "MapController", bundle: nil)
        mapVC.title = "Bản đồ"
        mapVC.tabBarItem.image = UIImage(named: "ic_map")
        mapVC.tabBarItem.selectedImage = UIImage(named: "ic_map")
                  let navMap =  UINavigationController(rootViewController: mapVC)
        
        
        let menuVC = MenuTrekController(nibName: "MenuTrekController", bundle: nil)
        menuVC.title = "Mục lục"
        menuVC.tabBarItem.image = UIImage(named: "ic_menu")
        menuVC.tabBarItem.selectedImage = UIImage(named: "ic_menu")
                  let navMenu =  UINavigationController(rootViewController: menuVC)
                        //self.viewControllers = [navHome, navNoti,navLogin]
                        self.viewControllers = [navHome,navMap,navMenu]

       
          
        
         
         tabBar.tintColor = UIColor.mainColor()
    }
}
