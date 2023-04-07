//
//  RegexParser.swift
//  ActiveLabel
//
//  Created by Pol Quintana on 06/01/16.
//  Copyright © 2016 Optonaut. All rights reserved.
//
import Foundation

public struct RegexParser {
    
    public static let userIdPattern = "\\|bold\\|[\\w\\.]*"
    public static let hashtagPattern = "#[^\n!@#$%^&*<>. ]+"
    public static let mentionPattern = "@[\\p{L}0-9_\\.]*"
    public static let urlPattern = "((https?)://)?([[a-zA-‌​Z0-9]*_-]+(?:(?:\\.[\\w_-]+)+))([\\w.,@?^=%&:/~+#-]*[\\w@?^=%&/~+#-])?"

    private static var cachedRegularExpressions: [String: NSRegularExpression] = [:]

    public static func getElements(from text: String, with pattern: String, range: NSRange) -> [NSTextCheckingResult] {
        guard let elementRegex = regularExpression(for: pattern) else { return [] }
        return elementRegex.matches(in: text, options: [], range: range)
    }

    private static func regularExpression(for pattern: String) -> NSRegularExpression? {
        if let regex = cachedRegularExpressions[pattern] {
            return regex
        } else if let createdRegex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive]) {
            cachedRegularExpressions[pattern] = createdRegex
            return createdRegex
        } else {
            return nil
        }
    }
}
