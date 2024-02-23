//
//  File.swift
//
//
//  Created by Satyam Tripathi on 11/12/23.
//

import Foundation

// Define a generic completion handler with a Result type
public typealias CompletionHandler<T> = (Result<T, APIError>) -> Void

// A class responsible for handling basic API requests
public class MQLBaseService {
    public static let shared = MQLBaseService()
    private init() {}
    
    // Method to make a generic API request
    public func request<T>(endpoint: MQLEndpoint, completionHandler: @escaping CompletionHandler<T>) where T: Decodable {
        
        // Check the internet connectivity
        if(!Connectivity.isConnectedToInternet){
            completionHandler(.failure(.connectivity(error: "noInternetConnection")))
            return
        }
        
        // Ensure a valid URL is provided
        guard let url =  endpoint.url else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        // Create a URLRequest based on the provided parameters
        var request = URLRequest(url:url)
        request.httpMethod = endpoint.method.rawValue
        
        // Encode the request body if available
        if let body = endpoint.body {
            request.httpBody = try? JSONEncoder().encode(body)
        }
        
        // Set the request headers
        request.allHTTPHeaderFields = endpoint.header
        // Print the request for debugging purposes
        debugPrint(request);
        
        // Perform a data task for the API request
        performRequestTask(request: request) { response in
            completionHandler(response)
        }
    }
    
    //MARK: - Private functions
    
    private func performRequestTask<T>(request: URLRequest, completionHandler: @escaping CompletionHandler<T>) where T: Decodable {
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // Check for data and network errors
            guard let data, error == nil else {
                completionHandler(.failure(.invalidURL))
                return
            }
            
            // Check for a successful HTTP response status code
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            // Successful response
            if 200...299 ~= response.statusCode {
                //Decode the received data into the specified type
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(decodedObject))
                } catch {
                    completionHandler(.failure(.invalidDecoding))
                }
            } else {
                // Error response other than 200... 299 status code
                let mobileQuickLaunchKitError = self.errorFromJSON(data) ?? MQLError(message: "somethingWentWrong")
                completionHandler(.failure(.network(mobileQuickLaunchKitError)))
            }
        }.resume()
    }
    
    // Error from JSON response
    private func errorFromJSON(_ jsonData: Data?) -> MQLError? {
        var lError: MQLError? = nil
        if let lData = jsonData {
            do {
                lError = try JSONDecoder().decode(MQLError.self, from: lData)
            } catch {
                debugPrint("exception: \(error)")
            }
        }
        return lError
    }
    
    // MARK: Upload image
    public func uploadImage<T>(endpoint: MQLEndpoint, requestData: Data, boundary: String, completionHandler: @escaping CompletionHandler<T>) where T: Decodable {
        // Check the internet connectivity
        if(!Connectivity.isConnectedToInternet){
            completionHandler(.failure(.connectivity(error: "noInternetConnection")))
            return
        }
        
        // Ensure a valid URL is provided
        guard let url =  endpoint.url else {
            completionHandler(.failure(.invalidURL))
            return
        }
        
        // Create a URLRequest based on the provided parameters
        var request = URLRequest(url:url)
        request.httpMethod = endpoint.method.rawValue
        
        
        // Set the request headers
        request.allHTTPHeaderFields = endpoint.header
        // Print the request for debugging purposes
        debugPrint(request);
        // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
        // And the boundary is also set here
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        session.uploadTask(with: request, from: requestData){ (data, response, error) in

            // Check for data and network errors
            guard let data, error == nil else {
                completionHandler(.failure(.invalidURL))
                return
            }
            
            // Check for a successful HTTP response status code
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.invalidResponse))
                return
            }
            // Successful response
            if 200...299 ~= response.statusCode {
                //Decode the received data into the specified type
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    completionHandler(.success(decodedObject))
                } catch {
                    completionHandler(.failure(.invalidDecoding))
                }
            } else {
                // Error response other than 200... 299 status code
                let mobileQuickLaunchKitError = self.errorFromJSON(data) ?? MQLError(message: "somethingWentWrong")
                completionHandler(.failure(.network(mobileQuickLaunchKitError)))
            }
        }.resume()
    }
    
}
