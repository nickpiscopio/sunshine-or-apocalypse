//
//  WeatherTitleUtilTests.swift
//  sunshine-or-apocalypseTests
//
//  Created by Nick Piscopio on 4/30/24.
//

@testable import sunshine_or_apocalypse
import XCTest

class WeatherTitleUtilTests: XCTestCase {
    func testColdApocalpyseTitle() {
        let title = WeatherTitleUtil.getTitle(fromTemp: -1, backupDescription: "Cold")
        XCTAssertEqual(title, "Apocalypse 🧊")
    }
    
    func testHotApocalpyseTitle() {
        let title = WeatherTitleUtil.getTitle(fromTemp: 101, backupDescription: "Hot")
        XCTAssertEqual(title, "Apocalypse 🔥")
    }
    
    func testColdTitle() {
        let title = WeatherTitleUtil.getTitle(fromTemp: 0, backupDescription: "Time to ice skate")
        XCTAssertEqual(title, "Time To Ice Skate")
    }
    
    func testHotTitle() {
        let title = WeatherTitleUtil.getTitle(fromTemp: 100, backupDescription: "Cloudy with a chance of meatballs")
        XCTAssertEqual(title, "Cloudy With A Chance Of Meatballs")
    }
}
