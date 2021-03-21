//
//  ValuedCodableTests.swift
//  ValuedCodableTests
//
//  Created by 安程 on 2021/3/21.
//

import XCTest
@testable import ValuedCodable

struct TestModel: Codable {
    let nickname: String
    let age: Int
    let isMale: Bool
    let avatar: String?
    let isBoss: Bool?
}
class ValuedCodableTests: XCTestCase {

    let decoder = JSONDecoder()

    func testEmptyJSON() throws {
        let json = """
        {
        }
        """
        let model = try? decoder.decode(TestModel.self, from: json.data(using: .utf8)!)
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.nickname, "")
        XCTAssertEqual(model?.age, 0)
        XCTAssertEqual(model?.isMale, false)
        XCTAssertNil(model?.avatar)
        XCTAssertNil(model?.isBoss)
    }

    func testTrueJSON() throws {
        let json = """
        {
            "nickname": "ancheng",
            "age": 20,
            "isMale": true,
            "avatar": "avatar",
            "isBoss": true
        }
        """
        let model = try? decoder.decode(TestModel.self, from: json.data(using: .utf8)!)
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.nickname, "ancheng")
        XCTAssertEqual(model?.age, 20)
        XCTAssertEqual(model?.isMale, true)
        XCTAssertEqual(model?.avatar, "avatar")
        XCTAssertEqual(model?.isBoss, true)
    }

    func testWrongJSON() throws {
        let json = """
        {
            "nickname": 20,
            "age": "",
            "isMale": 1,
            "isBoss": 123
        }
        """
        let model = try? decoder.decode(TestModel.self, from: json.data(using: .utf8)!)
        XCTAssertNotNil(model)
        XCTAssertEqual(model?.nickname, "20")
        XCTAssertEqual(model?.age, 0)
        XCTAssertEqual(model?.isMale, false)
        XCTAssertNil(model?.avatar)
        XCTAssertEqual(model?.isBoss, nil)
    }
}
