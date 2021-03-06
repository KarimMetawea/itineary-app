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
    @IBOutlet var helpView: UIVisualEffectView!
    @IBOutlet weak var logoImageView: UIImageView!
    //    the index of the trip the user is trying to edit
    var editedIndex:Int?
//    constants
    let seenHelpView = "seenHelpView"
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImageView.isHidden = true
        
      tableView.delegate = self
      tableView.dataSource = self
        
//        making addTrip button rounded
       addTripButton.roundAndMakeShadow()
        
//        reading trips from TripFunctions class
        TripFunctions.readTrips {[unowned self] in
            
         self.tableView.reloadData()
            if DataModel.trips.count > 0 {
//                checking if the user seen the helpView and if there is cells to be seen
                if UserDefaults.standard.bool(forKey: self.seenHelpView) == false {
                    self.helpView.frame = self.view.bounds
                    self.view.addSubview(self.helpView)
                }
            }else {
                self.logoImageView.isHidden = false
                UIView.animate(withDuration: 1, delay: 0, options: [.curveEaseIn], animations: {
                    self.logoImageView.alpha = 0
                    self.logoImageView.transform  = CGAffineTransform(rotationAngle: CGFloat(Double.pi)).scaledBy(x: 2, y: 2)
                    
                    //            let xRotation = CATransform3DMakeRotation(CGFloat(Double.pi), 1, 0, 0)
                    //            self.logoImageView.layer.transform = CATransform3DConcat( self.logoImageView.layer.transform, xRotation)
                    
                }, completion: nil)
            }
            
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
    @IBAction func helpViewCancelButtonPressed(_ sender: Any) {
        helpView.removeFromSuperview()
        UserDefaults.standard.set(true, forKey: seenHelpView)
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
       deleteAction.backgroundColor = Theme.accentColor
        
       
       
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
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let trip = DataModel.trips[indexPath.row]
        
//        navigating to activities viewController
        let vc = storyboard?.instantiateViewController(withIdentifier: "activitiesViewController") as! ActivitiesViewController
        vc.tripId = trip.id
        vc.tripTitle = trip.title
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    

}

