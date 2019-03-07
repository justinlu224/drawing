//
//  question.swift
//  drawing
//
//  Created by Apple on 2018/11/12.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

struct Draw: Codable {
    var title:String
    var questions:[String]
    
    
    private static var fileURL : URL {
        var documentDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        documentDir.appendPathComponent("draws")
        documentDir.appendPathExtension("plist")
        print(documentDir.absoluteString)
        return documentDir
        
    }
    //存檔
    static func sava(_ drawss:[Draw]){
        //取得編碼器
        let encoder = PropertyListEncoder()

        if let encodedEmojis = try?
            encoder.encode(drawss){
            try! encodedEmojis.write(to: fileURL)
             print("save")
        }
       
    }
    
    //讀檔
    static func load() -> [Draw]?{
        let decoder = PropertyListDecoder()
        if let decodedEmojis = try? Data(contentsOf: fileURL){
            let result = try? decoder.decode(Array<Draw>.self, from: decodedEmojis)
             print("load")
            return result
        }
        return nil
    }

}
