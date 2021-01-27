//
//  ChatViewController.swift
//  00BF Talk
//
//  Created by Jenny Woorim Lee on 2020/12/11.
//

import UIKit
import Firebase

class ChatViewController : UIViewController{
    
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    
    var messages: [Message] = [
        Message(sender: "1@2.com", body: "Hey"),
        Message(sender: "1@b.com", body: "Hello"),
        Message(sender: "1@2.com", body: "What's up???")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        navigationItem.hidesBackButton = true
        navigationItem.title = "#00BF Talk"
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        loadMessages()
        
    
            }
    
    func loadMessages(){
        
        db.collection("messages").order(by: "date").addSnapshotListener{ (querySnapshot, error) in
            self.messages = []
            if let e = error {
                print("Issue retrieving data\(e)")
            } else{
                if let snap = querySnapshot?.documents {
                    for doc in snap {
                        //print(doc.data()) //["sender": 1@123.com, "body": Message]
                        let data = doc.data()
                        if let nsender = data["sender"] as? String, let nmessage = data["body"] as? String{
                            print(nsender, nmessage)
                            let new = Message(sender: nsender, body: nmessage)
                            self.messages.append(new)
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
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
        }
      
    }
    
    @IBAction func sendButtonPressed(_ sender: UIButton) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email{
            db.collection("messages").addDocument(data: ["sender":messageSender, "body":messageBody, "date":Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    print("There was an issue, \(e)")
                } else{
                    print("success")
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                    
                }
            }
        }
    }
}


extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! TableViewCell
        cell.label.text = message.body
        
        if message.sender == Auth.auth().currentUser?.email{// current user
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: "backgroundColor")
            cell.label.textColor = UIColor(named: "textColor")
            
        }
        else{
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: "lightBackgroundColor")
            cell.label.textColor = UIColor(named: "lightTextColor")

        }
        
        return cell
    }

}

extension ChatViewController: UITableViewDelegate {
    
}
