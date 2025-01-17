//
//  AutomatIDLocalizedLabel.swift
//  AutomatID_Example
//
//  Created by Silvio D'Angelo on 15/11/22.
//  Copyright © 2022 opentech.com. All rights reserved.
//

import UIKit

class AutomatIDLocalizedLabel: UILabel {

    @IBInspectable var titlePlaceholder: String {

        get {
            return self.text!
        }

        set(value) {
            let localizedText: String = NSLocalizedString(value, comment: "")
            if localizedText.contains("<b>") {
                guard let data = localizedText.data(using: .utf16) else { return }
                if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil) {
                    self.attributedText = attributedString
                } else {
                    self.text = localizedText
                }
            } else {
                self.text = localizedText
            }

        }
    }
}
