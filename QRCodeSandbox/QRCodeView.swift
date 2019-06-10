//
//  QRCodeView.swift
//  QRCodeSandbox
//
//  Created by Victor Peschenkov on 6/10/19.
//  Copyright © 2019 Victor Peschenkov. All rights reserved.
//

import QRCodeCore

struct QRCodePreferences: QRCodeCore.QRCodePreferences {
    var message: String
}

final class QRCodeView: QRCodeCore.QRCodeView {
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
        self.configure()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        self.configure()
    }
    
    private func configure() {
        preferences = QRCodePreferences(message: "Whar are you looking for?")
    }
}
