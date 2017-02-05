//
//  ChatRoomRepositoryImpl.swift
//  Kuri
//
//  Created by kaz on 2017/2/3.
//  Copyright © 2016年 kaz. All rights reserved.
//

struct ChatRoomRepositoryImpl: ChatRoomRepository {
    private let dataStore: ChatRoomDataStore
    
    init(
        dataStore: ChatRoomDataStore
        ) {
        self.dataStore = dataStore
    }
    
    func fetch() throws -> ChatRoomEntity {
        return try dataStore.fetch()
    }
    
    
    func saveChat(entity: ChatRoomContentEntity) -> Bool {
        return dataStore.saveChat(entity: entity)
    }
}
