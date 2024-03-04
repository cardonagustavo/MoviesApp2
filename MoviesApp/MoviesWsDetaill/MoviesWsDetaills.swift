//
//  MoviesWsDetaills.swift
//  MoviesApp
//
//  Created by Gustavo Adolfo Cardona Quintero on 27/02/24
//

import Foundation
import Alamofire


//class MoviesWebService {
//    let urlString = "https://api.themoviedb.org/3/movie/\(idMovie)?api_key=752cd23fdb3336557bf3d8724e115570&language=es"
//    
//    func fetch(completionHandler: @escaping CompletionHandler) {
//        AF.request(urlString, method: .get).response {  dataResponse in
//            guard let data = dataResponse.data else {return}
////            guard let dataTest = try? JSONSerialization.jsonObject(with: data) else { return }
////            print(dataTest)
//            let arrayResponse = try? JSONDecoder().decode(MoviesDTO.self, from: data)
//            completionHandler(arrayResponse ?? MoviesDTO())
//        }
//    }
//}
