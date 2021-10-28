//
//  ApiService.swift
//  ZeFi
//
//  Created by Admin on 12/10/20.
//

import Foundation
import Alamofire

class APIService {
    
    static let shared = APIService()
    private init() {
        
    }
    
    func getHomeData(completion: @escaping (Error?, Any?)->()) {

        let url = Constants.BASE_URL + "/\(LanguageManager.shared.currentLang)/api/\(Constants.API_VERSION)/Home"

        AF.request(URL(string: url)!, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in

            switch response.result {
            case .success(let data):
                completion(nil, data)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getCurrencies(completion: @escaping (Error?, Any?)->()) {

        let url = Constants.BASE_URL + "/\(LanguageManager.shared.currentLang)/api/\(Constants.API_VERSION)/Currencies"

        AF.request(URL(string: url)!, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in

            switch response.result {
            case .success(let data):
                completion(nil, data)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func sendContactData(body: [String: Any], completion: @escaping (Error?, Any?)->()) {

        let url = Constants.BASE_URL + "/\(LanguageManager.shared.currentLang)/api/\(Constants.API_VERSION)/Contact"

        AF.request(URL(string: url)!, method: .post, parameters: body, encoding: JSONEncoding.default).responseJSON {
            response in

            switch response.result {
            case .success(let data):
                completion(nil, data)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getPartners(completion: @escaping (Error?, Any?)->()) {

        let url = Constants.BASE_URL + "/\(LanguageManager.shared.currentLang)/api/\(Constants.API_VERSION)/Partners"

        AF.request(URL(string: url)!, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in

            switch response.result {
            case .success(let data):
                completion(nil, data)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getTeamMembers(completion: @escaping (Error?, Any?)->()) {

        let url = Constants.BASE_URL + "/\(LanguageManager.shared.currentLang)/api/\(Constants.API_VERSION)/Team"

        AF.request(URL(string: url)!, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in

            switch response.result {
            case .success(let data):
                completion(nil, data)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getStaticPages(pageType: String, completion: @escaping (Error?, Any?)->()) {
        
        let url = Constants.BASE_URL + "/\(LanguageManager.shared.currentLang)/api/\(Constants.API_VERSION)/StaticPages/\(pageType)"

        AF.request(URL(string: url)!, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in

            switch response.result {
            case .success(let data):
                completion(nil, data)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getAllPages(category: String, level: String, pageCount: Int, completion: @escaping (Error?, Any?)->()) {
        
        let url = Constants.BASE_URL + "/\(LanguageManager.shared.currentLang)/api/\(Constants.API_VERSION)/Pages/All?MainCategory=\(category)&PageLevel=\(level)&PagesCount=\(pageCount)"

        AF.request(URL(string: url)!, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in

            switch response.result {
            case .success(let data):
                completion(nil, data)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getPageDetail(id: String, uuid: String, completion: @escaping (Error?, Any?)->()) {
        
        let url = Constants.BASE_URL + "/\(LanguageManager.shared.currentLang)/api/\(Constants.API_VERSION)/Pages/\(id)/\(uuid)"

        AF.request(URL(string: url)!, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in

            switch response.result {
            case .success(let data):
                completion(nil, data)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func getNotifications(pageNum: Int, size: Int, completion: @escaping (Error?, Any?)->()) {
        
        let url = Constants.BASE_URL + "/\(LanguageManager.shared.currentLang)/api/\(Constants.API_VERSION)/Notifications?PageNumber=\(pageNum)&PageSize=/\(size)"

        AF.request(URL(string: url)!, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in

            switch response.result {
            case .success(let data):
                completion(nil, data)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
    
    func searchPages(key: String, completion: @escaping (Error?, Any?)->()) {
        
        let url = Constants.BASE_URL + "/\(LanguageManager.shared.currentLang)/api/\(Constants.API_VERSION)/Home/Search?Keyword=\(key)"

        AF.request(URL(string: url)!, method: .get, encoding: JSONEncoding.default).responseJSON {
            response in

            switch response.result {
            case .success(let data):
                completion(nil, data)
            case .failure(let error):
                completion(error, nil)
            }
        }
    }
}
