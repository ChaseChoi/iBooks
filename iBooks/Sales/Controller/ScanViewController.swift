//
//  ScanViewController.swift
//  iBooks
//
//  Created by Chase Choi on 24/12/2017.
//  Copyright © 2017 Chase Choi. All rights reserved.
//

import UIKit
import AVFoundation

protocol ScanViewControllerDelegate: class {
    func scanViewController(_ controller: ScanViewController, finishScanning isbn: String)
}

class ScanViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    weak var delegate: ScanViewControllerDelegate?
    @IBOutlet weak var scanGridView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tipLabel: UILabel!
    
    var videoPreviewLayer = AVCaptureVideoPreviewLayer()
    // setup session
    let captureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        //test
////        let sampleIsbn = "9781451648539"
//        let sampleIsbn = "978121246678"
//        finishScanning(isbn: sampleIsbn)
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            warning(title: "相机识别失败", message: "请使用带有相机的设备", titleForAction: "好")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
        } catch {
            print(error)
        }
        let output = AVCaptureMetadataOutput()
        captureSession.addOutput(output)
        
        // set delegate
        output.setMetadataObjectsDelegate(self, queue: .main)
        output.metadataObjectTypes = [.ean13]
        
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer.frame = view.layer.bounds
        view.layer.addSublayer(videoPreviewLayer)
        view.bringSubview(toFront: scanGridView)
        view.bringSubview(toFront: closeButton)
        view.bringSubview(toFront: tipLabel)
        captureSession.startRunning()
    }
    

    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count != 0 {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject {
                if object.type == .ean13 {
                    captureSession.stopRunning()
                    finishScanning(isbn: object.stringValue!)
                }
            }
        }
        warning(title: "扫描失败", message: "请对准书本条形码", titleForAction: "好")
        
    }
    func warning(title: String, message: String, titleForAction: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: titleForAction, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func finishScanning(isbn: String) {
        let alert = UIAlertController(title: "扫描完成", message: "ISBN: \(isbn)", preferredStyle: .alert)
        // use closure 
        let action = UIAlertAction(title: "完成", style: .default, handler: {actions in self.delegate?.scanViewController(self, finishScanning: isbn)} )
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


