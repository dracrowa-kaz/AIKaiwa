//
//  ChatRoomUseCase.swift
//  Kuri
//
//  Created by kaz on 2017/2/3.
//  Copyright © 2016年 kaz. All rights reserved.
//

import Foundation

protocol ChatRoomUseCase {
    func fetch() throws -> ChatRoomModel
    func saveChat(model: ChatRoomContentModel)->Bool
}
