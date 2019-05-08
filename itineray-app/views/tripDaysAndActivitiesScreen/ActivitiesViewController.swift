//
//  ActivitiesViewController.swift
//  itineray-app
//
//  Created by karim metawea on 4/28/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit

class ActivitiesViewController: UIViewController {
    
    var tripId:UUID!
    var trip:TripModel?
    var headerCellHeight:CGFloat = 0.0
    var ativityCellHeight:CGFloat = 0.0
    var tripTitle = ""
    @IBOutlet weak var addDaysButton: UIButton!
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
          self.title = self.tripTitle
        addDaysButton.roundAndMakeShadow()
        loadTripData()
        
        let height = tableView.dequeueReusableCell(withIdentifier: "HeaderDaysCell")?.contentView.bounds.height ?? 0
        headerCellHeight = height
        ativityCellHeight = tableView.dequeueReusableCell(withIdentifier: "activityCell")?.contentView.bounds.height ?? 0
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButtonPressed(_ sender: AnyObject) {
        
//        pops up an actionsheet to chose wether to add a day or activity
        let ac = UIAlertController(title: "add to your Trip", message: "what would you like to add", preferredStyle: .actionSheet)
        let dayAction = UIAlertAction(title: "Add Day", style: .default , handler: handleAddDay)
        
        
        let activityAction = UIAlertAction(title: "Add Activity", style: .default , handler:handleAddActivity)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler:handleCancelAction)
        
        if trip?.days.count == 0 {
            activityAction.isEnabled = false
        }
        ac.addAction(dayAction)
        ac.addAction(activityAction)
        ac.addAction(cancelAction)
        
        ac.view.tintColor = Theme.backGroundColor
        self.present(ac,animated: true)
    }
    
    
    
    func handleAddDay(action:UIAlertAction) {
        let storyboard = UIStoryboard(name: String(describing: AddDayViewController.self), bundle: nil)
        let vc = storyboard.instantiateInitialViewController()! as! AddDayViewController
        vc.tripIndex = getTripIndex()
        vc.tripModel = trip
        
        vc.onSave = {[weak self] dayModel in
            guard let strongSelf = self else { return }
//            it needs to be called before appending daymodel to ensure trip.count matchs
           strongSelf.trip?.days.append(dayModel)
            
            let index = strongSelf.trip?.days.firstIndex(where: { (model) -> Bool in
                model.title == dayModel.title
            })
                strongSelf.tableView.insertSections(IndexSet([index ?? 0]) , with: .automatic)

            
        }
        
        present(vc,animated: true)
    }
    
    
    fileprivate func getTripIndex() -> Int {
        return DataModel.trips.firstIndex(where: { $0.id == tripId
        })!
    }
    
    
    
    func handleAddActivity(action:UIAlertAction) {
        let storyboard = UIStoryboard(name: String(describing: AddActivityViewController.self), bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! AddActivityViewController
        vc.trip = trip
        vc.tripIndex = getTripIndex()
        vc.onSave = {[weak self] activityModel,dayIndex in
            guard let strongSelf = self else { return }
            
            //            it needs to be called before appending daymodel to ensure trip.count matchs
            strongSelf.trip?.days[dayIndex].activities.append(activityModel)

            let row = (strongSelf.trip?.days[dayIndex].activities.count)! - 1
        
            let indexPath = IndexPath(row: row , section: dayIndex)
            strongSelf.tableView.insertRows(at: [indexPath], with: .automatic)
//            strongSelf.tableView.reloadData()
            
        }
        
        present(vc,animated: true)
    }
    
    
    
    func handleCancelAction(action:UIAlertAction) {
        
    }
    
    
    
    fileprivate func loadTripData() {
        TripFunctions.readTripsById(id: tripId) { [weak self] (trip) in
            guard let self = self else {return}
            self.trip = trip
            
            guard let trip = trip else {return}
            self.backGroundImage.image = trip.image
            self.tableView.reloadData()
        }
    }
    
    @IBAction func toggleEditMode(_ sender: UIBarButtonItem) {
        tableView.isEditing.toggle()
        sender.title = sender.title == "Edit" ? "Done":"Edit"
    }
    
   
    
}

