//
//  FeedViewController.swift
//  instagramClone
//
//  Created by Salih Yusuf Göktaş on 6.07.2023.
//

import UIKit
import Firebase
import SDWebImage
import FirebaseFirestore

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

	@IBOutlet weak var tableView: UITableView!
	
	var userEmailArray = [String]()
	var userCommentArray = [String]()
	var likeArray = [Int]()
	var userImageArray = [String]()
	var documentIDArray = [String]()
	
	override func viewDidLoad() {
        super.viewDidLoad()

		getDataFromFirestone()
		
		tableView.delegate = self
		tableView.dataSource = self
		
    }
	
	func getDataFromFirestone() {
		
		let fireStoreDatabase = Firestore.firestore()
		
		fireStoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
			if error != nil {
				print(error?.localizedDescription)
			} else {
				if snapshot?.isEmpty != true && snapshot != nil {
					
					self.userImageArray.removeAll(keepingCapacity: false)
					self.userEmailArray.removeAll(keepingCapacity: false)
					self.userCommentArray.removeAll(keepingCapacity: false)
					self.documentIDArray.removeAll(keepingCapacity: false)
					self.likeArray.removeAll(keepingCapacity: false)
					
					for document in snapshot!.documents {
						let documentID = document.documentID
						self.documentIDArray.append(documentID)
						
						
						if let postedBy = document.get("postedBy") as? String {
						self.userEmailArray.append(postedBy)
						}
						
						if let postComment = document.get("postComment") as? String {
						self.userCommentArray.append(postComment)
						}

						if let likes = document.get("likes") as? Int {
						self.likeArray.append(likes)
						}
						
						if let imageUrl = document.get("imageUrl") as? String {
						self.userImageArray.append(imageUrl)
						}
						
					}
					
					self.tableView.reloadData()
				}
			}
		}
	}
    
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return userEmailArray.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
		cell.userEmailLabel.text = userEmailArray[indexPath.row]
		cell.likeLabel.text = String(likeArray[indexPath.row])
		cell.commentLabel.text = userCommentArray[indexPath.row]
		cell.documentIDLabel.text = documentIDArray[indexPath.row]
		cell.userImageView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
	return cell
	}

}
