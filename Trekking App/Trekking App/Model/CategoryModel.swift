

import Foundation
import ObjectMapper

struct CategoryModel: Mappable {
    var trekModel : TrekkingModel?
    var jsonModel : JsonModel?
   
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        trekModel <- map["Trekking"]
        jsonModel <- map["Json"]
        
       
    }
}
