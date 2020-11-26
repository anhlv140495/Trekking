//
//  BaseController.swift
//  Trekking App
//
//  Created by LE VIET ANH on 11/25/20.
//



import Foundation
import UIKit
import PopupDialog
class BaseController: UIViewController {
    
    var isShowNoti :Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setupLeftMenuButton()
       
    }

    func setupLeftMenuButton() {
        let btnLeft = UIButton(type: .custom)
        btnLeft.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        
        if self != self.navigationController?.viewControllers[0] {
            btnLeft.setImage(UIImage.init(named: "ic_back"), for: .normal)
            btnLeft.addTarget(self, action: #selector(touchOnBack), for: .touchUpInside)
            btnLeft.contentHorizontalAlignment = .left
            let leftBarItem = UIBarButtonItem(customView: btnLeft)
            self.navigationItem.leftBarButtonItem = leftBarItem
            
        }
//        else{
//            self.setNavigationBarItem()
//        }
    }
    
    
    
    @objc func touchOnBack() {
        self.navigationController!.popViewController(animated: true)
    }

    
    
}

extension BaseController {
    func setNavigationBarItem() {
//        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu")!)
//        self.slideMenuController()?.removeLeftGestures()
//        self.slideMenuController()?.removeRightGestures()
//        self.slideMenuController()?.addLeftGestures()
//        self.slideMenuController()?.addRightGestures()
    }
    
    func removeNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.rightBarButtonItem = nil
//        self.slideMenuController()?.removeLeftGestures()
//        self.slideMenuController()?.removeRightGestures()
    }
}



extension BaseController{
    func showMessageError(message : String){
        let popVC = PopupAlertController(nibName: "PopUpAlertController", bundle: nil)
        popVC.message = message
        popVC.nameIcon = "ic_wrong"
        
        let popup = PopupDialog(viewController: popVC, buttonAlignment: .horizontal, transitionStyle: .fadeIn, tapGestureDismissal: false)

        present(popup, animated: true, completion: nil)
    }
    
    func showPopupSuccess(message : String, icon: String, textColor : UIColor) {
        let popVC = PopupAlertController(nibName: "PopUpAlertController", bundle: nil)
        popVC.message = message
        popVC.nameIcon = icon
        popVC.textColor = textColor
        //popVC.delegate = self
        let popup = PopupDialog(viewController: popVC, buttonAlignment: .horizontal, transitionStyle: .fadeIn, tapGestureDismissal: false)
        
        present(popup, animated: true, completion: nil)
    }
}


