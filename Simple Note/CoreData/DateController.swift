//
//  DateController.swift
//  Simple Note
//
//  Created by 이민규 on 2020/04/23.
//  Copyright © 2020 이민규. All rights reserved.
//

import Foundation

func dateToString(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd"
    return formatter.string(from: date)
}

func stringToDate(_ date: String) -> Date? {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd"
    return formatter.date(from: date)
}

func dateToStringDetail(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd HH:mm:ss"
    return formatter.string(from: date)
}
