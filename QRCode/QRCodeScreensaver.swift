//
//  QRCodeView.swift
//  QRCode
//
//  Created by Victor Peschenkov on 6/10/19.
//  Copyright © 2019 Victor Peschenkov. All rights reserved.
//

import QRCodeCore
import ScreenSaver

final class QRCodeScreensaver: ScreenSaverView {
    fileprivate lazy var codeView = QRCodeView(frame: .zero)
    
    override init?(frame: NSRect, isPreview: Bool) {
        super.init(frame: frame, isPreview: isPreview)
        configure()
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
        configure()
    }
    
    override func layout() {
        super.layout()
        codeView.frame = self.bounds
    }
    
    // MARK: - Pirivate Methods
    
    private func configure() {
        codeView.preferences = QRCodePreferences.shared
        self.addSubview(codeView)
    }
}

// MARK: - Configure Sheet

extension QRCodeScreensaver {
    override var hasConfigureSheet: Bool {
        return true
    }
    
    override var configureSheet: NSWindow? {
        return nil
    }
}

// MARK: - Animation

extension QRCodeScreensaver {
    override var isAnimating: Bool {
        return true
    }
    
    override func startAnimation() {
        super.startAnimation()
    }
    
    override func stopAnimation() {
        super.stopAnimation()
    }
}

// MARK: - Timer

extension QRCodeScreensaver {
    @objc func animationLoopEventHandler() {
        self.setNeedsDisplay(self.bounds)
    }
}
