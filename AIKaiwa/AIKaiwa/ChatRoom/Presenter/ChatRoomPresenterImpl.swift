//
//  ChatRoomPresenterImpl.swift
//  Kuri
//
//  Created by kaz on 2017/2/3.
//  Copyright © 2016年 kaz. All rights reserved.
//

import Foundation
import SCLAlertView
import SVProgressHUD

class ChatRoomPresenterImpl: ChatRoomPresenter {
    private weak var view: ChatRoomViewControllerOutput?
    private let wireframe: ChatRoomWireframe
    private let useCase: ChatRoomUseCase
    
    init(
        view: ChatRoomViewControllerOutput,
        wireframe: ChatRoomWireframe,
        useCase: ChatRoomUseCase
        ) {
        self.view = view
        self.useCase = useCase
        self.wireframe = wireframe
    }
    
    func getChatHistory() -> ChatRoomModel? {
        do{
            //throw NSError(domain: "errorメッセージ", code: -1, userInfo: nil)
            return try useCase.fetch()
        }catch{
            print("error when you get data")
            SCLAlertView().showError("Something wrong", subTitle: "Error happen.")
        }
        return nil
    }
    
    func sendText(text: String) -> Bool {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                let lastID = self.getChatHistory()?.chatRoomContentModelArray.last?.id
                let contentModel = ChatRoomContentModelImpl(id:lastID! , person: .male, chatContentType: .text, chatContent: text)
                let result = self.useCase.saveChat(model: contentModel)
                if result {
                    self.view?.chatRefresh()
                }
            }
        }

        return true
    }
    
    func progressStart(){
        SVProgressHUD.setBackgroundColor(UIColor.black)
        SVProgressHUD.setForegroundColor(.orange)
        SVProgressHUD.setBackgroundLayerColor(.clear)
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.show(withStatus: "Loading...")
    }
    
    func progressEnd(){
        SVProgressHUD.dismiss()
    }
}
