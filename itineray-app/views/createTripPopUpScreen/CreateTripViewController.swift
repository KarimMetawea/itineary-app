//
//  CreateTripViewController.swift
//  itineray-app
//
//  Created by karim metawea on 4/23/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit

class CreateTripViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tripNameTextFiield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        saveButton.roundAndMakeShadow()
        cancelButton.roundAndMakeShadow()

    }
    

    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true)

    }
    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true)
    }

}
