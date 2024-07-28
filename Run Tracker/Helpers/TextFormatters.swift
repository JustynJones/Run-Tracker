//
//  TextFormatters.swift
//  Run Tracker
//
//  Created by Justyn Jones on 7/28/24.
//

import Foundation

public let timeStampFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
