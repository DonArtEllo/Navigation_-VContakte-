//
//  Coordonator.swift
//  Navigation
//
//  Created by Артем on 11.07.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

protocol Coordinator: AnyObject {
    var coordinators: [Coordinator] { get set }
}
