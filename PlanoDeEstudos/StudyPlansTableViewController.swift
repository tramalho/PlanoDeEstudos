//
//  NotificationsTableViewController.swift
//  PlanoDeEstudos
//
//  Created by Eric Brito
//  Copyright © 2017 Eric Brito. All rights reserved.
//

import UIKit

class StudyPlansTableViewController: UITableViewController {

    private let sm = StudyManager.shared
    
    private let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        
        df.dateFormat = "dd/MM/yy HH:mm"
        
        return df
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(onReceive(notificacion:)),
                                               name: StudyManager.CONFIRMED, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sm.studyPlans.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let studyPlan = sm.studyPlans[indexPath.row]
        
        cell.textLabel?.text = studyPlan.course
        cell.detailTextLabel?.text = dateFormatter.string(from: studyPlan.date)
        cell.backgroundColor = studyPlan.done ? .green : .white
        
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sm.remove(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
    }

    @objc private func onReceive(notificacion: Notification) {
        
        if let userInfo = notificacion.userInfo, let id = userInfo["id"] as? String {
            sm.setDone(id: id)
            tableView.reloadData()
        }
    }
}
