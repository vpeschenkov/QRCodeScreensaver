//
//  QRCodeView.swift
//  QRCodeCore
//
//  Created by Victor Peschenkov on 6/10/19.
//  Copyright © 2019 Victor Peschenkov. All rights reserved.
//

import Cocoa
import QuartzCore

open class QRCodeView: NSView {
    public var preferences: QRCodePreferences? {
        didSet {
            guard let preferences = self.preferences else {
                return
            }
            let message = preferences.message.data(using: .isoLatin1, allowLossyConversion: false)!
            if let image = buildQRCodeImage(for: message) {
                QRCodeImage = image
            }
            self.setNeedsDisplay(self.bounds)
            self.displayIfNeeded()
        }
    }
    
    private var QRCodeImage: CGImage?
    
    open override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        guard let QRCodeImage = QRCodeImage else {
            return
        }
        
        if let context = NSGraphicsContext.current?.cgContext {
            context.setFillColor(CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0))
            context.fill(dirtyRect)
            
            let width = min(bounds.size.width, bounds.size.height) * 0.55
            let height = width
            let size = CGRect(
                x: (bounds.size.width - width) / 2.0,
                y: (bounds.size.height - height) / 2.0,
                width: width,
                height: height
            )
            
            context.draw(QRCodeImage, in: size)
        }
    }
    
    // MARK: - Pirivate Methods
    
    private func buildQRCodeImage(for message: Data) -> CGImage? {
        let filter = CIFilter(name: "CIQRCodeGenerator")!
        filter.setValue(message, forKey: "inputMessage")
        filter.setValue("Q", forKey: "inputCorrectionLevel")
        if let image = filter.outputImage?.transformed(by: CGAffineTransform(scaleX: 10.0, y: 10.0)) {
            return CIContext(options: nil).createCGImage(image, from: image.extent)
        }
        return nil
    }
}
