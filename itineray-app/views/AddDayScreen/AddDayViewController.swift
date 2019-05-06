//
//  AddDayViewController.swift
//  itineray-app
//
//  Created by karim metawea on 5/5/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit

class AddDayViewController: UIViewController {

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var subtitleTextField: UITextField!
    //    the trip image the user will choose
    //    the index of the trip the user wants to edit
    var tripIndex:Int!
    //    the function that should be excuted when the use taps save button
    
    var tripModel:TripModel!
    var onSave:((DayModel)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //       making the button rounded
        saveButton.roundAndMakeShadow()
        cancelButton.roundAndMakeShadow()
        //        checking if there is an index for the trip if there is it means the user is editing this trip
//        if let index = editedIndex{
//            let trip = DataModel.trips[index]
//            dayTitleTextFiield.text = trip.title
//
//            dayLabel.text = "Edit Trip"
//        }
        
    }
    
    
    
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        if alreadyExistingDate(datePicker.date) {
            let ac = UIAlertController(title: "date already Exists", message: "choose another day", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .default))
            
            present(ac,animated: true)
            return
        }
        
        
        let day = DayModel(title:datePicker.date, subTitle: subtitleTextField.text ?? "")
        
        DayFunctions.createDay(tripIndex: tripIndex, day: day)
        
        
        
        if let onSave = onSave {
            onSave(day)
            dismiss(animated: true)
        }
        
        }
    
    func alreadyExistingDate(_ date:Date) -> Bool {
        if tripModel.days.contains(where: {$0.title.mediumDate() == date.mediumDate()}){
            return true
        }
        return false
    }
        
  

    @IBAction func cancelButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true)
    }
    

}

extension AddDayViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       subtitleTextField.resignFirstResponder()
        return true
    }
    
}
