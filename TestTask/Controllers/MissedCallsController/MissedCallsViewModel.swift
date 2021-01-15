//
//  MissedCallsViewModel.swift
//  TestTask
//
//  Created by Stanislav Slipchenko on 15.01.2021.
//

import Foundation

protocol MissedCallsViewModelInputs {
    
    func tapCell()
    var missedCallsDelegate: MissedCallsDelegate? {get set}
}

protocol MissedCallsViewModelOutputs {
    
}

class MissedCallsViewModel: MissedCallsViewModelInputs, MissedCallsViewModelOutputs {
    
    public weak var missedCallsDelegate: MissedCallsDelegate?
    
    var someData = ""
    
    init(someData: String) {
        self.someData = someData
    }
    
    func tapCell() {
        print("cell was tapped")
        try? self.missedCallsDelegate?.goToInfoVC(someData: "some data")
    }
}
