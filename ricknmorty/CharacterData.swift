//
//  CharacterData.swift
//  ricknmorty
//
//  Created by Harsh  on 06/07/21.
//

import Foundation
struct CharacterData:Decodable{
    let info: Info
    let results:[Results]
    
}

struct Info:Decodable{
    let count:Int
}

struct Results:Decodable{
    let id:Int
    let name:String
    let status:String
    let species:String
    let gender:String
    let origin:Origin
    let location:Location
    let image: String
}

struct Origin:Decodable {
    let name:String
}

struct  Location:Decodable {
    let name:String
}


//MARK:////////////////////////////////////////////////////////////////////////////////////
