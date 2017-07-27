//
//  String.swift
//  OverlayPresentation
//
//  Created by Thanh-Tam Le on 11/25/16.
//  Copyright © 2016 Thanh-Tam Le. All rights reserved.
//

import Cocoa

extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: NSFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
    }
}
