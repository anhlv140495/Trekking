

import Foundation
import UIKit

struct DataDemo {
    
    static let imageNames:[String] = [
        "ic_bach_moc",
        "ic_demo_hoa",
        "ic_demo_phusilung",
        "ic_demo2",
        "ic_fansipan",
        "ic_demo_phusilung",
        "ic_putaleng",
        "ic_lao_than",
        "ic_lao_than",
        "ic_lung_cung",
        "ic_putaleng",
        "ic_putaleng",
        "ic_lung_cung",
        "ic_putaleng",
        "ic_putaleng",
        "ic_demo_hoa",
        "ic_demo_phusilung",
        "ic_fansipan",
        "ic_demo_phusilung",
        "ic_fansipan",
    ]
    
    static let images:[UIImage] = Self.imageNames.compactMap { _ in UIImage(named: "ic_5_star")! }

    static let imageUrls:[URL] = Self.imageNames.compactMap {_ in 
        URL(string: "https://www.upsieutoc.com/images/2020/10/07/_8240125.jpg")! }
}
