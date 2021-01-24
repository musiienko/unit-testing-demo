//
//  Scheduler.swift
//  UnitTestingDemo
//
//  Created by Maksym Musiienko on 26.11.20.
//

import Foundation

protocol Scheduler {

    func schedule(_ block: @escaping VoidHandler)
}

extension DispatchQueue: Scheduler {

    func schedule(_ block: @escaping VoidHandler) {
        self.async(execute: block)
    }
}
