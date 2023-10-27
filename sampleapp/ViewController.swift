//
//  ViewController.swift
//  sampleapp
//
//  Created by Mau Tonelli on 26/10/23.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addText: UITextField!
    
    let app = App(id: "application-sampleapp-reiug")
    var realm = try! Realm()
    
    @Published var user: User?
    @Published var configuration: Realm.Configuration?
    @Published shops: Results<Shop>
    
    @objc func initialRealm() async {
        user = try? await app?.login(credentials: Credentials.anonymous)
        self.configuration = user?.flexibleSyncConfiguration(initialSubscriptions: { SyncSubscriptionSet in
            if let _ = SyncSubscriptionSet.first(named: "all-shops") {
                return
            } else {
                SyncSubscription.append(QuerySubscription<Shop>(name: "all-shops"))
            }
        }, rerunOnOpen: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func addAction(_ sender: Any) {
    }
    
}

