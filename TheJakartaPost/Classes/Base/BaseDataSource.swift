//
//  BaseDataSource.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 20/09/22.
//

import Foundation

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}
