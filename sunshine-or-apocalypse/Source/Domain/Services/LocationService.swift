//
//  LocationService.swift
//  sunshine-or-apocalypse
//
//  Created by Nick Piscopio on 4/30/24.
//

import CoreLocation
import Foundation

class LocationService {
    func getCoordinates(fromAddressString address: String, completionHandler: @escaping (Coordinates, Bool) -> Void) {
        if !isDescriptiveAddress(address: address) {
            completionHandler(Coordinates(lat: 0.0, long: 0.0), true)
            return
        }
        
        CLGeocoder().geocodeAddressString(address) {
            let coordinates = $0?.first?.location?.coordinate
            // Even if the address is valid (like Portland, MN), sometimes Apple returns the lat/long as 0.0, 0.0.
            // In this instance we will error out.
            let lat = coordinates?.latitude ?? 0.0
            let long = coordinates?.longitude ?? 0.0
            let error: Bool = $1 != nil || (lat == 0.0 && long == 0.0)
            completionHandler(Coordinates(lat: lat, long: long), error)
        }
    }
    
    func isDescriptiveAddress(address: String) -> Bool {
        // CoreLocation seems to return invalid temperatures if you just put in a state like, "Alaska".
        // Because of this I decided to place a check to make sure there is at least a comma in the string the user types in.
        // If there is not, then we should error out.
        address.components(separatedBy: ",").count > 1
    }
}
