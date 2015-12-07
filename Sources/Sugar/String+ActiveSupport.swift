//
//  String+ActiveSupport.swift
//  Sugar Example
//
//  Created by 朱文杰 on 15/11/19.
//  Copyright © 2015年 朱文杰. All rights reserved.
//
/**
Active Support flavored extension for String.
*/
@available(iOS 7.0, OSX 10.9, *)
public extension String {
    /**
     Get the character at a specified position in integer. Negtive value is the position count from the end.
     
     - parameter position: Position in int. Position can be negtive. 
     - returns: The character at the specified position as a `String` object.
    */
    func at(position: Int) -> String {
        return self[position]
    }

    /**
     Get the character at a specified position in `String.CharacterView.Index`.

     - parameter position: Position in `String.CharacterView.Index`.
     - returns: The character at the specified position as a `String` object.
    */
    func at(index: Index) -> String {
        let end = index.advancedBy(1)
        let range = Range<Index>(start:index, end:end)
        return self[range]
    }

    /**
     Get sub string at a specified integer range.

     - parameter position: Int range.
     - returns: Sub string at the specified range.
    */
    func at(range: Range<Int>) -> String {
        return self[range]
    }

    /**
     Get sub string at a specified range in `Range<Index>`.

     - parameter position: Range in the form of Range<Index>.
     - returns: Sub string at the specified range.
     */
    func at(range: Range<Index>) -> String {
        return self[range]
    }

    /**
     Get the first several characters of the string. 
     
     - parameter length: Number of characters to get. 
     - returns: First several characters of the string.
    */
    func first(length:Int = 1) -> String {
        if length <= 0 { return "" }
        if length >= count { return self }
        else { return self[0..<length] }
    }

    /**
     Get the last several characters of the string.

     - parameter length: Number of characters to get.
     - returns: Last several characters of the string.
     */
    func last(length:Int = 1) -> String {
        if length <= 0 { return "" }
        if length >= count { return self }
        else { return self [(count - length)..<count] }
    }
}