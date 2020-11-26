

import UIKit

class PostItemViewCell: UITableViewCell {

    @IBOutlet weak var imgHeader: UIImageView!
    
    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var lbDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(model : PostModel){
        lbTitle.text = model.title
        let arr =  model.date.components(separatedBy: "T")

        lbDate.text = arr[0]
        imgHeader.sd_setImage(with: URL(string: model.featured_image), placeholderImage: UIImage.init(named: "ic_place_holder"))
    }

}
