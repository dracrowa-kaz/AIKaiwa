//
//  ChatRoomTranslatorImpl.swift
//  Kuri
//
//  Created by kaz on 2017/2/3.
//  Copyright © 2016年 kaz. All rights reserved.
//

import Foundation

struct ChatRoomTranslatorImpl: ChatRoomTranslator {
    
func translate(from model: ChatRoomContentModel) -> ChatRoomContentEntity {
    return ChatRoomContentEntityImpl(id: model.id, person: model.person, chatContentType: model.chatContentType, chatContent:model.chatContent)
}
    
func translate(from entity: ChatRoomEntity) -> ChatRoomModel {
    var modelArray = [ChatRoomContentModel]()
    for contentEntity in entity.chatRoomContentEntityArray {
        let contentModel = ChatRoomContentModelImpl(id: contentEntity.id, person: contentEntity.person, chatContentType: contentEntity.chatContentType, chatContent: contentEntity.chatContent)
        modelArray.append(contentModel)
    }
    return ChatRoomModelImpl(id: entity.id, chatRoomContentModelArray: modelArray)
}
}
