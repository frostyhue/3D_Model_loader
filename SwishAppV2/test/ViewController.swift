//
//  ViewController.swift
//  SwishApp
//
//  Created by klant on 5/24/18.
//  Copyright © 2018 klant. All rights reserved.
//

import UIKit
import AVKit
import Vision

class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    let stringmodels = ["cassette","desktop computer", "iPod"];
    
    let identifierLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return } // get the back camera
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)    //input for capture session
        
        captureSession.startRunning()    // added privacy in the Info.plist
        
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)   // get the output
        previewLayer.frame = view.frame   //specify a frame for the preview layer
        
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        
        //        VNImageRequestHandler(cgImage: <#T##CGImage#>, options: [:]).perform(<#T##requests: [VNRequest]##[VNRequest]#>)
        
        setupIdentifierConfidenceLabel()
    }
    
    fileprivate func setupIdentifierConfidenceLabel() {
        view.addSubview(identifierLabel)
        identifierLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        identifierLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        identifierLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        identifierLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    /*func goToModel(){
     
     if(firstObservation.identifier == "mouse"){
     
     
     }
     } */
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //        print("Camera was able to capture a frame:", Date())
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        // added SqueezeNet + Resnet 50 (Detects the dominant objects present in an image from a set of 1000 categories such as trees, animals, food, vehicles, people, and more.) -> CoreML model that created custom class of Squeeze model
        
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else { return }
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in
            // //Core ML request to get the image that the camera sees
            
            
            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            
            guard let firstObservation = results.first else { return }  //  the first guess what the camera thinks the object is
            
            
            print(firstObservation.identifier, firstObservation.confidence)
            
            DispatchQueue.main.async {
                self.identifierLabel.text = "\(firstObservation.identifier) \(firstObservation.confidence * 100)"
                let element = firstObservation.identifier;
                
                if(self.stringmodels.contains(element)){
                    let alertController = UIAlertController(title: element.uppercased(),
                                                            message: "Do you want to work on " + element,
                                                            preferredStyle: .actionSheet)

                    
                    alertController.addAction(UIAlertAction(title: "Yes", style: .default) { _ in
                        
                        self.performSegue(withIdentifier: "gamesegue", sender: nil)
                    })
                    alertController.addAction(UIAlertAction(title: "No", style: .destructive) { _ in
                        _ = self.navigationController?.popToRootViewController(animated: true)
                    })
                    
                    self.present(alertController, animated: true)
                    
                }
            }
            
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    
    
    
}


