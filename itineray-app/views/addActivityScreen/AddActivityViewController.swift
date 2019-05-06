//
//  AddActivityViewController.swift
//  itineray-app
//
//  Created by karim metawea on 5/6/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit

class AddActivityViewController: UIViewController {
    
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var dayPicker: UIPickerView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    
    var tripIndex:Int!
    var trip:TripModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func canceButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}

extension AddActivityViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return trip.days.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return trip.days[row].title.mediumDate()
    }
    
    
}
