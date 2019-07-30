//
//  ViewController.swift
//  FFSceneDetector
//
//  Created by zhou on 2019/7/30.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {

    // MARK: - IBOutLet
    @IBOutlet weak var scene: UIImageView!
    @IBOutlet weak var answerLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard let image = UIImage(named: "train_night") else { fatalError("no stating image") }
        
        scene.image = image
    }


    @IBAction func pickerImage(_ sender: UIButton) {
        
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .savedPhotosAlbum
        present(pickerController, animated: true, completion: nil)
    }
}

// MARK : - UIImagePickerControllerDelefate
extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // Local variable inserted by Swift 4.2 migrator
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        
        dismiss(animated: true, completion: nil)
        
        guard let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage else {
            fatalError("couldn't load image from Photos")
        }
        
        scene.image = image
        
        guard let ciImage = CIImage(image: image) else { fatalError("couldn't convert UIImage to CIImage") }
        
        detectScene(image: ciImage)
        
    }
}

// MARK: - UINavigationControllerDelegate
extension ViewController: UINavigationControllerDelegate {
    
}

// MARK: - Private functions
extension ViewController {
    func detectScene(image: CIImage) {
        answerLabel.text = "detecting scene..."
        
        // Load the ML model through its generated class
        guard let model = try? VNCoreMLModel(for: GoogLeNetPlaces().model) else { fatalError("can't load Places ML model") }
        
        // Define a Vision request service with the ML model
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard let results = request.results,
                let topResult = results.first as? VNClassificationObservation else
            {
                fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            // Update UI on main queue
            let article = (["a","e","i","o","u"].contains(topResult.identifier.first!)) ? "an" : "a"
            
            DispatchQueue.main.async { [weak self] in
                self?.answerLabel.text = "\(Int(topResult.confidence * 100))% it's \(article) \(topResult.identifier)"
            }
        }
        
        //Create a request handler with the image eprovided
        let handler = VNImageRequestHandler(ciImage: image)
        
        // Perform the request service with the request handler
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try handler.perform([request])
            } catch {
                print(error)
            }
        }
    }
}

// Helper function inserted by Swift 4.2 migrator
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by swift 4.3 migrator
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

