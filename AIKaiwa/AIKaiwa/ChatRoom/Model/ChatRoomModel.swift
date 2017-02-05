//
//  ChatRoomModel.swift
//  Kuri
//
//  Created by kaz on 2017/2/3.
//  Copyright © 2016年 kaz. All rights reserved.
//

import Foundation

protocol ChatRoomModel {
    var id: Int { get }
    var chatRoomContentModelArray: [ChatRoomContentModel] { get }
}

protocol ChatRoomContentModel {
    var id: Int { get }
    var person: personTypeEnum { get }
    var chatContentType: chatContentTypeEnum { get }
    var chatContent: String { get }
}
