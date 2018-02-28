import Foundation
import UIKit

public class APIClient {
    
    
    public static var defaultEnvironment = Environment.test
    
    public static var shared: APIClient? = APIClient()
    
    public static var activityCounter = 0 {
        didSet {
            DispatchQueue.main.async {
                let app = UIApplication.shared
                if activityCounter > 0, app.isNetworkActivityIndicatorVisible == false {
                    app.isNetworkActivityIndicatorVisible = true
                } else if app.isNetworkActivityIndicatorVisible == true {
                    app.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }
    
    private let session: URLSession
    
    private var headers: [String: String] = [:]
    
    
    public enum Environment: String {
        case test = "https://reqres.in/api"
    }
    
    private enum HTTPMethod: String {
        case delete = "DELETE"
        case get = "GET"
        case post = "POST"
        case put = "PUT"
    }
    
    struct Constants {
        static let login = "/login"
    }
    
    public let environment: Environment
    
    init(_ environment: Environment = APIClient.defaultEnvironment) {
        self.environment = environment
        
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    deinit {
        session.invalidateAndCancel()
    }
    
    private func load(path: String, method: HTTPMethod = .get, query: [String: Any]? = nil, body: Any? = nil, completion: @escaping (Any?, Int, Error?) -> Void) {
        APIClient.activityCounter += 1
        
        loadData(path: path, method: method, query: query, body: body) { (data, code, error) in
            let code = code
            
            APIClient.activityCounter -= 1
            
            var json: Any? = nil
            
            if let data = data {
                json = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments])
            }
            
            completion(json, code, error)
        }
    }
    
    private func loadData(path: String, method: HTTPMethod = .get, query: [String: Any]? = nil, body: Any? = nil, completion: @escaping (Data?, Int, Error?) -> Void) {
        var components = URLComponents(string: environment.rawValue)
        components?.path.append(path)
        components?.queryItems = query?.map({ URLQueryItem(name: $0.key, value: "\($0.value)") })
        
        guard let url = components?.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        headers.forEach {
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        
        if let body = body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            var jsonBody: NSString = ""
            var jsonResponse: NSString = ""
            if let body = body, let json = try? JSONSerialization.data(withJSONObject: body, options: .prettyPrinted), let string = String(data: json, encoding: .utf8) {
                jsonBody = string as NSString
            }
            if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []), let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted), let string = String(data: jsonData, encoding: .utf8) {
                jsonResponse = string as NSString
            }
            print("----------\nRequest:\n\(method.rawValue) \(url)\n\(jsonBody)\n----------\nResponse:\n\((response as? HTTPURLResponse)?.statusCode ?? 0)\n\(jsonResponse)\n----------\n")
            
            DispatchQueue.main.async {
                completion(data, (response as? HTTPURLResponse)?.statusCode ?? 0, error)
            }
        }
        task.resume()
    }
    
    // MARK: API Calls
    
    public func login(withEmail email: String, password: String, completion: @escaping (Any?, Int, Error?) -> Void) {
        let body: [String : Any] = [
            "email": email,
            "password": password
        ]
        
        load(path: Constants.login, method: .post, body: body) { (json, code, error) in
            completion(json, code, error)
        }
    }
}

