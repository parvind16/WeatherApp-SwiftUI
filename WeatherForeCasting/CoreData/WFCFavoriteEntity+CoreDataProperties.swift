//
//  WFCFavoriteEntity+CoreDataProperties.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 30/09/24.
//
//

import Foundation
import CoreData


extension WFCFavoriteEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WFCFavoriteEntity> {
        return NSFetchRequest<WFCFavoriteEntity>(entityName: "WFCFavoriteEntity")
    }

    @NSManaged public var fieldData: Data?
    @NSManaged public var cityName: String?

}

extension WFCFavoriteEntity : Identifiable {

}
