//
//  MissedCallsViewModel.swift
//  TestTask
//
//  Created by Stanislav Slipchenko on 15.01.2021.
//

import Foundation

protocol MissedCallsViewModelInputs {
    
    func tapCell()
}

protocol MissedCallsViewModelOutputs {
    
}

class MissedCallsViewModel: MissedCallsViewModelInputs {
    
    func tapCell() {
        print("cell was tapped")
    }
    
}
