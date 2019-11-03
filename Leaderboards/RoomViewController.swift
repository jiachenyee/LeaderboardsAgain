//
//  RoomViewController.swift
//  Leaderboards
//
//  Created by JiaChen(: on 3/11/19.
//  Copyright © 2019 SST Inc. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Recieve room from another viewcontroller
    var room: Room!
    var groups: [(name: String, points: Int)]!
    
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        #warning("This is placeholder data. Replace before release")
        room = Room(name: "hello", editors: ["Jia chen", "Yin Jie", "Aurelius", "Shannen", "Sebastian"], domains: ["s2017.sst.edu.sg", "tk.sg"], code: "123123", groups: [(name: "Group 1", points: 12), (name: "Group 1", points: 11), (name: "Group 5", points: 32), (name: "Group 1", points: 1), (name: "Group 1", points: 121)], upperBound: 121)
        
        setUpSearchField()
        groups = setUpGroups()
        setUpTitleLabel()
    }
    
    func setUpSearchField() {
        if let textfield = searchField.value(forKey: "searchField") as? UITextField {
            textfield.backgroundColor = #colorLiteral(red: 0.1849887669, green: 0.2978751063, blue: 0.5611272454, alpha: 1)
            textfield.textColor = .white
                        
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = .white
            }
        }
    }
    
    func setUpTitleLabel() {
        titleLabel.text = room.name
    }
    
    func setUpGroups() -> [(name: String, points: Int)] {
        var groups = room.groups
        
        groups.sort { (valueOne, valueTwo) -> Bool in
            return valueOne.points > valueTwo.points
        }
        
        return groups
    }
    
    @IBAction func dismissButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "team", for: indexPath) as! TeamLeaderboardsTableViewCell
        
        // group ranking label set up
        cell.groupRankLabel.text = String(indexPath.row + 1)
        
        // Update progress indicator
        let maxWidth = UIScreen.main.bounds.width - 40
        let segmentWidth = maxWidth / CGFloat(room.upperBound)
        
        cell.editProgressIndicatorWidthContraint.constant = segmentWidth * CGFloat(groups[indexPath.row].points)
        
        // Set up group name
        cell.groupNameLabel.text = groups[indexPath.row].name
        
        return cell
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
