import UIKit

//error handling

enum DivisionError: Error {
    case divideByZero
    case invalidInput
}

func division (num1: Double, num2 : Double) throws -> Double {
    guard num2 != 0 else {
        throw DivisionError.divideByZero
    }
    guard num2 > 0 else {
        throw DivisionError.invalidInput
    }
    return num1 / num2
}

//1. do try catch
do {
    let res = try division(num1: 12.32, num2: 12.64)
    print(res)
} catch {
    print(error)
}
//2. try?
//
//let res = try? division(num1: 12.32, num2: 12.64)
//print(res)

//2. try!

let res = try! division(num1: 12.32, num2: 12.64)
print(res)


enum APIError:Error{
    case invalidURL
    case serverError(Int)
    case noDataFound
}
func fetchDataFromAPI(urlString:String, completionHandler: @escaping (Data?, APIError?) -> Void) {
    print("Start of api call")
    guard let url = URL(string:urlString)else{
        completionHandler(nil, APIError.invalidURL)
        return
    }
    
    let dataTask = URLSession.shared.dataTask(with: url) { data, urlresponse, error in
        
        if let error = error{
            completionHandler(nil, APIError.noDataFound)
            return
        }
        
        if let response = urlresponse as? HTTPURLResponse{
            if response.statusCode < 200 || response.statusCode > 299{
                completionHandler(nil, APIError.serverError(response.statusCode))
                return
            }
        }
        
        guard let receivedData = data else{
            completionHandler(nil,APIError.noDataFound)
            return
        }
        completionHandler(receivedData,nil)
    }
    dataTask.resume()
    print("End of api call")
}
    
fetchDataFromAPI(urlString: "https://dummyjson.com/products") { data, error in
    print("Got response")
    if let data = data{
        print(data.count)
    }else{
        print(error?.localizedDescription ?? "some error occured")
    }
    
}
