typealias ViewProtocol = ViewInterface
protocol ViewInterface: class {
    func showProgress()
    func hideProgress()
}

extension ViewInterface {

    func showProgress() {
        //Show progress indicator
    }

    func hideProgress() {
        //Hide progress indicator
    }
}
