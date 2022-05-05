//
//  InfoModel.swift
//  Navigation
//
//  Created by Артем on 05.05.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

protocol InfoViewOutput {
    func getLabelTextFromJSONSerialization(complition: @escaping(String) -> Void)
    
    func getLabelTextFromJSONDecoding(complition: @escaping(String) -> Void)
}

// Слой бизнес-логики или МОДЕЛЬ

final class InfoModel: InfoViewOutput {
    
    func getLabelTextFromJSONSerialization(complition: @escaping (String) -> Void) {
        
        let url1Text = "https://jsonplaceholder.typicode.com/todos/13"
        
        guard let url1 = URL(string: url1Text) else {
            
            print("URL Error")
            return
        }
        
        // MARK: - 1.2
        URLSession.shared.dataTask(with: url1) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                // MARK: - 1.3
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print(json)
                    complition(json["title"] as! String)
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func getLabelTextFromJSONDecoding(complition: @escaping (String) -> Void) {
        
        let url2Text = "https://swapi.dev/api/planets/1/"
        
        guard let url2 = URL(string: url2Text) else {
            
            print("URL Error")
            return
        }
        
        // MARK: - 2.2
        URLSession.shared.dataTask(with: url2) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                // MARK: - 2.3
                let json = try JSONDecoder().decode(Planet.self, from: data)
                complition(json.orbitalPeriod)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
}
