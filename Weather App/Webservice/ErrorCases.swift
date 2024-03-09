//
//  ErrorCases.swift
//  Weather App
//
//  Created by Rushikesh Gaonkar on 09/03/24.
//

import Foundation

enum ErrorCases: LocalizedError {
    case invalidUrl
    case invalidResponse
    case invalidData
    
    
    var errorDescription: String?{
        switch self{
        case.invalidUrl : return "Invalid Url"
        case.invalidResponse : return "Invalid Response"
        case.invalidData : return "Invalid Data"
        }
    }
}
