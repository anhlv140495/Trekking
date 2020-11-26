

import Foundation
import UIKit

protocol CustomInfoWindowViewDelegate : class {
    func tappedViewBackground(_ view: CustomInforWindowViewController)
}

class CustomInforWindowViewController: UIView,UIGestureRecognizerDelegate {
    var content : String = ""
    
    @IBOutlet weak var imageInforWindow: UIImageView!
    @IBOutlet weak var lblTittile: UILabel!
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var directionButton: UIButton!

    @IBOutlet weak var imgRatingStar: UIImageView!
    
    @IBOutlet weak var lbContent: UILabel!
    
    
    @IBOutlet weak var lbHeight: UILabel!
    @IBOutlet weak var imgInfo: UIImageView!
    var delegate : CustomInfoWindowViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initView()
    }
    
    
    @IBAction func tapInfoButton(_ sender: Any) {
        self.delegate?.tappedViewBackground(self)

    }
    
    @IBAction func backgroundButton(_ sender: Any) {
        self.delegate?.tappedViewBackground(self)
    }
    func initView() {
    }
}