extension ActivitiesViewController:UITableViewDelegate,UITableViewDataSource{
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let trip = trip else {return 0}
        return trip.days.count
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        //        customizing the table view header using HeaderDaysCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderDaysCell") as! HeaderDaysCell
        
         guard let dayModel = trip?.days[section] else {return cell.contentView}
        
        cell.configureCell(dayModel: dayModel)
        return cell.contentView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return headerCellHeight
    }
    //    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    //        return trip?.days[section].title
    //    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trip?.days[section].activities.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "activityCell", for: indexPath) as! ActivityCell
        guard let activity = trip?.days[indexPath.section].activities[indexPath.row] else {return UITableViewCell()}
        cell.configureCell(activityModel: activity)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ativityCellHeight
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
         let activity = trip!.days[indexPath.section].activities[indexPath.row]
        
        
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { (action, view, success) in
        
            let ac = UIAlertController(title: "Delete Activity", message: "are you sure you want to delete this activity", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action) in
                
                ActivityFunctions.deleteActivity(tripIndex: self.getTripIndex(), dayIndex: indexPath.section, activity: activity)
                self.trip!.days[indexPath.section].activities.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                success(true)
            }))
            ac.addAction(UIAlertAction(title: "cancel", style: .destructive, handler: { (action) in
                success(false)
            }))
            self.present(ac,animated: true)
            
        }
        deleteAction.image = UIImage(named: "deleteButton")
        deleteAction.backgroundColor = Theme.accentColor
        
        
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self]  (action, view, success) in
            let storboard  = UIStoryboard(name: String(describing: AddActivityViewController.self), bundle: nil)
            let vc = storboard.instantiateInitialViewController() as! AddActivityViewController
            vc.tripIndex = self?.getTripIndex()
            vc.trip = self?.trip
            vc.dayIndexToEdit = indexPath.section
            vc.activityToEdit = self?.trip?.days[indexPath.section].activities[indexPath.row]
            
            vc.doneUpdating = {[weak self] activity, oldIndex, newIndex in
                guard let strongSelf = self else { return }
                let oldActivityIndex = strongSelf.trip?.days[oldIndex].activities.firstIndex(where: { (model) -> Bool in
                    model.id == activity.id
                })
                
                if oldIndex == newIndex{
                    strongSelf.trip?.days[oldIndex].activities[oldActivityIndex!] = activity
                    let indexPath = IndexPath(row: oldActivityIndex!, section: oldIndex)
                    tableView.reloadRows(at: [indexPath], with: .automatic)
                } else {
                    strongSelf.trip?.days[oldIndex].activities.remove(at: oldActivityIndex!)
                    strongSelf.trip?.days[newIndex].activities.append(activity)
                    let newActivityIndex = strongSelf.trip?.days[newIndex].activities.firstIndex(where: { (model) -> Bool in
                        model.id == activity.id
                    })
                    
                    strongSelf.tableView.performBatchUpdates({
                        
                        strongSelf.tableView.deleteRows(at: [indexPath], with: .fade)
                        
                        let insertIndexPath = IndexPath(row: newActivityIndex!, section: newIndex)
                        strongSelf.tableView.insertRows(at: [insertIndexPath], with: .automatic)
                    })
                }
                
                
            }
            
            
            
            
            self?.present(vc,animated: true)
            
            success(true)
        }
      
        editAction.image = #imageLiteral(resourceName: "edit")
        editAction.backgroundColor = Theme.borderColor
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let activity = (trip?.days[sourceIndexPath.section].activities[sourceIndexPath.row])!
        
        trip?.days[sourceIndexPath.section].activities.remove(at: sourceIndexPath.row)
        trip?.days[destinationIndexPath.section].activities.insert(activity,at: destinationIndexPath.row)
        ActivityFunctions.reorderActivity(tripIndex: getTripIndex(), oldDayIndex: sourceIndexPath.section, newDayIndex: destinationIndexPath.section, newActivityIndex: destinationIndexPath.row, activity: activity)


    }
    
}
