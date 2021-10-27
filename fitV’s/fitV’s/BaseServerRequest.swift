import Foundation
 
class BaseServerRequest{
    var headers = [String:String]()

    let defaultError = NSError(domain: "An error occurred", code: 555, userInfo: ["error":"An error occurred"])

    func getFullURL() -> String{
        return "";
    }
    
    func getParams() -> [String:Any]{
        [:]
    }
    
    func POST(onSuccess:@escaping ([String:Any?]) -> Void,onFailure:@escaping (Error)-> Void){
        basicServerRequest(url: self.getFullURL(), HTTPMethod: "POST", onSuccess: { (data) in
            let responseJSON = data?.dateToMap()
            if responseJSON != nil{
                onSuccess(responseJSON!)
            }else{
                onFailure(self.defaultError)
            }
        }) { (error) in
            onFailure(error)
        }
    }
    
    func GET(onSuccess:@escaping ([String:Any?]) -> Void,onFailure:@escaping (Error)-> Void){
        basicServerRequest(url: self.getFullURL(), HTTPMethod: "GET", onSuccess: { (data) in
            let responseJSON = data?.dateToMap()
            if responseJSON != nil{
                onSuccess(responseJSON!)
            }else{
                onFailure(self.defaultError)
            }
        }) { (error) in
            onFailure(error)
        }
    }
    
    func GETArray(onSuccess:@escaping ([Any?]) -> Void,onFailure:@escaping (Error)-> Void){
        basicServerRequest(url: self.getFullURL(), HTTPMethod: "GET", onSuccess: { (data) in
            let responseJSON = data?.dataToArray()
            if responseJSON != nil{
                onSuccess(responseJSON!)
            }else{
                onFailure(self.defaultError)
            }
        }) { (error) in
            onFailure(error)
        }
    }
    
    private func basicServerRequest(url: String, HTTPMethod: String, onSuccess:@escaping (Data?) -> Void, onFailure:@escaping (Error)-> Void){

        let params = getParams()
        if let serverURL = URL(string: HTTPMethod == "POST" ? url: createGETRequestFromDictionary(url: url, params: params)){
            var urlRequest = URLRequest(url: serverURL)
            urlRequest.httpMethod = HTTPMethod
            
            if ( HTTPMethod == "POST" || HTTPMethod == "PUT"){
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            }
            
            if headers.isEmpty == false{
                urlRequest.allHTTPHeaderFields = headers
            }
            
                let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    guard let data = data ,error == nil else{
                        onFailure(error!)
                        return;
                    }
                    
                    let httpResponse = response as! HTTPURLResponse
                    if response != nil && httpResponse.statusCode >= 200 && httpResponse.statusCode < 300{
                        onSuccess(data)
                    }else{
                        if error == nil{
                            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
                            if let responseJSON = responseJSON as? [String: Any] {
                                let msg = responseJSON["message"] != nil ? responseJSON["message"] : responseJSON["error"]
                                onFailure(msg != nil ? NSError(domain: msg as! String, code: httpResponse.statusCode, userInfo: ["error":msg as! String]): self.defaultError)
                            }else{
                                onFailure(self.defaultError)
                            }
                        }else{
                            onFailure(error!)
                        }
                    }
                }
                task.resume()
        }else{
            onFailure(NSError(domain: "An error occurred", code: 555, userInfo: ["error":"An error occurred"]))
        }
    }
    
    private func createGETRequestFromDictionary(url:String, params:[String:Any?]?)->String{
        var newUrl = url
        var q = [URLQueryItem]()
        
        if params == nil{
            return newUrl
        }
        
        for (k, r) in params!{
            q.append(URLQueryItem(name: k, value: "\(r ?? "")"))
        }
        
        var uc = URLComponents(string: url)
        uc?.queryItems = q
        newUrl = uc?.url?.absoluteString ?? newUrl
        
        return newUrl
    }
    
}

extension Data{
    
    func dateToMap() -> [String:Any?]?{
        do{
            let responseJSON = try JSONSerialization.jsonObject(with: self, options: [])
            return responseJSON as? [String:Any?]
        }catch let error as NSError{
            print("Error : \(error)")
            return nil
        }
    }
    
    func dataToArray() -> Array<Any>?{
        do{
            let responseJSON = try JSONSerialization.jsonObject(with: self, options: [])
            return responseJSON as? Array<Any>
        }catch let error as NSError{
            print("Error : \(error)")
            return nil
        }
    }
}

