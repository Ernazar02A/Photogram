//
//  RealmService.swift
//  FinallyApp
//
//  Created by Ernazar on 8/9/23.
//

import RealmSwift

class RealmService {
    static let shared = RealmService()
    let realm = try! Realm()
    
    func saveData(photo: Photo) {
        let data = RealmPhoto()
        data.id = photo.id
        data.image = photo.urls["thumb"]!
        data.userName = photo.user.name
        try! self.realm.write {
            realm.add(data)
        }
        
    }
    
    
    func readData() -> Results<RealmPhoto> {
        realm.objects(RealmPhoto.self)
    }
    
    func deleteData(photo: Photo) {
        let data = RealmPhoto()
        data.id = photo.id
        data.image = photo.urls["thumb"]!
        data.userName = photo.user.name
        try! realm.write {
            realm.delete(realm.objects(RealmPhoto.self).filter("id=%@",data.id))
        }
    }
    
}
