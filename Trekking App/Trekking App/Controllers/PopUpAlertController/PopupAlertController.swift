

import UIKit
protocol PopupAlertControllerDelegate: NSObjectProtocol {
    func touchInButtonPopup()
}

protocol PopupAlertControllerCoinDelegate: NSObjectProtocol {
    func touchInButtonSuccessPopup()
}

class PopupAlertController: UIViewController {

    
    @IBOutlet var imgIcon: UIImageView!
    
    
    @IBOutlet var lbMessage: UILabel!
    
    
    var nameIcon : String? = ""
    var message : String? = ""
    var textColor : UIColor?
    weak var delegate : PopupAlertControllerDelegate?
    weak var delegateCoin : PopupAlertControllerCoinDelegate?


    override func viewDidLoad() {
        super.viewDidLoad()

        imgIcon.image = UIImage(named: nameIcon!)
        lbMessage.text = message!
        lbMessage.textColor = textColor
        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func tapOk(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: k_Back), object: nil, userInfo: nil)
        //NotificationCenter.default.post(name: NSNotification.Name(rawValue: k_Add_Bank), object: nil, userInfo: nil)
        self.delegate?.touchInButtonPopup()
        self.delegateCoin?.touchInButtonSuccessPopup()
    }
    
}
