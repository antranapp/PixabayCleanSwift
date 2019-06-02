//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

protocol ImageListRoutingLogic {
    func show(_ image: Image)
}

class ImageListRouter: ImageListRoutingLogic {
    weak var viewController: ImageListViewController?

    func show(_ image: Image) {
        let imageDetailViewController = ImageDetailViewController(image: image)
        viewController?.navigationController?.pushViewController(imageDetailViewController, animated: true)
    }
}
