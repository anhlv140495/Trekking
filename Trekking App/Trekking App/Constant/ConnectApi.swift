//
//  ConnectApi.swift
//  Trekking App
//
//  Created by LE VIET ANH on 11/25/20.
//



import UIKit
import Alamofire
import ACProgressHUD_Swift



//var remoteConfig: RemoteConfig!
var alert : UIAlertView?

class ConnectApi: NSObject, UIAlertViewDelegate {
    
    fileprivate static let instance:ConnectApi = ConnectApi()
    
    
    static func share() -> ConnectApi {
        return .instance
    }
    
  
    
    func getDataFromWP(typeLoan: Int, url : String, show : Bool = true, resultDict : @escaping (_ response : Any?, _ msgError :(message : String, code : String)?) -> Void) {
        
        let header : HTTPHeaders?
       
        let token = ""
       
            header = ["Authorization":"Basic",
                "Accept": "application/json"
            ]
        

        if show {
            let progressView = ACProgressHUD.shared
            progressView.progressText = "Vui lòng chờ...."
            progressView.shadowColor = UIColor.clear
            progressView.showHUD()
        }
        
        
        let start = CACurrentMediaTime()
        //let manager = Alamofire.SessionManager.default
        
        let manager = Alamofire.Session.default

        manager.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: header).validate().response { (result) in
            if show {
                ACProgressHUD.shared.hideHUD()
            }
            
            let end = CACurrentMediaTime()
            
           
            
            if (result.error != nil) {
                handleError(response: result.response, error: result.error! as NSError, data: result.data)
                
                return
            }
            
            if (result.data?.toDictionary()) != nil{
                
                if ((result.data?.toDictionary()?["posts"]) != nil) {
                    
                        resultDict(result.data?.toDictionary()?["posts"], nil)

                    
                    return
                }else{
                    resultDict(nil,(ERROR_NIL_DATA,""))
                    return
                }
                
            } else {
                resultDict(nil,(ERROR_NOT_RESPONSE,""))
                return
            }
        }
        
        func handleError(response: HTTPURLResponse? ,error: NSError,data: Data?) {
            
            if error.isNoInternetConnectionError() {
                // Xử lý lỗi xảy ra do không có internet connection
                
                resultDict(nil,(ERROR_NOT_CONNECT,""))
                
                return
            } else if error.isRequestTimeOutError() {
                // Xử lý lỗi xảy ra do request timeout
                
                resultDict(nil,(ERROR_TIME_OUT,""))
                
                return
            } else if (response?.isServerNotFound())! {
                // Xử lý lỗi 404
                resultDict(nil, (ERROR_404,""))
                return
            } else if (response?.isInternalError())! {
                
                resultDict(nil, (ERROR_500,""))
                
                // Xử lý lỗi 500
                return
            }
            
            // Xử lý các user-define error khác
            // Unwrap data để không bị crash khi data `nil`
            if let data = data {
                handleCustomError(error, data)
                return
            }
            
            // Chỗ này dành cho lỗi trả về mà không có data, thường rất ít gặp nhưng cũng nên handle, có thể định nghĩa 1 static message để show lên
        }
        
        func handleCustomError(_ error: NSError,_ data: Data) {
            // Thường khi có lỗi xảy ra, backend phía SS sẽ trả về json có dạng { error: "mô tả về lỗi" }
            // Nếu không thể parse được data này thì có thể định nghĩa 1 static message để show lên
            
            if let errorData = data.toDictionary() {
                if (errorData[ERROR] as? String) != nil {
                    // Show message này cho user
                    
                    resultDict(nil, (errorData[ERROR] as! String,""))
                    return
                } else {
                    // Show static message đã được định nghĩa sẵn
                    
                    resultDict(nil,(ERROR_MESSAGE_FORMAT_STRING,""))
                    return
                }
            } else {
                // Show static message đã định nghĩa sẵn
                
                resultDict(nil,(ERROR_MESSAGE_FORMAT_DICT,""))
                return
            }
        }
        
    }
    
    
    
    
}



extension Data {
    func toDictionary() -> [String : Any]? {
        do {
            let result : Any? = try JSONSerialization.jsonObject(with: self, options: .allowFragments)
            return result as? [String : Any]
        } catch {
            return nil
        }
    }
}

extension NSError {
    func isNoInternetConnectionError() -> Bool {
        return (self.domain == NSURLErrorDomain && (self.code == NSURLErrorNotConnectedToInternet || self.code == NSURLErrorNetworkConnectionLost || self.code == NSURLErrorCannotConnectToHost));
    }
    
    func isRequestTimeOutError() -> Bool {
        return self.code == NSURLErrorTimedOut
    }
}

extension HTTPURLResponse {
    func isServerNotFound() -> Bool {
        return self.statusCode == 404
    }
    
    func isInternalError() -> Bool {
        return self.statusCode == 500
    }
    
}

extension String {
    func toErrorString(message : String?) -> (message : String, code : String) {
        if self == "E000" || self == "EOOO" {
            if message != nil && message != "" {
                return (message!,"E000")
            }
            return (ERROR_FAIL,self)
        } else if self == "I000" || self == "IOOO" {
            if message != nil && message != "" {
                return (message!,"I000")
            }
            return (ERROR_DATA,self)
        } else if self == "I001" || self == "IOO1" {
            if message != nil && message != "" {
                return (message!,"I001")
            }
            return (ERROR_TOKEN,self)
        } else if self == "E001" || self == "EOO1" {
            if message != nil && message != "" {
                return (message!,"E001")
            }
            return (ERROR_PERMISSON,self)
        } else if self == "E002" || self == "EOO2" {
            if message != nil && message != "" {
                return (message!,"E002")
            }
            return (ERROR_EXIST,self)
        } else if self == "E003" || self == "EOO3" {
            if message != nil && message != "" {
                return (message!, "E003")
            }
            return ("Đã Tồn Tại Hợp Đồng Vay",self)
        }  else if self == "E004" || self == "EOO4" {
            if message != nil && message != "" {
                return (message!, "E004")
            }
            return ("Tạo mới bản ghi bị lỗi",self)
        }  else if self == "E005" || self == "EOO5" {
            if message != nil && message != "" {
                return (message!, "E005")
            }
            return ("Update bản ghi bị lỗi",self)
        }  else if self == "E006" || self == "EOO6" {
            if message != nil && message != "" {
                return (message!, "E006")
            }
            return ("Tài Khoản Đã Bị Khóa",self)
        }  else if self == "E007" || self == "EOO7" {
            if message != nil && message != "" {
                return (message!, "E007")
            }
            return ("Tài Khoản Đã Bị Khóa Vĩnh viễn",self)
        } else if self == "E008" || self == "EOO8" {
            if message != nil && message != "" {
                return (message!, "E008")
            }
            return ("Đã Có Người Khác Đồng Ý Cho Vay",self)
        } else if self == "E009" || self == "EOO9" {
            if message != nil && message != "" {
                return (message!, "E009")
            }
            return ("Error description vimo'",self)
        } else {
            if message != nil && message != "" {
                return (message!, self)
            }
            return (ERROR_CONNECT,self)
        }
    }
}


