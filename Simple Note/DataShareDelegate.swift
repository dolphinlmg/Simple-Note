//
//  DataShareDelegate.swift
//  Simple Note
//
//  Created by 이민규 on 2020/04/21.
//  Copyright © 2020 이민규. All rights reserved.
//

import Foundation
import CoreData

protocol DataShareDelegate {
    
    func sendData(memo: Notes, row: Int);
    
}
