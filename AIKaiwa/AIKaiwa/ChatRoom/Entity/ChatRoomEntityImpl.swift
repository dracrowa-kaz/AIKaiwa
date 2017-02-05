//
//  ChatRoomEntityImpl.swift
//  Kuri
//
//  Created by kaz on 2017/2/3.
//  Copyright © 2016年 kaz. All rights reserved.
//

import Foundation

struct ChatRoomEntityImpl: ChatRoomEntity {
    let id: Int
    var chatRoomContentEntityArray: [ChatRoomContentEntity]
}

struct ChatRoomContentEntityImpl: ChatRoomContentEntity {
    let id: Int
    let person: personTypeEnum 
    let chatContentType: chatContentTypeEnum 
    let chatContent: String 
}
