//
//  StudyManager.swift
//  PlanoDeEstudos
//
//  Created by Thiago Antonio Ramalho on 17/01/21.
//  Copyright © 2021 Eric Brito. All rights reserved.
//

import Foundation
import UserNotifications

class StudyManager{

    static let CONFIRMED = NSNotification.Name(rawValue: "confirmed")
    
    private static let KEY = "KEY"
    
    static let shared = StudyManager()
    
    private let ud = UserDefaults.standard
    
    var studyPlans: [StudyPlan] = []
    
    private init() {
        if let data = ud.data(forKey: StudyManager.KEY),
            let plans = try? JSONDecoder().decode([StudyPlan].self, from: data) {
            self.studyPlans = plans
        }
    }
    
    private func save() {
        if let data = try? JSONEncoder().encode(self.studyPlans) {
            ud.set(data, forKey: StudyManager.KEY)
        }
    }
    
    func add(studyPlan: StudyPlan) {
        self.studyPlans.append(studyPlan)
        save()
    }
    
    func remove(index: Int) {
        
        let center = UNUserNotificationCenter.current()
        
        let id = self.studyPlans[index].id
        
        center.removePendingNotificationRequests(withIdentifiers: [id])
        
        self.studyPlans.remove(at: index)
        save()
    }
    
    func setDone(id: String) {
        
        if let studyPlan = studyPlans.first(where: {$0.id == id}) {
            studyPlan.done = true
            save()
        }
    }
}
