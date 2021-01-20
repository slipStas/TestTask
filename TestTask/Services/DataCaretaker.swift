//
//  DataCaretaker.swift
//  TestTask
//
//  Created by Stanislav Slipchenko on 15.01.2021.
//

import Foundation

class DataCaretaker {
    
    static let shared = DataCaretaker()
    private let fileName = "savedCalls.data"
    
    var filePath: URL? {
        guard let filePath = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {return nil}
        
        return filePath.appendingPathComponent(fileName, isDirectory: false)
    }
    
    func saveCalls(calls: CallModel?) throws {
        
        let data = try JSONEncoder().encode(calls)
        try data.write(to: filePath!)
    }
    
    func loadResult() throws -> CallModel {
        
        let data = try Data(contentsOf: filePath!)
        
        return try JSONDecoder().decode(CallModel.self, from: data)
    }
}
