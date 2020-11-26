

import Foundation
import ObjectMapper

struct PostModel: Mappable {
    var id : Int = 0
    var date : String   = ""
    var title : String = ""
    var content: String  = ""
    var featured_image: String  = ""

    var terms : TermModel?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        date <- map["date"]
        title <- map["title"]
        content <- map["content"]
        featured_image <- map["featured_image"]
        terms <- map["terms"]

    }
}

struct TermModel: Mappable {
    var category : CategoryModel?
    
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        category <- map["category"]

    }
}

