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
    func saveData()
    func loadDataFromDevice()
    func changeNumber(string: String) -> String
    func changeDuration(duration: String) -> String
}

protocol MissedCallsViewModelOutputs {
    
    var calls: CallModel? {get set}
    var newCalls: ((CallModel?) -> Void)? {get set}
    
}

class MissedCallsViewModel: MissedCallsViewModelInputs, MissedCallsViewModelOutputs {

    var calls: CallModel? {
        didSet {
            newCalls?(calls)
            saveData()
        }
    }
    
    let serverService = ServerService()
    let careTaker = DataCaretaker()
    
    var newCalls: ((CallModel?) -> Void)?
    
    public weak var missedCallsDelegate: MissedCallsDelegate?
        
    init(calls: CallModel?, newCalls: ((CallModel?) -> Void)?) {
        self.calls = calls
        self.newCalls = newCalls
        self.newCalls?(calls)
    }
    
    func loadDataFromServer() {
        serverService.loadDataFromServer { [weak self] newCalls in
            guard let strongSelf = self else {return}
            
            newCalls.requests.sort(by: {$0.created > $1.created})
            
            newCalls.requests.forEach {print($0.created)}
            
            strongSelf.calls = newCalls
        }
    }
    
    func saveData() {
        try? careTaker.saveCalls(calls: calls)
        print("data was saved")
    }
    
    func loadDataFromDevice() {
        guard let results = try? careTaker.loadResult()  else {return}
        self.calls = results
    }
    
    func tapCell(index: IndexPath) {
        print("cell was tapped")
        try? self.missedCallsDelegate?.goToInfoVC(someData: calls?.requests[index.row])
    }
    
    func changeNumber(string: String) -> String {
        var returnString = string
        returnString.insert(" ", at: returnString.index(returnString.startIndex, offsetBy: 2))
        returnString.insert(" ", at: returnString.index(returnString.startIndex, offsetBy: 6))
        returnString.insert("-", at: returnString.index(returnString.startIndex, offsetBy: 10))
        
        return returnString
    }
    
    func changeDuration(duration: String) -> String {
        var returnedDuration = ""
        returnedDuration = duration.replacingOccurrences(of: ":00", with: "")
        if returnedDuration.count > 5 {
            returnedDuration = duration.replacingOccurrences(of: "00:", with: "")
        }
        
        return returnedDuration
    }
}
