//
//  ContactModel.swift
//  MySchedule
//
//  Created by Radik Gazetdinov on 06.08.2022.
//

import RealmSwift

class ContactModel: Object {
    @Persisted var name: String = "Unknown"
    @Persisted var phone: String = "Unknown"
    @Persisted var avatar: Data?
}
