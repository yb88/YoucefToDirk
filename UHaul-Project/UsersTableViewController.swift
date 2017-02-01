//
//  UsersTableViewController.swift
//  UHaul-Project
//
//  Created by youcef bouhafna on 1/30/17.
//  Copyright © 2017 Youcef. All rights reserved.
//

import UIKit

class UsersTableViewController: UITableViewController {
    

    @IBOutlet weak var label: UILabel!

    var usersList = [User]()
    var valueToPass: Int?
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
    override func viewWillAppear(_ animated: Bool) {
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
        
        // i should have done with custom cell instead of using the bang operator each time to be able to perform safely
        cell.textLabel?.text = (user.username + " " + " " + user.lat! + " " + user.lng!)
        cell.detailTextLabel?.text = (user.street! + " " + user.suite! + " " + user.zipcode! + " " + user.city!)
        return cell
    }



    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showUserPosts" {
//            guard let cell = sender as? UITableViewCell else { return }
            let detailViewController = segue.destination as! PostsTableViewController
            let indexPath = self.tableView.indexPathForSelectedRow
             let userTopost = self.usersList[(indexPath?.row)!].id
            detailViewController.detailUserPost? = userTopost
            
        }
    }
    
    


}
