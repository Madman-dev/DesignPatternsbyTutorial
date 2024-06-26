//
//  Model.swift
//  MVVMCrashCourse
//
//  Created by Porori on 5/21/24.
//

import Foundation

struct UsersResponse: Codable {
    let data: [PersonResponse]
}

struct PersonResponse: Codable {
    let email: String
    let firstName: String
    let lastName: String
}
