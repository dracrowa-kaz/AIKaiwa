//
//  ChatRoomRepository.swift
//  Kuri
//
//  Created by kaz on 2017/2/3.
//  Copyright © 2016年 kaz. All rights reserved.
//

protocol ChatRoomRepository {
    func fetch() throws -> ChatRoomEntity
    func saveChat(entity: ChatRoomContentEntity)->Bool
}
