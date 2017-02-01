//
//  ViewAndAddPostViewController.swift
//  UHaul-Project
//
//  Created by youcef bouhafna on 1/31/17.
//  Copyright © 2017 Youcef. All rights reserved.
//

import UIKit

class ViewAndAddPostViewController: UIViewController {

        override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPostButtonTapped(_ sender: Any) {
        UserController.postRequest()
        
    }
    @IBAction func putButtontapped(_ sender: Any) {
        UserController.putRequest()
    }

    @IBAction func deleteButtonTapped(_ sender: Any) {
        UserController.delete()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
