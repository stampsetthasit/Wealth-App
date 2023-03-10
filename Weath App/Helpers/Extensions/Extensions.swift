//
//  Extensions.swift
//  Weath App
//
//  Created by Yadar Tulayathamrong & Setthasit Poosawat on 3/3/2566 BE.
//

import SwiftUI

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
    
    static func fromUnixTimestamp(_ unixTimestamp: Int) -> Date {
        return Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
    }
    
    func format(with dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: self)
    }
    
    func formatTime() -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .none
        formatter.locale = Locale.current
        return formatter.string(from: self)
    }
    
    func formatFullDate() -> String {
        return format(with: "EEEE, d MMM")
    }
    
}

extension View {
    func hideKeyboardWhenTappedAround() -> some View {
        self.onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}



