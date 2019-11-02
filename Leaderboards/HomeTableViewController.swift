//
//  HomeTableViewController.swift
//  Leaderboards
//
//  Created by JiaChen(: on 2/11/19.
//  Copyright © 2019 SST Inc. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    var identifer: String?
    var username: String?
    var emailAddress: String?
    
    @IBOutlet weak var userGreetingsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    // MARK: - User interface
    func setUpUserGreetingLabel() {
        // NSAttributedString for bolding the username
        let defaultAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 30)]
        let boldAttribute = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 30)]
        
        let attributes = NSMutableAttributedString(string: "Hey \(username ?? ""),", attributes: defaultAttributes)
        
        attributes.addAttributes(boldAttribute, range: NSRange(location: 4, length: (username?.count ?? 0) + 1))
        
        userGreetingsLabel.attributedText = attributes
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
