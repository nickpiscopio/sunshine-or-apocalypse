//
//  LocationServiceTests.swift
//  sunshine-or-apocalypseTests
//
//  Created by Nick Piscopio on 4/30/24.
//

@testable import sunshine_or_apocalypse
import XCTest

class LocationServiceTests: XCTestCase {
    var locationService: LocationService!

    override func setUpWithError() throws {
        locationService = LocationService()
    }

    override func tearDownWithError() throws {
        locationService = nil
    }
    
    func testDescriptiveAddress() {
        let address1 = locationService.isDescriptiveAddress(address: "Portland")
        XCTAssertFalse(address1)
        
        let address2 = locationService.isDescriptiveAddress(address: "Portland, OR")
        XCTAssertTrue(address2)
        
        let address3 = locationService.isDescriptiveAddress(address: "Portland, OR, USA")
        XCTAssertTrue(address3)
    }
}
