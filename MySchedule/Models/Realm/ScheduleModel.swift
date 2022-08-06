//
//  ScheduleModel.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 05.08.2022.
//

import RealmSwift

class ScheduleModel: Object {
    @Persisted var date: Date?
    @Persisted var time: Date?
    @Persisted var name: String = "Unknown"
    @Persisted var place: String = "Unknown"
    @Persisted var color: String = "4D54CB"
    @Persisted var isImportant: Bool = true
}
