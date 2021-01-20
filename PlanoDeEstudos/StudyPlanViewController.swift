//
//  StudyViewController.swift
//  PlanoDeEstudos
//
//  Created by Eric Brito
//  Copyright © 2017 Eric Brito. All rights reserved.

import UIKit
import UserNotifications

class StudyPlanViewController: UIViewController {

    @IBOutlet weak var tfCourse: UITextField!
    @IBOutlet weak var tfSection: UITextField!
    @IBOutlet weak var dpDate: UIDatePicker!
    
    private let sm = StudyManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dpDate.minimumDate = Date()
    }
    
    @IBAction func schedule(_ sender: UIButton) {
        
        let id = String(Date().timeIntervalSince1970)
        
        let studyPlan = StudyPlan(course: tfCourse.text!, section: tfSection.text!, date: dpDate.date, done: false, id: id)
        
        addNotificationCenter(studyPlan)
        
        sm.add(studyPlan: studyPlan)
        
        navigationController?.popViewController(animated: true)
    }
    
    fileprivate func addNotificationCenter(_ studyPlan: StudyPlan) {
        let content = UNMutableNotificationContent()
        content.title = "Lembrete"
        content.subtitle = "Matéria\(studyPlan.course)"
        content.body = "Estudar: \(studyPlan.section)"
        content.categoryIdentifier = content.title
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        
        let request = UNNotificationRequest(identifier: studyPlan.id, content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        
        center.add(request, withCompletionHandler: nil)
    }
}
