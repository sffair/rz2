//
//  Store.swift
//  rz2
//
//  Created by Fabrício Sperotto Sffair on 2017-07-12.
//  Copyright © 2017 Fabrício Sperotto Sffair. All rights reserved.
//
//  Modelo criado para armazenar e buscar dados do coredata
//

import Sync
import CoreData

class Store {
    private let dataStack : DataStack = DataStack(modelName: CoreDataSettings.ModelName)
    
    // MARK: - fetch
    //busca os dados do core data
    func fetch() -> [NSManagedObject]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Units")
        request.sortDescriptors = [NSSortDescriptor(key: "id", ascending: true)]
        do {
            let items = try dataStack.mainContext.fetch(request) as? [NSManagedObject]
            return items
        } catch {
            return nil
        }
    }
    
    // MARK: - save & sync
    // salva e sincroniza novos dados ao core data
    func save(Json: [[String : Any]], completionBlock: @escaping SuccessCompletionBlock) {
        self.dataStack.sync(Json, inEntityNamed: CoreDataSettings.Entity) {
            (error) in
            if error != nil {
                completionBlock(false, error)
            } else {
                completionBlock(true, nil)
            }
        }
    }

}
