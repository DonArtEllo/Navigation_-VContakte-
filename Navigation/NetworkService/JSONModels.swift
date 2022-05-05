//
//  JSONModels.swift
//  Navigation
//
//  Created by Артем on 05.05.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

// MARK: - 1.1
struct Todos: Codable {
    let userID, id: Int
    let title: String
    let completed: Bool

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, completed
    }
}

