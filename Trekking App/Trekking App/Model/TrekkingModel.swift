

import Foundation
import ObjectMapper

struct TrekkingModel: Mappable {
    var ID : Int = 0
    var name : String   = ""
    var slug : String = ""
   
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        ID <- map["ID"]
        name <- map["name"]
        slug <- map["slug"]
       
    }
}
