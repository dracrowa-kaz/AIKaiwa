//
//  ChatRoomBuilderImpl.swift
//  Kuri
//
//  Created by kaz on 2017/2/3.
//  Copyright © 2016年 kaz. All rights reserved.
//

import UIKit

struct ChatRoomBuilderImpl: ChatRoomBuilder {
    func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ChatRoomViewController") as! ChatRoomViewController
        viewController.inject(
            presenter: ChatRoomPresenterImpl(
                view: viewController,
                wireframe: ChatRoomWireframeImpl(
                    viewController: viewController
                ),
                useCase: ChatRoomUseCaseImpl(
                    repository: ChatRoomRepositoryImpl (
                        dataStore: ChatRoomDataStoreImpl()
                    ),
                    translator: ChatRoomTranslatorImpl()
                )
            )
        )
        return viewController
    }
}
