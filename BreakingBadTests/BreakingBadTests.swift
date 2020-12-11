//
//  BreakingBadTests.swift
//  BreakingBadTests
//
//  Created by Kevin Reid on 10/12/2020.
//

import XCTest
@testable import BreakingBad
class BreakingBadTests: XCTestCase {
    
    
    enum TestError: Error {
        case fileNotFound
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testJSONFileNotFound() throws {
            let bundle = Bundle(for: type(of: self))
        guard bundle.url(forResource:"json", withExtension: "json") != nil else {
            XCTFail("Missing File: test.json")
            throw TestError.fileNotFound
        }
    }
    
    func testJsonArrayCount() throws {
        let path =  Bundle(for: type(of: self)).path(forResource:"json", ofType: "json")
        let data = try Data(contentsOf: URL(fileURLWithPath: path!))
            let response = try JSONDecoder().decode([Details].self, from: data)
            XCTAssertTrue(response.count > 0)
       }
    
    func testGetFirstCharacterNameWhichShouldBeWalterWhite() throws {
        let path =  Bundle(for: type(of: self)).path(forResource:"json", ofType: "json")
        let data = try Data(contentsOf: URL(fileURLWithPath: path!))
        let response = try JSONDecoder().decode([Details].self, from: data)
        XCTAssertEqual(response[0].name, "Walter White")
    }
    
    func testForNameThatIsNotInTheListHelloWorld() throws {
        let path =  Bundle(for: type(of: self)).path(forResource:"json", ofType: "json")
        let data = try Data(contentsOf: URL(fileURLWithPath: path!))
        let response = try JSONDecoder().decode([Details].self, from: data)
        let nameNotInTheList  = response.contains(where: {$0.name == "Hello World"})
        XCTAssertEqual(nameNotInTheList, false)
    }

}
