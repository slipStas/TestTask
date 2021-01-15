//
//  MissedCallsViewModel.swift
//  TestTask
//
//  Created by Stanislav Slipchenko on 15.01.2021.
//

import Foundation

protocol MissedCallsViewModelInputs {
    var missedCallsDelegate: MissedCallsDelegate? {get set}
    func tapCell()
    func loadDataFromServer()
}

protocol MissedCallsViewModelOutputs {
    
    var calls: CallModel? {get set}
}

class MissedCallsViewModel: MissedCallsViewModelInputs, MissedCallsViewModelOutputs {
    
    var calls: CallModel?
    
    func loadDataFromServer() {
        
    }
    
    public weak var missedCallsDelegate: MissedCallsDelegate?
    
    var someData = ""
    
    init(someData: String) {
        self.someData = someData
    }
    
    func tapCell() {
        print("cell was tapped")
        try? self.missedCallsDelegate?.goToInfoVC(someData: calls)
    }
}
