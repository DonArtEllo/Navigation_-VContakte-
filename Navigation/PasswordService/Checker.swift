//
//  Checker.swift
//  Navigation
//
//  Created by Артем on 18.06.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import Foundation

class Checker {
    
    static let shared = Checker()
    
    private let login: String = "h4ckerK1tten"
    private let password: String = "StronKP4ss"
    
    private init() {
        
    }
    
    func compareHashedStrings(loginPasswordSHA256 trierString: String, time: Date) -> Bool {
        
        let checkerString = (login + "\(time.hashValue)" + password).sha256()
        
        if trierString == checkerString {
            return true
        } else {
            return false
        }
    }
    
}
