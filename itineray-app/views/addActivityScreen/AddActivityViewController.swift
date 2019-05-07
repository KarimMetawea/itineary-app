//
//  AddActivityViewController.swift
//  itineray-app
//
//  Created by karim metawea on 5/6/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit

class AddActivityViewController: UITableViewController {
    
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var dayPicker: UIPickerView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet var activityTypeButtons: [UIButton]!
    
    var tripIndex:Int!
    var trip:TripModel!
    var activityType:ActivityType = .unsualActivity
    var dayIndexToEdit:Int?
    var activityToEdit:ActivityModel?
    
    var doneUpdating:((ActivityModel,Int,Int)->())?
 
    
    var onSave:((ActivityModel,Int)->())?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let dayIndex = dayIndexToEdit , let activityToEdit = activityToEdit{
            activityLabel.text = "Edit Activity"
            dayPicker.selectRow(dayIndex, inComponent: 0, animated: true)
            titleTextField.text = activityToEdit.title
            subtitleTextField.text = activityToEdit.subTitle
            activityButtonPressed(activityTypeButtons![activityToEdit.activityType.rawValue])
            
            
        }
        
          activityButtonPressed(activityTypeButtons[activityType.rawValue])
    }
    
    
    @IBAction func activityButtonPressed(_ sender: UIButton) {
        activityTypeButtons.forEach({$0.tintColor = Theme.borderColor})
        
        sender.tintColor = Theme.accentColor
        
        switch sender.tag {
        case 1:
            activityType = .auto
        case 2:
            activityType = .unsualActivity
        case 3:
            activityType = .flight
        case 4:
            activityType = .food
        case 5:
            activityType = .hotel
        default:
            activityType = .unsualActivity
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: AnyObject) {
        let dayIndex = dayPicker.selectedRow(inComponent: 0)
        
        guard titleTextField.hasValue , let title = titleTextField.text else {return}
        
        if activityToEdit != nil {
            
            activityToEdit?.title = title
            activityToEdit?.subTitle = subtitleTextField.text ?? ""
            activityToEdit?.activityType = activityType
            self.doneUpdating?(activityToEdit!,dayIndexToEdit!,dayIndex)
            
            ActivityFunctions.updateActivity(tripIndex: tripIndex, oldDayIndex: dayIndexToEdit!, newDayIndex: dayIndex, activity: activityToEdit!)
            
        }else{
         
            let activity = ActivityModel(title: title, subTitle: subtitleTextField.text ?? "", activity: activityType)
            ActivityFunctions.createActivity(tripIndex: tripIndex, dayIndex: dayIndex, activity: activity)
            if let onSave = onSave {
                onSave(activity,dayIndex)
            }
            
        }
        
        
        
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func canceButtonPressed(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func finishedEditing(_ sender: UITextField) {
        sender.resignFirstResponder()
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
