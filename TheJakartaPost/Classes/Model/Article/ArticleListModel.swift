//
//  ArticleListModel.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 22/09/22.
//

import Foundation

// MARK: - RequestListModel
struct ArticleListModel: Codable {
    let response: Response
    let data: [Article]?
    let isUserPremium: Bool?
    
    enum CodingKeys: String, CodingKey {
        case response, data
        case isUserPremium = "is_user_premium"
    }
}

// MARK: - Datum
struct Article: Codable {
    let id, publishedDate, location, title: String?
    let path, summary: String?
    let channels: Channels?
    let tags: [Tag]?
    let gallery: [Gallery]?
    let isPremium, isLongform: Bool?
    let sourceID: Int?
    let line: String?
    let writer, publisher: Publisher?
    let content: String?
    
    var publishedDateValue: String {
        guard let publishedDate = publishedDate else { return "-" }
        guard let pB = DatesFormatter.timepast.dateFromString(publishedDate) else { return "-" }
        return DatesFormatter.display.stringFromDate(pB)
    }

    enum CodingKeys: String, CodingKey {
        case id
        case publishedDate = "published_date"
        case location, title, path, summary, channels, tags, gallery
        case isPremium = "is_premium"
        case isLongform = "is_longform"
        case sourceID = "source_id"
        case content
        case line, writer, publisher
    }
}

// MARK: - Channels
struct Channels: Codable {
    let id: Int?
    let name, parent: ParentEnum?
    let color: Color?
}

enum Color: String, Codable {
    case the722A14 = "722a14"
}

enum ParentEnum: String, Codable {
    case seAsia = "SE Asia"
}

// MARK: - Gallery
struct Gallery: Codable {
    let id: Int?
    let title: String?
    let pathOrigin: String?
    let pathThumbnail, pathSmall, pathMedium, pathLarge: String?
    let source: String?
    let content: String?
    let photographer, keyword: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case pathOrigin = "path_origin"
        case pathThumbnail = "path_thumbnail"
        case pathSmall = "path_small"
        case pathMedium = "path_medium"
        case pathLarge = "path_large"
        case source, content, photographer, keyword
    }
}

// MARK: - Publisher
struct Publisher: Codable {
    let id: Int?
    let name: String?
    let pic: String?
    let job: String?
}

// MARK: - Tag
struct Tag: Codable {
    let id: Int?
    let name: String?
    let link: String?
}

// MARK: - Response
struct Response: Codable {
    let code: Int?
    let text: String?
}
