//
//  XCTestCase+Extensions.swift
//  MMATests
//
//  Created by Cesar Mejia Valero on 4/18/23.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated, Potential memory leak", file: file, line: line)
        }
    }
}
