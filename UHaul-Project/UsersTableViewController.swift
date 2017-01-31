//
//  UsersTableViewController.swift
//  UHaul-Project
//
//  Created by youcef bouhafna on 1/30/17.
//  Copyright © 2017 Youcef. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {

    var usersList = [User]()
    var addressList = [Address]()
    override func viewDidLoad() {
        super.viewDidLoad()

        UserController.getUsers { (users) in
            DispatchQueue.main.async {
                self.usersList = users
                self.tableView.reloadData()
                print(self.usersList)
              
            }
        }
       
    }

    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return usersList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath)
        let user = usersList[indexPath.row]
        cell.textLabel?.text = user.username
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showUserPosts" {
            guard let cell = sender as? UITableViewCell else { return }
            let detailViewController = segue.destination as! PostsTableViewController
            let indexPath = self.tableView.indexPath(for: cell)!
            let userTopost = self.usersList[indexPath.row]
            detailViewController.detailUserPost = userTopost
            
        }
    }

}
