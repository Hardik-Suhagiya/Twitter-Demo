//
//  HomeViewModel.swift
//  Twitter-Demo
//
//  Created by MAC on 12/10/23.
//

import Foundation

class HomeViewModel {
    // MARK: - PROPERTIES
    var response: ((Bool, String) -> Void)?
    var arrFeed: [HomeModel] = [HomeModel]()
    
    init() {
        loadJson(filename: "data")
    }
}

// MARK: - CUSTOM FUNCTIONS
extension HomeViewModel {
    func loadJson(filename fileName: String)  {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                parseData(data: data)
            } catch {
                debugPrint("Error loading JSON: \(error)")
                self.response?(false,error.localizedDescription)
            }
        }
    }
    
    func parseData(data:Data) {
        do {
            self.arrFeed = try JSONDecoder().decode([HomeModel].self, from: data)
            self.response?(true,"")
        } catch {
            debugPrint("err: \(error.localizedDescription)")
            self.response?(false,error.localizedDescription)
        }
    }
}
