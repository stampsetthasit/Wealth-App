//
//  WeathWidgetBundle.swift
//  WeathWidget
//
//  Created by Yadar Tulayathamrong on 2/3/2566 BE.
//

import WidgetKit
import SwiftUI

@main
struct WeathWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeathWidget()
        WeathWidgetLiveActivity()
    }
}
