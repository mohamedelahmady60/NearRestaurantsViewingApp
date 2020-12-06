//
//  RestaurantsListTableViewController.swift
//  RestaurantViewingApp
//
//  Created by Mo Elahmady on 11/14/20.
//  Copyright © 2020 Mo Elahmady. All rights reserved.
//

import UIKit
import AlamofireImage

protocol RestaurantsListTableViewControllerDelegate: class {
    func didTapCell(_ viewController: UIViewController, viewModel:RestaurantListTableViewCellDataModel)
}



class RestaurantsListTableViewController: UITableViewController {

    
    // the cell data that sent from the AppDelegate
    var restaurantListTableViewTotalCellsDataModel = [RestaurantListTableViewCellDataModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    weak var delegate: RestaurantsListTableViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantListTableViewTotalCellsDataModel.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestauranstListCell", for: indexPath) as! RestaurantsListsTableViewCell
        //get the current cell data
        let resturantListTableViewCurrentCellDataModel = restaurantListTableViewTotalCellsDataModel[indexPath.row]
        //Configure the cell
        cell.configure(CellDataModel: resturantListTableViewCurrentCellDataModel)
        
        return cell
    }
    
    //MARK: - Table view delegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let restaurantDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "RestaurantDetailsViewController") else { return }
        navigationController?.pushViewController(restaurantDetailsViewController, animated: true)
        
        let viewModel = restaurantListTableViewTotalCellsDataModel[indexPath.row]
        delegate?.didTapCell(restaurantDetailsViewController, viewModel: viewModel)
    }

}
