//
//  AIKaiwaTests.swift
//  AIKaiwaTests
//
//  Created by 佐藤和希 on 2/4/17.
//  Copyright © 2017 kaz. All rights reserved.
//

import XCTest
@testable import AIKaiwa

class AIKaiwaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testChatRoomUseCase(){
        let useCase = ChatRoomUseCaseImpl(repository: ChatRoomRepositoryImpl(dataStore:ChatRoomDataStoreImpl()), translator: ChatRoomTranslatorImpl())
        do {
            let fetch = try useCase.fetch()
            XCTAssert(fetch.chatRoomContentModelArray.count > 0)
            
            let lastID = try useCase.fetch().chatRoomContentModelArray.last!.id + 1
            let testModel = ChatRoomContentModelImpl(id: lastID, person: .male, chatContentType: .text, chatContent: "こんにちは!")
            let result = useCase.saveChat(model: testModel)
            XCTAssert(result)
        } catch {
            print("Error!")
        }
    }
    
}
