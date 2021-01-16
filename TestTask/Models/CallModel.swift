//
//  CallModel.swift
//  TestTask
//
//  Created by Stanislav Slipchenko on 15.01.2021.
//

import Foundation

// MARK: - CallModel
class CallModel: Codable {
    var requests: [Request]

    init(requests: [Request]) {
        self.requests = requests
    }
}

// MARK: - Request
class Request: Codable {
    let id, state: String
    let client: Client
    let type, created: String
    let businessNumber: BusinessNumber
    let origin: String
    let favorite: Bool
    let duration: String

    init(id: String, state: String, client: Client, type: String, created: String, businessNumber: BusinessNumber, origin: String, favorite: Bool, duration: String) {
        self.id = id
        self.state = state
        self.client = client
        self.type = type
        self.created = created
        self.businessNumber = businessNumber
        self.origin = origin
        self.favorite = favorite
        self.duration = duration
    }
}

// MARK: - BusinessNumber
class BusinessNumber: Codable {
    let number, label: String

    init(number: String, label: String) {
        self.number = number
        self.label = label
    }
}

// MARK: - Client
class Client: Codable {
    let address: String
    let name: String?

    enum CodingKeys: String, CodingKey {
        case address
        case name = "Name"
    }

    init(address: String, name: String?) {
        self.address = address
        self.name = name
    }
}
