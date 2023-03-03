//
//  Extensions.swift
//  Weath App
//
//  Created by Yadar Tulayathamrong on 3/3/2566 BE.
//

import Foundation

extension Date {
    var dateFormat : String {
        self.formatted(
            .dateTime.weekday().day().month()
        )
    }
    
    var timeFormat : String {
        self.formatted(
            .dateTime.hour()
        )
    }
}
