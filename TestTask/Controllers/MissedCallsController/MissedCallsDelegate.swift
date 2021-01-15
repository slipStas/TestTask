//
//  MissedCallsDelegate.swift
//  TestTask
//
//  Created by Stanislav Slipchenko on 15.01.2021.
//

import Foundation

protocol MissedCallsDelegate : AnyObject {
    func goToInfoVC(someData: String) throws
}
