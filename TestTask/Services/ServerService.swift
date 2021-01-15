//
//  ServerService.swift
//  TestTask
//
//  Created by Stanislav Slipchenko on 15.01.2021.
//

import Foundation

protocol ServerServiceProtocol: class {
    
    func loadDataFromServer(completionHandler: @escaping (CallModel) -> ())
}

class ServerService: ServerServiceProtocol {
        
    func loadDataFromServer(completionHandler: @escaping (CallModel) -> ()) {
        DispatchQueue.main.async {
            let configurator = URLSessionConfiguration.default
            let session = URLSession(configuration: configurator)
            var urlConstructor = URLComponents()
            
            urlConstructor.scheme = "https"
            urlConstructor.host = "5e3c202ef2cb300014391b5a.mockapi.io"
            urlConstructor.path = "/testapi"
            
            guard let url = urlConstructor.url else {return}
            
            session.dataTask(with: url) { (data, response, error) in
                guard let data = data else {return}
                
                let calls = try? JSONDecoder().decode(CallModel?.self, from: data)
                guard let strongCalls = calls else {return}
                calls?.requests.forEach {print($0.duration)}
                completionHandler(strongCalls)
            }.resume()
        }
    }
}

