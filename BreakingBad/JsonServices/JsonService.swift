//
//  JsonService.swift
//  BreakingBad
//
//  Created by Kevin Reid on 10/12/2020.
//

import UIKit

public class JsonService: NSObject {
    
    public func getBreakingBadCharacters(completion: @escaping (Bool, Any?, Error?) -> Void)  {
        guard let url = URL(string: "https://breakingbadapi.com/api/characters") else { return}
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with:  urlRequest) { ( data, _, _) in
            guard let data = data else { return }
            do {
                let details = try JSONDecoder().decode([Details].self, from: data)
                DispatchQueue.main.async {
                    completion(true, details, nil)
                }
                
            } catch {
                completion(false, nil, error)
            }
        }
        
        task.resume()
    }

}
