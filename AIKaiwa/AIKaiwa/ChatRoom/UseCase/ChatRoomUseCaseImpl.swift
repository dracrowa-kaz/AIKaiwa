//
//  ChatRoomUseCaseImpl.swift
//  Kuri
//
//  Created by kaz on 2017/2/3.
//  Copyright © 2016年 kaz. All rights reserved.
//

import Foundation

struct ChatRoomUseCaseImpl: ChatRoomUseCase {
    private let repository: ChatRoomRepository
    private let translator: ChatRoomTranslator
    
    init(
        repository: ChatRoomRepository, 
        translator: ChatRoomTranslator
        ) {
        self.repository = repository
        self.translator = translator
    }
    
    func fetch() throws -> ChatRoomModel {
        let entity = try repository.fetch()
        let model = translator.translate(from: entity)
        return model
    }
    
    func saveChat(model: ChatRoomContentModel) -> Bool {
        let entity = translator.translate(from: model)
        return repository.saveChat(entity: entity) 
    }
}
