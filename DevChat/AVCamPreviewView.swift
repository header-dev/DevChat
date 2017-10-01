//
//  CameraPreviewView.swift
//  DevChat
//
//  Created by kritawit bunket on 8/23/2560 BE.
//  Copyright © 2560 headerdevs. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


class AVCamPreviewView: UIView {
    
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        
        guard let layer = layer as? AVCaptureVideoPreviewLayer else {
            
            fatalError("Expected `AVCaptureVideoPreviewLayer` type for layer. Check PreviewView.layerClass implementation.")
            
        }
        
        return layer
        
    }
    
    
    var session: AVCaptureSession? {
        get {
            return (self.layer as! AVCaptureVideoPreviewLayer).session
        }
        set (session) {
            (self.layer as! AVCaptureVideoPreviewLayer).session = session
        }
    }
    
    override class var layerClass : AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
}
