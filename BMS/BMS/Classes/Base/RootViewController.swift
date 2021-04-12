//
//  RootViewController.swift
//  BMS
//
//  Created by Varun Dudeja on 12/04/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: RootPresenterProtocol!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

// MARK: - Extensions -

extension RootViewController: RootViewProtocol {
}
