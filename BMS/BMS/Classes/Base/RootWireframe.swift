//
//  RootWireframe.swift
//  BMS
//
//  Created by Varun Dudeja on 12/04/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class RootWireframe: BaseWireframe {

    // MARK: - Private properties -

    private let storyboard = UIStoryboard(name: "Root", bundle: nil)

    // MARK: - Module setup -

    init() {
        let moduleViewController = storyboard.instantiateViewController(ofType: RootViewController.self)
        super.init(viewController: moduleViewController)

        let interactor = RootInteractor()
        let presenter = RootPresenter(view: moduleViewController, interactor: interactor, wireframe: self)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension RootWireframe: RootWireframeProtocol {
}
