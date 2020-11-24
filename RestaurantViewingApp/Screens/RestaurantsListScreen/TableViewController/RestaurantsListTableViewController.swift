//
//  RestaurantsListTableViewController.swift
//  RestaurantViewingApp
//
//  Created by Mo Elahmady on 11/14/20.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantsListTableViewController: UITableViewController {

    
    // the cell data that sent from the AppDelegate
    var resturantListTableViewTotalCellsDataModel = [ResturantListTableViewCellDataModel]() {
        
        didSet {
            tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resturantListTableViewTotalCellsDataModel.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestauranstListCell", for: indexPath) as! RestaurantsListsTableViewCell
        //get the current cell data
        let resturantListTableViewCurrentCellDataModel = resturantListTableViewTotalCellsDataModel[indexPath.row]
        //Configure the cell
        cell.configure(CellDataModel: resturantListTableViewCurrentCellDataModel)
        
        return cell
    }
    

}
