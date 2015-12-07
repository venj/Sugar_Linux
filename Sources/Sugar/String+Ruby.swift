//
//  String+Ruby.swift
//  Sugar Example
//
//  Created by 朱文杰 on 15/11/13.
//  Copyright © 2015年 朱文杰. All rights reserved.
//
/**
 Ruby Core flavored string extension. 
*/
#if os(Linux)
import Glibc
#else
import Darwins
#endif

@available(iOS 7.0, OSX 10.9, *)
public extension String {
    // Static function
    /**
    This method will generate an UUID string. This is not a trivial UUID implementation.
    But more like a custom baked UUID.

    - returns: A variable length UUID string.
    */
    static func UUIDString() -> String {
        srandom(UInt32(time(nil)))
        return String(random())
    }

    // Byte related methods are not included currently
    // b(), bytes(), bytesize(), byteslice()

    /**
    Subscript of `String` using `Int` as index. 
    
    - parameter index: An `Int` value that indicate the index of a character.
    - returns: A string contains a character. Not the Swift `Character` object.
    */
    subscript(index: Int) -> String {
        var pos = index
        if index < 0 && -index <= count { pos = count + index }
        let startIndex = self.startIndex
        let position = startIndex.advancedBy(pos)
        let endIndex = startIndex.advancedBy(pos+1)
        let range = Range<Index>(start:position, end:endIndex)
        return self[range]
    }

    // minus int range not implemented
    /**
    Subscript of `String` using `Range<Int>` as range. Note: Range contains minus
    minus int value is not supported. If you pass in a Range contains minus value,
    the behavior is unpredictable. 
    
    - parameter intRange: A integer range. You can create a Swift native `Int` range
    by `1...5` or `2..<6` range literials. 
    - returns: Substring within the range.
    */
    subscript(intRange: Range<Int>) -> String {
        let stringOrigin = self.startIndex
        let startIndex = stringOrigin.advancedBy(intRange.startIndex)
        let endIndex = startIndex.advancedBy(intRange.endIndex - intRange.startIndex)
        let range = Range<Index>(start:startIndex, end:endIndex)
        return self[range]
    }

    /**
     Compare string with another string and not consider cases.

     - parameter aString: Any other string.
     - returns: `1` is returned if string is larger than `aString` according to string encoding
     `0` is returned if strings are the same (without consider cases).
     `-1` is returned if string is smaller than `aString`.
    */
    func casecmp(aString: String) -> Int {
        return lowercaseString <=> aString.lowercaseString
    }

    /**
     Make a long string and center the original string inside the resulting string. The other part are filled with a padding string.
     
     - parameter size: The length of the resulting string. 
     - parameter padString: Padding string that fill the space beside the center string. 
     - returns: A longer string with original string centered.
    */
    func center(size: Int, padString:String = " ") -> String {
        let padSize = padString.characters.count
        if padSize == 0 { fatalError("padString can not be zero length") }
        if count >= size { return self }
        let leftPadSpace = (size - count) / 2
        let rightPadSpace = leftPadSpace + (size - count) % 2
        if padSize == 1 {
            return padString * leftPadSpace + self + padString * rightPadSpace
        }
        else {
            var (leftPad, rightPad) = ("", "")
            for var i = 0, j = 0; i < leftPadSpace; ++i, ++j {
                if j % padSize == 0 { j = 0 }
                leftPad += padString[j]
            }
            for var i = 0, j = 0; i < rightPadSpace; ++i, ++j {
                if j % padSize == 0 { j = 0 }
                rightPad += padString[j]
            }
            return leftPad + self + rightPad
        }
    }

    /**
    Chop off the last character from a string and return it. The original string is not changed.
     
    - returns: A string with the last character removed.
    */
    func chop() -> String {
        var result = self
        let lastCharIndex = endIndex.advancedBy(-1)
        let range = Range<Index>(start:lastCharIndex, end:endIndex)
        result.removeRange(range)
        return result
    }

    /**
     Chop off the last character from the original string and return it. 
     
     @returns The string with last character removed.
    */
    mutating func chopInPlace() -> String {
        self = chop()
        return self
    }

    /**
     Clear out a string, after clear, the original string become an empty string.
    */
    mutating func clear() {
        self = ""
    }

    // chr, chomp!, chop!,  are not implemented

    // codepoints not implemented, since String has better solutions

    /**
    Concat the an object to a string. But unlike Ruby, the object is an `Int`, it will not convert it to Unicode charactor, but convert the `Int` to `String` and concat it to the left hand size string.

    - parameter obj: Any type of object that `String` initializer can handle.
    - returns: A string with original string and an object contact to it.
    */
    func concat<T>(obj: T) -> String {
        return self << obj
    }

    /**
     This is an alias to `String.characters.count`.
     */
    var count: Int {
        return characters.count
    }

