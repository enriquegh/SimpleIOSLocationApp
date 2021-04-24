//
//  NSLog.swift
//  SimpleLocationApp
//
//  Created by Enrique Gonzalez on 3/15/21.
//  Copyright © 2021 Enrique Gonzalez. All rights reserved.
//


import Foundation

public func NSLog(_ format: String, _ args: CVarArg...) {
    let message = String(format: format, arguments:args);
    print(message);
    TFLogv(message, getVaList([]))
}
