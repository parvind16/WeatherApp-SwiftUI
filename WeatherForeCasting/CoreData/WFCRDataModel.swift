//
//  WFCRDataModel.swift
//  WeatherForeCasting
//
//  Created by Parvind Bhatt on 30/09/24.
//

import Foundation
import CoreData

/// Purpose:  separate it out the creation of core data entity and the transformation of the model.
typealias WFCRDataModel = Codable

/// Purpose:  encode or decode the model to code data entity
typealias EntityCodable = EntityEncodable & EntityDecodable

///  Decode Core Data Entity to Data Model used for APIs
protocol EntityDecodable where Self: NSManagedObject {
    associatedtype DataModel: WFCRDataModel
    func decode() -> DataModel
}

///  Encode Data Model to Core Data Entity
protocol EntityEncodable where Self: NSManagedObject {
    associatedtype DataModel: WFCRDataModel
    func encode(_ model: DataModel)
}


internal struct JSONCodingKeys: CodingKey {
    internal var stringValue: String
    internal init?(stringValue: String) {
        self.stringValue = stringValue
    }
    internal var intValue: Int?
    internal init?(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}
