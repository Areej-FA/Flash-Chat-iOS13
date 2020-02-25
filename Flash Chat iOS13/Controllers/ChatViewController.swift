//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import ProgressHUD

class ChatViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages : [Message] = [
        Message(sender: "1@1.com", body: "Hey"),
        Message(sender: "1@2.com", body: "Hello"),
        Message(sender: "1@1.com", body: "How is it going?"),
        Message(sender: "1@1.com", body: " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin posuere suscipit volutpat. Aliquam ullamcorper lectus eu enim eleifend, sit amet laoreet lorem congue. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Ut et pretium erat, ac tincidunt tortor. Donec in ornare erat. Phasellus eget ligula maximus, ornare libero sit amet, rhoncus nulla. Aliquam nisi ligula, ullamcorper nec tincidunt ac, eleifend ut purus. Morbi interdum justo dignissim libero ultrices faucibus.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        title = K.appName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text , let messageSender = Auth.auth().currentUser?.email{
            db.collection(K.FStore.collectionName).addDocument(data: [
                K.FStore.senderField : messageSender,
                K.FStore.bodyField : messageBody
            ]) { (error) in
                if let e = error{
                    print(e.localizedDescription)
                    ProgressHUD.showError(e.localizedDescription)
                } else {
                    ProgressHUD.showSuccess("successfuly saved data")
                }
            }
        }
        
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
            ProgressHUD.showError(signOutError.localizedDescription)
        }
        
    }
    
}


//MARK: - UITableViewDataSource

extension ChatViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath) as! MessageCell
        cell.label.text = messages[indexPath.row].body
        return cell
    }
    
}



