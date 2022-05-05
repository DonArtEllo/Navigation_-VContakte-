//
//  NetworkService.swift
//  Navigation
//
//  Created by Артем on 18.04.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

enum AppConfiguration: String, CaseIterable {
    
    case people8 = "https://swapi.dev/api/people/7"
    case starship3 = "https://swapi.dev/api/starships/2"
    case planet5 = "https://swapi.dev/api/planets/4"
}

var appConfiguration: AppConfiguration? = nil

struct NetworkService {
    
    public static func getData() {
        let urlSession = URLSession(configuration: .default)
        
        guard let url = URL(string: appConfiguration!.rawValue) else {
            return
        }
        
        urlSession.dataTask(with: url) { (data, response, error) in
            
            guard let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200 else {
                guard let error = error else {
                    print("UNKNOWN ERROR")
                    return
                }
                print("ERROR: \(error.localizedDescription)") // ERROR: The Internet connection appears to be offline.
                return
            }
            print("DATA: ")
            
            if let data = data {
                let str = String(decoding: data, as: UTF8.self)
                print(str)
            }
            print("RESPONSE ALL HEADERFIELDS: \(urlResponse.allHeaderFields as! [String: Any])")
            print("RESPONSE STATUS: \(urlResponse.statusCode)")
            
        }.resume()
        
    }
    
}
