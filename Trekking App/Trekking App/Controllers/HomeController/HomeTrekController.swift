

import UIKit
import SnapKit
import ObjectMapper
class HomeTrekController: BaseController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    let trekStoryboard = UIStoryboard(name: "TrekStoryBoard", bundle: nil)
    var postList : [PostModel] = [PostModel]()

    @IBOutlet weak var imgLastestPost: UIImageView!
    var refreshControl : UIRefreshControl?

    @IBOutlet weak var lbDate: UILabel!
    
    @IBOutlet weak var lbLastestTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.register(UINib(nibName: "PostItemViewCell", bundle: nil), forCellReuseIdentifier: "PostItemViewCell")

        self.navigationController?.navigationBar.isHidden = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        getDataPost()
        self.initUI()
//         let data = "\("anhlv1404@gmail.com"):\("Anhlvph03609")".data(using: .utf8)
//
//        let credential = data!.base64EncodedString(options: [])
        // Do any additional setup after loading the view.
    }
    
    
    func initUI() {
        
       
        refreshControl = UIRefreshControl()
        if #available(iOS 10.0, *) {
            scrollView.refreshControl = refreshControl
        } else {
            scrollView.addSubview(refreshControl!)
        }
        refreshControl?.addTarget(self, action: #selector(handleRefresh(sender:)), for: .valueChanged)
        
    }
    
    @objc func handleRefresh(sender : UIRefreshControl) {
        postList.removeAll()
        self.getDataPost()
        DispatchQueue.main.async {
             self.scrollView.refreshControl?.endRefreshing()
          }
    }
    
    func getDataPost(){
        ConnectApi.share().getDataFromWP(typeLoan: 4, url: API_GET_POST_WP, show: true) { (resultDict, error) in
            guard error?.message == nil else {
                self.showMessageError(message: error!.message)
                return
            }
            
            DispatchQueue.main.async { [self] in
                let dict = resultDict as? Array<Any>
                print(dict?.count)
                for item in dict! {
                    if let noti = Mapper<PostModel>().map(JSONObject: item){
                        if(noti.terms?.category?.trekModel != nil){
                            self.postList.append(noti)

                        }
                    }
                    
                }
                self.tableView.reloadData()
                self.lbLastestTitle.text = postList[0].title
                let arr =  postList[0].date.components(separatedBy: "T")

                self.lbDate.text = arr[0]
                self.imgLastestPost.sd_setImage(with: URL(string: postList[0].featured_image), placeholderImage: UIImage.init(named: "ic_place_holder"))
                self.remakeConstraint()

                
            }
        }
    }

    @IBAction func tapDetailHeaderPost(_ sender: Any) {
        let detailPostVC = trekStoryboard.instantiateViewController(withIdentifier: "DetailPostController")as! DetailPostController
        detailPostVC.model = postList[0]
        detailPostVC.hidesBottomBarWhenPushed = true
               self.navigationController?.pushViewController(detailPostVC, animated: true)
    }
    
    func remakeConstraint() {
       // tableView.layoutIfNeeded()
        tableViewHeight.constant = CGFloat(108 * (postList.count - 1))
    }
    

}


extension HomeTrekController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(postList.count > 0){
            return (postList.count - 1)

        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "PostItemViewCell", for: indexPath) as! PostItemViewCell
             
               cell.selectionStyle = .none
        cell.setupData(model: postList[indexPath.row + 1])
               return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailPostVC = trekStoryboard.instantiateViewController(withIdentifier: "DetailPostController")as! DetailPostController
        detailPostVC.model = postList[(indexPath.row + 1)]
        detailPostVC.hidesBottomBarWhenPushed = true
               self.navigationController?.pushViewController(detailPostVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 108
       }
    
}
