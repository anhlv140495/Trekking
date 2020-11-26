

import UIKit
import WebKit
class DetailPostController: BaseController {

    @IBOutlet weak var lbTitle: UILabel!
    
    @IBOutlet weak var webview: WKWebView!
    var model : PostModel?
    var id : String = "0"
    
    @IBOutlet weak var lbDate: UILabel!
    
    @IBOutlet weak var webviewHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Thông tin bài viết"
        self.getContent()
        self.navigationController?.navigationBar.isHidden = false

    }
    
    func getContent(){
        self.lbTitle.text = model?.title
        let arr =  model?.date.components(separatedBy: "T")
        lbDate.text = arr![0]
        self.webview.navigationDelegate = self
        self.webview.configuration.preferences.javaScriptEnabled = true
        var headerString = "<header><meta name='viewport' content='width=device-width,initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0'></header>"
        var htmlString  = model!.content.replace(target: "480", withString: "100%")
        headerString.append(htmlString)
        //headerString.append(model!.content)
        self.webview.loadHTMLString(headerString, baseURL: nil)
    }

}


extension DetailPostController : WKNavigationDelegate{
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.webview.evaluateJavaScript("document.readyState", completionHandler: { (complete, error) in
            if complete != nil {
                self.webview.evaluateJavaScript("document.body.scrollHeight", completionHandler: { (height, error) in
                    self.webviewHeight.constant = (height as! CGFloat)
                    print(height)
                })
            }

            })
    }
}


extension String
{
    func replace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}
