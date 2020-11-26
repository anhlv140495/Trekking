

import Foundation
import ObjectMapper

struct MountainModel: Mappable {
    var id : Int = 0
    var difficult : Int   = 0
    var featured_image : String = ""
    var image_urls: [String]  = [""]
    var lat: Double   = 0
    var lng : Double = 0
    var name : String  = ""
    var content : String = ""
    var height : String  = ""
    var time : String  = ""
    var location : String = ""
    

    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        difficult <- map["difficult"]
        featured_image <- map["featured_image"]
        image_urls <- map["image_urls"]
        lat <- map["lat"]
        lng <- map["lng"]
        name <- map["name"]
        content <- map["content"]
        location <- map["location"]
        time <- map["time"]
        height <- map["height"]
        difficult <- map["difficult"]
    }
}
