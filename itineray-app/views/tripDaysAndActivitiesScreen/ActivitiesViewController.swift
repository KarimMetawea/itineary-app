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
    @IBOutlet weak var backGroundImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TripFunctions.readTripsById(id: tripId) { [weak self] (trip) in
            guard let self = self else {return}
            self.trip = trip
            
            guard let trip = trip else {return}
            self.title = trip.title
            self.backGroundImage.image = trip.image
            self.tableView.reloadData()
        }
        
        let height = tableView.dequeueReusableCell(withIdentifier: "HeaderDaysCell")?.contentView.bounds.height ?? 0
        headerCellHeight = height
        ativityCellHeight = tableView.dequeueReusableCell(withIdentifier: "activityCell")?.contentView.bounds.height ?? 0
        
        // Do any additional setup after loading the view.
    }
    
    
   
    
}

extension ActivitiesViewController:UITableViewDelegate,UITableViewDataSource{
    //MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let trip = trip else {return 0}
        return trip.days.count
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let dayModel = trip?.days[section] else {return UIView()}
        //        customizing the table view header using HeaderDaysCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderDaysCell") as! HeaderDaysCell
        cell.configureCell(dayModel: dayModel)
        return cell.contentView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderDaysCell")
        
        return cell?.contentView.bounds.height ?? 0
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
    
    
}
