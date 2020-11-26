

import UIKit

class AlbumCollectionViewCell: UICollectionViewCell {
   
    
    @IBOutlet weak var viewContent: UIView!
    
    
    @IBOutlet weak var imgThumb: UIImageView!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
//        viewContent.layer.borderColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
//        viewContent.layer.shadowOffset = CGSize(width: 0, height: 2)
//        viewContent.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.5).cgColor
//        viewContent.layer.shadowOpacity = 0.5
//        viewContent.layer.shadowRadius = 3
//        viewContent.layer.cornerRadius = 8
//        viewContent.addViewBorder(borderColor: #colorLiteral(red: 0.6, green: 0.6, blue: 0.6, alpha: 1), borderWith: 1.0, borderCornerRadius: 5)

        
    }
    
    
    func setupData(model : AlbumModel){
        self.lbTitle.text = model.albumName
        self.imgThumb.sd_setImage(with: URL(string: model.albumThumb), placeholderImage: UIImage.init(named: "ic_place_holder"))
    }
    
    override func layoutSubviews() {
            // cell rounded section
            self.layer.cornerRadius = 15.0
            self.layer.borderWidth = 5.0
            self.layer.borderColor = UIColor.clear.cgColor
            self.layer.masksToBounds = true
            
            // cell shadow section
            self.contentView.layer.cornerRadius = 15.0
            self.contentView.layer.borderWidth = 5.0
            self.contentView.layer.borderColor = UIColor.clear.cgColor
            self.contentView.layer.masksToBounds = true
            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowOffset = CGSize(width: 0, height: 0.0)
            self.layer.shadowRadius = 6.0
            self.layer.shadowOpacity = 0.6
            self.layer.cornerRadius = 15.0
            self.layer.masksToBounds = false
            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
        }
}

extension UIView {
    @IBInspectable var dropShadow: Bool {
        set{
            if newValue {
                layer.shadowColor = UIColor.black.cgColor
                layer.shadowOpacity = 0.4
                layer.shadowRadius = 1
                layer.shadowOffset = CGSize.zero
            } else {
                layer.shadowColor = UIColor.clear.cgColor
                layer.shadowOpacity = 0
                layer.shadowRadius = 0
                layer.shadowOffset = CGSize.zero
            }
        }
        get {
            return layer.shadowOpacity > 0
        }
    }
}
