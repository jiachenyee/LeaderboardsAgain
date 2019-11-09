//
//  NewRoomTableViewController.swift
//  Leaderboards
//
//  Created by JiaChen(: on 2/11/19.
//  Copyright © 2019 SST Inc. All rights reserved.
//

import UIKit

class NewRoomTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 7
    }
    
    @IBAction func editorsTextChanged(_ sender: UITextField) {
        sender.attributedText = coloredCommas(with: sender.text ?? "")
    }
    
    @IBAction func groupNamesTextChanged(_ sender: UITextField) {
        sender.attributedText = coloredCommas(with: sender.text ?? "")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
