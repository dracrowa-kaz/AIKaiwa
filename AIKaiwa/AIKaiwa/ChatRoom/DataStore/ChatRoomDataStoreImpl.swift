//
//  ChatRoomDataStoreImpl.swift
//  Kuri
//
//  Created by kaz on 2017/2/3.
//  Copyright © 2016年 kaz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import Alamofire_Synchronous

struct ChatRoomDataStoreImpl: ChatRoomDataStore {
    
    func fetch() throws -> ChatRoomEntity {
        if dataStore == nil {
            // you can write get entity method
            let entity = ChatRoomContentEntityImpl(id: 0, person: .robot, chatContentType: chatContentTypeEnum.text, chatContent: "こんにちは!")
            let entity2 = ChatRoomContentEntityImpl(id: 1, person: .robot, chatContentType: chatContentTypeEnum.text, chatContent: "お元気ですか？")
            let entity3 = ChatRoomContentEntityImpl(id: 2, person: .robot, chatContentType: chatContentTypeEnum.text, chatContent: "話しかけてくださいね！")
            dataStore = ChatRoomEntityImpl(id: 0, chatRoomContentEntityArray: [entity,entity2,entity3])
        }
        return dataStore!
    }
    
    func saveChat(entity: ChatRoomContentEntity) -> Bool {
        dataStore?.chatRoomContentEntityArray.append(entity)
        //Get text from AI.
        let returnText = sendTextToAIServer(text: entity.chatContent)
        let lastID = dataStore?.chatRoomContentEntityArray.last?.id
        let new_entity = ChatRoomContentEntityImpl(id: lastID!, person: .robot, chatContentType: .text, chatContent: returnText)
        dataStore?.chatRoomContentEntityArray.append(new_entity)
        return true
    }
    
    //Send text to server and get return text.
    func sendTextToAIServer(text:String)->String {
        let url = "https://api.apigw.smt.docomo.ne.jp/dialogue/v1/dialogue?APIKEY=xxx"
        let parameters = [
            "utt": text,
            "context": "",
            "place": "東京",
            "mode": "dialog"
        ]
        let data = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        let jsonBatch:String = String(data: data, encoding: .utf8)!
        let response = Alamofire.request(url, method: .post, parameters: [:], encoding: jsonBatch, headers: [:]).responseJSON(options: .allowFragments)
        guard let value = response.result.value else {
            return "通信に失敗しました！"
        }
        return JSON(value)["utt"].stringValue
    }
}

extension String: ParameterEncoding {
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}
    
var dataStore: ChatRoomEntityImpl?

