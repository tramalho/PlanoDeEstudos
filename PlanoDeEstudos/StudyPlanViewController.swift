//
//  StudyViewController.swift
//  PlanoDeEstudos
//
//  Created by Eric Brito
//  Copyright © 2017 Eric Brito. All rights reserved.

import UIKit

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
        
        sm.add(studyPlan: studyPlan)
        
        navigationController?.popViewController(animated: true)
    }
}