    /**
     An alias for `lowercaseString`.
    */
    func downcase() -> String {
        return lowercaseString
    }

    /**
     Make the string downcase. Original string is changed.
    */
    mutating func downcaseInPlace() {
        self = lowercaseString
    }

    // dump not implemented

    // each_byte, each_codepoint not implemented
    /**
    Enumerate all the characters from a string and execute a closure on the characters.
    
    - parameter invocation: A closure that accept a `Character` as argument.
    */
    func eachChar(invocation: ((_:Character) -> Void)) {
        for char in characters {
            invocation(char)
        }
    }

    /**
     An alias to `isEmpty` property. Since ? can not be used in the property name, this is basically useless.
    */
    var empty: Bool {
        return isEmpty
    }

    // encoding is not applicable; encode!, get_byte not implemented
    // force_encoding is not applicable
    /**
    An alias for `hasSuffix`.
    */
    func endWith(suffix: String) -> Bool {
        return self.characters.reverse().startsWith(suffix.characters.reverse())
    }

    /**
     Insert the a string into the original string at specific index. Original string is changed. If the index is out of bound of a string, an exception will occured and will crash your app.

     - parameter index: The index to insert the sub string. Type of index is `Int`. 
     - parameter subString: The substring to insert. 
     - returns: Returned the string with sub string inserted.
    */
    mutating func insert(index:Int, subString: String) -> String {
        let offset = index > 0 ? index : characters.count + index + 1
        insertContentsOf(subString.characters, at: startIndex.advancedBy(offset))
        return self
    }

    // inspect is not implemented
    // intern is not applicaable

    /**
    An alias for `String.characters.count`.
    */
    var length: Int {
        return characters.count
    }

    /**
     Get an array of lines that was contained in the original string. 
     
     - returns: String array contains all lines in a string.
    */
    // func lines() -> [String] {
    //     return componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
    // }

    /**
     Put a string at left most of a longer string and pad the other spaces with padding string. 
     
     - parameter totalLength: The total length of the target string. 
     - parameter padString: The padding string to fill the target string.
     - returns: Returns a new string with the original string at left and other spaces filled with padding string.
    */
    func ljust(totalLength:Int, padString: String = " ") -> String {
        let stringLength = characters.count
        if totalLength <= stringLength {
            return self
        }
        else {
            var result = self
            let padSize = padString.characters.count
            for var i = stringLength, j = 0; i < totalLength; ++i, ++j {
                if j % padSize == 0 { j = 0 }
                result += padString[j]
            }
            return result
        }
    }

    /**
     Add a prefix to a string. Original string is not changed.
     
     - parameter prefix: String prefix. 
     - returns: String with a prefix and the original string.
    */
    func prepend(prefix: String) -> String {
        return prefix + self
    }

    /**
     Replace the current string with another string.
     
     - parameter anotherString: A string. 
     - returns: The value of `anotherString` argument.
    */
    mutating func replace(anotherString: String) -> String {
        self = anotherString
        return self
    }


    /**
     Reverse all the characters in a string.
     
     - returns: The reversed string.
    */
    func reverse() -> String {
        return String(characters.reverse())
    }


    /**
     Change the original string to a string of all the characters reversed.
     
     - returns: The reversed string.
    */
    mutating func reverseInPlace() -> String {
        self = reverse()
        return self
    }
    
    /**
     Put a string at right most of a longer string and pad the other spaces with padding string.

     - parameter totalLength: The total length of the target string.
     - parameter padString: The padding string to fill the target string.
     - returns: Returns a new string with the original string at right and other spaces filled with padding string.
     */
    func rjust(totalLength: Int, padString: String = " ") -> String {
        let stringLength = characters.count
        if totalLength <= stringLength {
            return self
        }
        else {
            var result = ""
            let padSize = padString.characters.count
            let stringLength = characters.count
            for var i = 0, j = 0; i < totalLength - stringLength; ++i, ++j {
                if j % padSize == 0 { j = 0 }
                result += padString[j]
            }
            result += self
            return result
        }
    }

    // scrub, scrub!, setByte not implemented
    /**
    Alias for `String.characters.count`.
    */
    var size: Int {
        return characters.count
    }

    /**
     Alias to `hasPrefix` method.
    */
    func startWith(prefix: String) -> Bool {
        return self.characters.startsWith(prefix.characters)
    }

    // succ, succ!, sum to_xxx unpack upto not implemented
    //TODO: swapcase(), swapcaseInPlace()
    //  tr and tr! not implemented. Maybe add later

    /**
    Alias for `uppercaseString` property.
    */
    func upcase() -> String {
        return uppercaseString
    }

    /**
     Make the original string an upper cased string.
    */
    mutating func upcaseInPlace() {
        self = uppercaseString
    }
}
