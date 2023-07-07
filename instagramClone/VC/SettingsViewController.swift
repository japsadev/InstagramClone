//
//  SettingsViewController.swift
//  instagramClone
//
//  Created by Salih Yusuf Göktaş on 6.07.2023.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
	@IBAction func logoutClicked(_ sender: Any) {
		do {
			try Auth.auth().signOut()
			self.performSegue(withIdentifier: "toViewController", sender: nil)
		} catch {
			
		}
		
	}
}
