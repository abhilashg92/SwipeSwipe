//
//  Results.swift
//  SwipeSwipe
//
//  Created by Abhilash Ghogale on 15/09/2020.
//  Copyright © 2020 abhi. All rights reserved.
//

import Foundation

struct Results:Codable {
    let results:[Result]
}

struct Result:Codable {
    let gender:String
    let name:Name
    let location:Location
    let dob:DOB
    let phone:String
    let picture:Picture
}

struct Name:Codable {
    let title:String
    let first:String
    let last:String
}

struct Location:Codable {
    let city:String
//    let state:String?
//    let country:String?
//    let postcode:Int?
}

struct DOB:Codable {
    let date:String
    let age:Int
}

struct Picture:Codable {
    let large:String
    let medium:String
    let thumbnail:String
}


