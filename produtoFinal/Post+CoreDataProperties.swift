//
//  Post+CoreDataProperties.swift
//  produtoFinal
//
//  Created by Student on 12/16/15.
//  Copyright © 2015 Student. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Post {

    @NSManaged var data: NSDate?
    @NSManaged var descricao: String?
    @NSManaged var imagem: NSData?
    @NSManaged var points: NSNumber?
    @NSManaged var lingua: String?

}
