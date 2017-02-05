//
//  ChatRoomModelImpl.swift
//  Kuri
//
//  Created by kaz on 2017/2/3.
//  Copyright © 2016年 kaz. All rights reserved.
//

import Foundation

struct ChatRoomModelImpl: ChatRoomModel {
    let id: Int
    let chatRoomContentModelArray: [ChatRoomContentModel]
}

struct ChatRoomContentModelImpl: ChatRoomContentModel {
    let id: Int 
    let person: personTypeEnum
    let chatContentType: chatContentTypeEnum
    let chatContent: String
}
