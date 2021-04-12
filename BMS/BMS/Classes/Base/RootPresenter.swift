//
//  RootPresenter.swift
//  BMS
//
//  Created by Varun Dudeja on 12/04/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Foundation

final class RootPresenter {

    // MARK: - Private properties -

    private unowned let view: RootViewProtocol
    private let interactor: RootInteractorProtocol
    private let wireframe: RootWireframeProtocol

    // MARK: - Lifecycle -

    init(view: RootViewProtocol, interactor: RootInteractorProtocol, wireframe: RootWireframeProtocol) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension RootPresenter: RootPresenterProtocol {
}
