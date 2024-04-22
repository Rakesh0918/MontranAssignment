//
//  Model.swift
//  MontranAssignment
//
//  Created by Rakesh Sharma on 21/04/24.
//

import Foundation


struct PetResEntiry: Codable {
    let pets: [Pets]?
}

struct Pets: Codable {
    let image_url: String?
    let title: String?
    let content_url: String?
    let date_added: String?
}


struct ConfigResEntity: Codable {
    let settings: Settings
}

struct Settings: Codable {
    let isChatEnabled : Bool?
    let isCallEnabled : Bool?
    let workHours : String?
}
