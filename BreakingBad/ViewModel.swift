//
//  ViewModel.swift
//  BreakingBad
//
//  Created by Ezra Kanake on 12/08/2022.
//

import Foundation
import SwiftUI


class ViewModel: ObservableObject {
    @Published var characters :[Characters] = []
    
    func fetch(){
        guard let url = URL(string:"https://www.breakingbadapi.com/api/characters") else {
            return
    }
     
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data=data, error == nil else {
                return
            } 
            
            do{
                let characters = try JSONDecoder().decode([Characters].self, from: data)
                DispatchQueue.main.async {
                    self?.characters = characters
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}
