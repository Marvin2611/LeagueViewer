//
//  ErrorExtensions.swift
//  LeagueViewer
//
//  Created by Student on 20.06.22.
//

import Foundation

enum ApiError: Error {
    //Throw when an api call returns no valid summoner
    case requestFailed
    
    //Throw when the url seems broken
    case urlError
    
    //Throw in other cases
    case unexpected(code: Int)
}

extension ApiError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .requestFailed: return "Request failed"
        case .urlError: return "Url failed, might check ApiKey"
        case .unexpected(_): return "An unexpected error occurred"
        }
    }
}

//Extension from user dvdblk on stackoverflow
//stackoverflow.com/questions/38817936/swift-convert-milliseconds-to-date

typealias UnixTime = Int

extension UnixTime {
    private func formatType(form: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de")
        dateFormatter.dateFormat = form
        return dateFormatter
    }
    var dateFull: Date {
        return Date(timeIntervalSince1970: Double(self))
    }
    var toHour: String {
        return formatType(form: "HH:mm").string(from: dateFull)
    }
    var toMinutes: String {
        return formatType(form: "mm:ss").string(from: dateFull)
    }
    var toDay: String {
        return formatType(form: "dd/MM/yyyy").string(from: dateFull)
    }
}

func returnTimeDate(timeInterval: CLong) -> String {
    let myTime: UnixTime = Int(timeInterval)
    return myTime.toDay
}

func returnTimeMinutes(timeInterval: CLong) -> String {
    let myTime: UnixTime = Int(timeInterval)
    return myTime.toMinutes
}
