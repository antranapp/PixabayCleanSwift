//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Foundation

struct ImageListRequest {
    var searchTerm: String
}

struct ImageListResponse: Decodable {
    var total: Int
    var totalHits: Int
    var hits: [Image]
}
