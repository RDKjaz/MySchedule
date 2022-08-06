//
//  TaskModel.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 05.08.2022.
//

import RealmSwift

class TaskModel: Object {
    @Persisted var date: Date?
    @Persisted var number: String = "Unknown"
    @Persisted var desc: String = "Unknown"
    @Persisted var isReady: Bool = false
}
