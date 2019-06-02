//
//  Copyright © 2019 An Tran. All rights reserved.
//

import UIKit

protocol ImageListPresentationLogic {
    func show(imageList: ImageListResponse)
    func show(error: Error)
}

class ImageListPresenter: ImageListPresentationLogic {

    weak var viewController: ImageListDisplayLogic?

    func show(imageList: ImageListResponse) {
        viewController?.show(imageList: imageList.hits)
    }

    func show(error: Error) {
        viewController?.show(error: error)
    }
}
