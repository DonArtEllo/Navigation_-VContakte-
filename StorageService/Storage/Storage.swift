//
//  Posts.swift
//  Navigation
//
//  Created by Артем on 12.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

private enum Section {
    case Header
    case Photos
    case Posts
    case unknown
    
    init(section: Int) {
        switch section {
        case 0: self = .Header
        case 1: self = .Photos
        case 2: self = .Posts
        default:
            self = .unknown
        }
    }
}

public struct ProfilePagePost {
    public let author: String
    public let description: String
    public let image: String
    public var likes: Int
    public var views: Int
}

public struct ProfilePage {
    public var avatar: UIImage
    public let fullName: String
    public let postsOnProfilePage: [ProfilePagePost]
    
    public init(avatar: UIImage, fullName: String, postsOnProfilePage: [ProfilePagePost]) {
        
        self.avatar = avatar
        self.fullName = fullName
        self.postsOnProfilePage = postsOnProfilePage
    }
}

public struct Photo {
    public let image: String
}

public struct Storage {
    
    // MARK: Profile Page Posts Data
    public static let postsTabel = [
        ProfilePage(
            avatar: #imageLiteral(resourceName: "cat"),
            fullName: "Hacker Kitten",
            postsOnProfilePage: [
                ProfilePagePost(
                    author: "the-fuzzy-potato",
                    description: "I know it's because it's the largest island but STILL",
                    image: "gb_meme",
                    likes: 10800,
                    views: 12000
                ),
                ProfilePagePost(
                    author: "TheOrangeDonaldTrump",
                    description: "Error: meme not found",
                    image: "404_meme",
                    likes: 4400,
                    views: 5000
                ),
                ProfilePagePost(
                    author: "Snake_Bomber",
                    description: "Good 'Boys' follow orders",
                    image: "dog_meme",
                    likes: 37700,
                    views: 40000
                ),
                ProfilePagePost(
                    author: "winkysocks21",
                    description: "An unfortunate series of events",
                    image: "wwii_meme",
                    likes: 48100,
                    views: 50000
                )
            ]
        )
    ]
    
    //MARK: Photos Data
    public static let photosTabel = [
        Photo(
            image: "0"
        ),
        Photo(
            image: "1"
        ),
        Photo(
            image: "2"
        ),
        Photo(
            image: "3"
        ),
        Photo(
            image: "4"
        ),
        Photo(
            image: "5"
        ),
        Photo(
            image: "6"
        ),
        Photo(
            image: "7"
        ),
        Photo(
            image: "8"
        ),
        Photo(
            image: "9"
        ),
        Photo(
            image: "10"
        ),
        Photo(
            image: "11"
        ),
        Photo(
            image: "12"
        ),
        Photo(
            image: "13"
        ),
        Photo(
            image: "14"
        ),
        Photo(
            image: "15"
        ),
        Photo(
            image: "16"
        ),
        Photo(
            image: "17"
        ),
        Photo(
            image: "18"
        ),
        Photo(
            image: "19"
        )
    ]
}
