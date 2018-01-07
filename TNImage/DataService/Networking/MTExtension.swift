//
//  MTExtension.swift
//  TNImage
//
//  Created by Nguyễn Minh Trí on 1/6/18.
//  Copyright © 2018 Nguyễn Minh Trí. All rights reserved.
//

import Foundation

extension Dictionary {
    /// Dictionary get from key, return "" if key not exist.
    func getArray(fromKey key:Key)->[Dictionary]{
        if let dict = self[key] as?[Dictionary]{
            return dict
        }
        return []
    }
    /// Dictionary get from key, return "" if key not exist.
    func getDictionary(fromKey key:Key)->Dictionary {
        if let dict = self[key] as? Dictionary{
            return dict
        }
        return [:]
    }
    /// Dictionary get a String from key, return "" if key not exist.
    func getString(fromKey key: Key) -> String {
        
        var string: String = ""
        
        if self[key] != nil {
            string = String(describing: self[key]!)
        }
        
        return string
    }
    /// Dictionary get a Int from key, return "" if key not exist.
    func getInt(forKey key: Key) -> Int? {
        
        var string: String = ""
        
        if self[key] != nil {
            string = String(describing: self[key]!)
            
            let num = Int(string);
            
            if num != nil {
                return num!
            }
        }
        
        return nil
    }
}

extension Collection where Indices.Iterator.Element == Index {
    
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
