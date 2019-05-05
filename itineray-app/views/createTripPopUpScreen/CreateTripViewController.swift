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

    @IBOutlet weak var tripLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tripNameTextFiield: UITextField!
//    the trip image the user will choose
    var image:UIImage?
//    the index of the trip the user wants to edit
    var editedIndex:Int?
//    the function that should be excuted when the use taps save button
    var onSave:(()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//       making the button rounded
        saveButton.roundAndMakeShadow()
        cancelButton.roundAndMakeShadow()
//        checking if there is an index for the trip if there is it means the user is editing this trip
        if let index = editedIndex{
            let trip = DataModel.trips[index]
            tripNameTextFiield.text = trip.title
            image = trip.image
            tripLabel.text = "Edit Trip"
        }

    }
    
    
    
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        
        guard tripNameTextFiield.hasValue , let tripName = tripNameTextFiield.text else {return}
//        checking whether we are in editing mode or creating new trip
        if let index = editedIndex{
            TripFunctions.updateTrip(index: index, name: tripName, image: image)
        } else {
            TripFunctions.createTrip(trip: TripModel(title: tripName, image: image))
            }
        if let onSave = onSave{
//            excuting the closure assinged from TripsViewController in the prepare for segue method
            onSave()
            dismiss(animated: true)
        }
        

    }
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true)
    }
    
//    creating a UIImagePicker controller
    fileprivate func presentPickerController() {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker,animated: true)
    }
    
//
    @IBAction func cameraButtonPressed(_ sender: Any) {
        
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
//                            opening the user settings
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

extension CreateTripViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    
//    delegate methods for choosing an image from library
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
//        assigning the choosen image from photo library to image variable of the trip
        if let image = info[.editedImage] as? UIImage {
            self.image = image
        }
//        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            self.image = image
//        }
        
        dismiss(animated: true, completion: nil)
    }
}
