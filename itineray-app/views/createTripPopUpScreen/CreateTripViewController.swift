//
//  CreateTripViewController.swift
//  itineray-app
//
//  Created by karim metawea on 4/23/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit
import Photos

class CreateTripViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tripNameTextFiield: UITextField!
    var image:UIImage?
    
    var onSave:(()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        saveButton.roundAndMakeShadow()
        cancelButton.roundAndMakeShadow()

    }
    
    
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        guard tripNameTextFiield.text != "" , let tripName = tripNameTextFiield.text else {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
            label.text = "❗️"
            label.font = UIFont(name: "Avenir", size: 20)
            tripNameTextFiield.rightView = label
            tripNameTextFiield.rightViewMode = .unlessEditing
            return
            
        }
        TripFunctions.createTrip(trip: TripModel(title: tripName, image: image))
        if let onSave = onSave{
            onSave()
        }
        dismiss(animated: true)

    }
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true)
    }
    fileprivate func presentPickerController() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker,animated: true)
    }
    
    
    @IBAction func cameraButtonPressed(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            PHPhotoLibrary.requestAuthorization { (status) in
                switch status {
                    
                case .notDetermined:
                    if status == PHAuthorizationStatus.authorized{
                        self.presentPickerController()
                    }
                case .restricted:
                    let ac = UIAlertController(title: "Access Restricted", message: "you restricted this app from using photo library you can enable it in phone settings", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                    self.present(ac,animated: true)
                    
                case .denied:
                    let ac = UIAlertController(title: "access denied", message: "you denied this app from using photo library you can enable it in phone settings", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "ok", style: .default))
                    ac.addAction(UIAlertAction(title: "Go Settings", style: .default, handler: { (_) in
                        DispatchQueue.main.async {
                            let url = URL(string: UIApplication.openSettingsURLString)!
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)

                        }
                    }))
                    self.present(ac,animated: true)
                    
                case .authorized:
                self.presentPickerController()
              
                }
            }
        }
    }

}
extension CreateTripViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = image
        }
        dismiss(animated: true, completion: nil)
    }
}
