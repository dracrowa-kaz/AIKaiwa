//
//  ChatRoomPresenter.swift
//  Kuri
//
//  Created by kaz on 2017/2/3.
//  Copyright © 2016年 kaz. All rights reserved.
//

import Foundation

protocol ChatRoomPresenter: class {
    func getChatHistory()->ChatRoomModel?
    func sendText(text:String)->Bool
}
