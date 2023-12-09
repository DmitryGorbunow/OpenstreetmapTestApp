//
//  APIError.swift
//  OpenstreetmapTestApp
//
//  Created by Dmitry Gorbunow on 12/7/23.
//

import Foundation

enum APIError: Error {
    case dataNotFound
    case decodeError
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .dataNotFound:
            return "Данные не найдены"
        case .decodeError:
            return "Ошибка получения данных"
        }
    }
}
