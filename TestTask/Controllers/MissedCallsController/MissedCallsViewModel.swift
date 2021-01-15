//
//  MissedCallsViewModel.swift
//  TestTask
//
//  Created by Stanislav Slipchenko on 15.01.2021.
//

import Foundation

protocol MissedCallsViewModelInputs {
    var missedCallsDelegate: MissedCallsDelegate? {get set}
    func tapCell(index: IndexPath)
    func loadDataFromServer()
}

protocol MissedCallsViewModelOutputs {
    
    var calls: CallModel? {get set}
    var newCalls: ((CallModel?) -> Void)? {get set}
}

class MissedCallsViewModel: MissedCallsViewModelInputs, MissedCallsViewModelOutputs {
    
    var calls: CallModel? {
        didSet {
            newCalls?(calls)
        }
    }
    
    let serverService = ServerService()
    
    var newCalls: ((CallModel?) -> Void)?
    
    func loadDataFromServer() {
        serverService.loadDataFromServer { [weak self] newCalls in
            guard let strongSelf = self else {return}
            
            strongSelf.calls = newCalls
        }
    }
    
    public weak var missedCallsDelegate: MissedCallsDelegate?
        
    init(calls: CallModel?, newCalls: ((CallModel?) -> Void)?) {
        self.calls = calls
        self.newCalls = newCalls
        self.newCalls?(calls)
    }
    
    func tapCell(index: IndexPath) {
        print("cell was tapped")
        try? self.missedCallsDelegate?.goToInfoVC(someData: calls?.requests[index.row])
    }
}
