//
//  InfoAboutCallViewModel.swift
//  TestTask
//
//  Created by Stanislav Slipchenko on 15.01.2021.
//

import Foundation

protocol InfoAboutCallViewModelInputs {
    
    func changeNumber(telephone: String) -> String
    func changeDuration(duration: String) -> String
}

protocol InfoAboutCallViewModelOutputs {
    
}

class InfoAboutCallViewModel: InfoAboutCallViewModelInputs, InfoAboutCallViewModelOutputs {
    
    func changeNumber(telephone: String) -> String {
        var returnString = telephone
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
