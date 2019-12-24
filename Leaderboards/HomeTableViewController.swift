//
//  HomeTableViewController.swift
//  Leaderboards
//
//  Created by JiaChen(: on 2/11/19.
//  Copyright © 2019 SST Inc. All rights reserved.
//

import UIKit
import AuthenticationServices

class HomeTableViewController: UITableViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    var identifer: String?
    var username: String?
    var emailAddress: String?
    
    @IBOutlet weak var userGreetingsLabel: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUserGreetingLabel()
        setUpSignOutButton()
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
    
    func setUpSignOutButton() {
        signOutButton.layer.cornerRadius = 12
        signOutButton.clipsToBounds = true
    }

    @IBAction func signOutButtonTapped(_ sender: Any) {
        // Delete user's data from device
        // Jump back to Sign In screen
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "Sign Up") as? SignUpViewController
                else { return }
            viewController.modalPresentationStyle = .formSheet
            viewController.isModalInPresentation = true
            self.present(viewController, animated: true, completion: nil)
        }

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

    // MARK: - CollectionView Datasource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myroom", for: indexPath) as! MyRoomsCollectionViewCell
        
        cell.layer.cornerRadius = 12
        cell.clipsToBounds = true
        
        return cell
    }
    
    // MARK: - CollectionView Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "room", sender: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
