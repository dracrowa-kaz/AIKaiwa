//
//  ChatRoomEntity.swift
//  Kuri
//
//  Created by kaz on 2017/2/3.
//  Copyright © 2016年 kaz. All rights reserved.
//

import Foundation

protocol ChatRoomEntity {
    var id: Int { get }
    var chatRoomContentEntityArray: [ChatRoomContentEntity] {
        get
        set
    }
}

protocol ChatRoomContentEntity {
    var id: Int { get }
    var person: personTypeEnum { get }
    var chatContentType: chatContentTypeEnum { get }
    var chatContent: String { get }
}

enum personTypeEnum {
    case male
    case famale
    case robot
}

enum chatContentTypeEnum{
    case text
    case sticker
}
