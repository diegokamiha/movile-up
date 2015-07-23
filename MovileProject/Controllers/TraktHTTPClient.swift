//
//  TraktHTTPClient.swift
//  MovileProject
//
//  Created by iOS on 7/22/15.
//
//

import Foundation
import Alamofire
import Result
import TraktModels

class TraktHTTPClient {
    
    private lazy var manager: Alamofire.Manager = {
    
        let configuration: NSURLSessionConfiguration = {
            var configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
            var headers = Alamofire.Manager.defaultHTTPHeaders
            headers["Accept-Encoding"] = "gzip"
            headers["Content-Type"] = "application/json"
            headers["trakt-api-version"] = "2"
            headers["trakt-api-key"] = "a8f6346aaf7f20bea231aae49fe1cff0b67b0044a687e51b5f9cd92c918437e7"
        
            configuration.HTTPAdditionalHeaders = headers
            
        return configuration
        }()
        
    return Manager(configuration: configuration)
    }()
    
    private enum Router: URLRequestConvertible {
        static let baseURLString = "https://api-v2launch.trakt.tv/"
        
        case Show(String)
        case Episode(String, Int, Int)
        case PopularShows
        case Seasons(String)
        case Episodes(String, Int)
        // MARK: URLRequestConvertible
        var URLRequest: NSURLRequest {
            let (path: String, parameters: [String: AnyObject]?, method: Alamofire.Method) = {
                switch self {
                case .Show(let id):
                    return ("shows/\(id)", ["extended": "images,full"], .GET)
                case .Episode(let show, let season, let episode):
                    return ("shows/\(show)/seasons/\(season)/episodes/\(episode)", ["extended": "images, full"], .GET)
                case .PopularShows:
                    return ("shows/popular", ["extended": "images, full"], .GET)
                case .Seasons(let showId):
                    return ("shows/\(showId)/seasons", ["extended": "images, full"], .GET)
                case .Episodes(let showId, let seasonId):
                    return ("shows/\(showId)/seasons/\(seasonId)/episodes", ["extended": "images, full"], .GET)
                }
                                }()
            let URL = NSURL(string: Router.baseURLString)!
            let URLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
            URLRequest.HTTPMethod = method.rawValue
        
            let encoding = Alamofire.ParameterEncoding.URL
            
            return encoding.encode(URLRequest, parameters: parameters).0
        }
    }
    
    func getShow(id: String, completion: ((Result<Show, NSError?>) -> Void)?) {
            getJSONElement(Router.Show(id), completion: completion)
    }
    
    func getEpisode(showId: String, season: Int, episodeNumber: Int, completion: ((Result<Episode, NSError?>) -> Void)?) {
        let router = Router.Episode(showId, season, episodeNumber)
        getJSONElement(router, completion: completion)
    }
    
    func getPopularShows(completion: ((Result<[Show], NSError?>) -> Void)?) {
        getJSONArray(Router.PopularShows, completion: completion)
    }
    
    func getSeasons(showId: String,
        completion: ((Result<[Season], NSError?>) -> Void)?) {
        getJSONArray(Router.Seasons(showId), completion: completion)
    }
    func getEpisodes(showId: String, season: Int,
        completion: ((Result<[Episode], NSError?>) -> Void)?) {
        getJSONArray(Router.Episodes(showId, season), completion: completion)
    }
    
    /* Load a json element and decode it to an object*/
    private func getJSONElement<T: JSONDecodable>(router: Router,
        completion: ((Result<T, NSError?>) -> Void)?) {
        manager.request(router).validate().responseJSON { (_, _, responseObject, error)  in
            if let json = responseObject as? NSDictionary {
                if let value = T.decode(json) {
                    completion?(Result.success(value))
                } else {
                    completion?(Result.failure(nil))
                }
            } else {
                completion?(Result.failure(error))
            }
        }
    }
    
    /* Load a json array and decode it to an object array*/
    private func getJSONArray<T: JSONDecodable>(router: Router, completion: ((Result<[T], NSError?>) -> Void)?){
            var array: [T] = []
            manager.request(router).validate().responseJSON{ (_,_, responseObject, error) in
            if let json = responseObject as? NSArray{
                for elem in json{
                    if let value = T.decode(elem){
                        array.append(value)
                    } else{
                        completion?(Result.failure(nil))
                    }
                }
                completion?(Result.success(array))
            }else {
                completion?(Result.failure(error))
            }
        }
    }
}