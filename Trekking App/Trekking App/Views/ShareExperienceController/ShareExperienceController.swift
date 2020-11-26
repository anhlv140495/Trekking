

import UIKit
import ObjectMapper
class ShareExperienceController: BaseController {
    @IBOutlet weak var tableView: UITableView!
    let trekStoryboard = UIStoryboard(name: "TrekStoryBoard", bundle: nil)
    var postList : [PostModel] = [PostModel]()
    var refreshControl : UIRefreshControl?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Chia sẻ kinh nghiệm"
        tableView?.register(UINib(nibName: "PostItemViewCell", bundle: nil), forCellReuseIdentifier: "PostItemViewCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        tableView.tableFooterView = UIView()

        self.getDataPost()
        self.initUI()
        // Do any additional setup after loading the view.
    }
    
    func initUI() {
        
       
        refreshControl = UIRefreshControl()
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl!)
        }
        refreshControl?.addTarget(self, action: #selector(handleRefresh(sender:)), for: .valueChanged)
        
    }
    
    @objc func handleRefresh(sender : UIRefreshControl) {
        postList.removeAll()
        self.getDataPost()
        DispatchQueue.main.async {
             self.tableView.refreshControl?.endRefreshing()
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
                        if(noti.terms?.category?.trekModel == nil){
                            self.postList.append(noti)

                        }
                    }
                    
                }
                self.tableView.reloadData()
                
                
            }
        }
        
    }

}


extension ShareExperienceController : UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(postList.count > 0){
            return (postList.count)

        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "PostItemViewCell", for: indexPath) as! PostItemViewCell
             
               cell.selectionStyle = .none
        cell.setupData(model: postList[indexPath.row])
               return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailPostVC = trekStoryboard.instantiateViewController(withIdentifier: "DetailPostController")as! DetailPostController
        detailPostVC.model = postList[(indexPath.row)]
        detailPostVC.hidesBottomBarWhenPushed = true
               self.navigationController?.pushViewController(detailPostVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 108
       }
    
}
