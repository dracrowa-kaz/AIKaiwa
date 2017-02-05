//
//  ChatRoomTranslator.swift
//  Kuri
//
//  Created by kaz on 2017/2/3.
//  Copyright © 2016年 kaz. All rights reserved.
//


import Foundation

protocol ChatRoomTranslator {
    func translate(from model: ChatRoomContentModel) -> ChatRoomContentEntity
    func translate(from entity: ChatRoomEntity) -> ChatRoomModel
}
