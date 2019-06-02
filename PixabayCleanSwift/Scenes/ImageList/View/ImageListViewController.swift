//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Kingfisher
import UIKit

protocol ImageListDisplayLogic: class {
    func show(imageList: [Image])
    func show(error: Error)
}

class ImageListViewController: UIViewController {

    // MARK: Properties

    // Public

    @IBOutlet weak var searchTermTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var images: [Image] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // Private

    private var activityIndicator: UIActivityIndicatorView!

    private var interactor: ImageListBusinessLogic?
    private var router: ImageListRoutingLogic?

    // MARK: Setup

    init() {
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        let interactor = ImageListInteractor()
        let presenter = ImageListPresenter()
        let router = ImageListRouter()
        self.interactor = interactor
        self.router = router
        interactor.presenter = presenter
        presenter.viewController = self
        router.viewController = self
    }

    // MARK: Lifecyles

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        searchTermTextField.delegate = self

        activityIndicator = UIActivityIndicatorView(style: .gray)
        let rightButton = UIBarButtonItem(customView: activityIndicator)
        navigationItem.rightBarButtonItem = rightButton

        tableView.register(UINib(nibName: "ImageListTableViewCell", bundle: nil), forCellReuseIdentifier: "ImageListTableViewCell")

        title = "List"
    }
}

extension ImageListViewController: ImageListDisplayLogic {

    func show(imageList: [Image]) {
        images = imageList
    }

    func show(error: Error) {
        print(error)
    }
}

extension ImageListViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else {
            return false
        }

        interactor?.fetchImageList(request: ImageListRequest(searchTerm: text))

        textField.resignFirstResponder()
        return true
    }
}

extension ImageListViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
}

extension ImageListViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ImageListTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ImageListTableViewCell") as! ImageListTableViewCell

        let image = images[indexPath.row]
        cell.titleLabel?.text = image.previewURL
        guard let url = URL(string: image.previewURL) else {
            return cell
        }

        cell.previewImageView.kf.setImage(with: url)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let image = images[indexPath.row]
        router?.show(image)
    }
}
