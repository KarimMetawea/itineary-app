//
//  ViewController.swift
//  itineray-app
//
//  Created by karim metawea on 4/14/19.
//  Copyright © 2019 karim metawea. All rights reserved.
//

import UIKit

class TripsViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addTripButton: UIButton!
//    the index of the trip the user is trying to edit
    var editedIndex:Int?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      tableView.delegate = self
      tableView.dataSource = self
        
//        making addTrip button rounded
       addTripButton.roundAndMakeShadow()
        
//        reading trips from TripFunctions class
        TripFunctions.readTrips {[weak self] in
            
         self?.tableView.reloadData()
        }
    }
    
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? CreateTripViewController else {return}
        
//        assigning the index of the trip to be edited
        vc.editedIndex = self.editedIndex
        
//        the closure to be excuted when pressing save in createTripView controller
        vc.onSave = { [weak self] in
            self?.tableView.reloadData()
        }
        
//    making the edited index equals nil in case the user creating a new trip
        editedIndex = nil
    }
}

extension TripsViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataModel.trips.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripsCell", for: indexPath) as! TripsCell
        
        cell.configureCell(trip: DataModel.trips[indexPath.row])
        
        return cell
    }
    
//    making a delete acttion when swiping
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "delete") { (action, view, success) in
            let ac = UIAlertController(title: "Delete Trip", message: "are you sure you want to delete this trip", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "ok", style: .default, handler: { (action) in
                TripFunctions.deleteTrip(index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                success(true)
            }))
            ac.addAction(UIAlertAction(title: "cancel", style: .destructive, handler: { (action) in
                success(false)
            }))
            self.present(ac,animated: true)
            
        }
       deleteAction.image = UIImage(named: "deleteButton")
       
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
//    making an edit action when swiping 
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self]  (action, view, success) in
            self?.performSegue(withIdentifier: "createtripsegue", sender: action)
            success(true)
        }
        editAction.image = UIImage(named: "edit")
        editAction.backgroundColor = Theme.borderColor
        editedIndex = indexPath.row
        
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    

}

