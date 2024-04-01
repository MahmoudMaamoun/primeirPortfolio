//
//  DataController.swift
//  PrimerPortfolio
//
//  Created by Mahmoud Maamoun on 29/03/2024.
//

import CoreData

class DataController : ObservableObject {
    let container: NSPersistentCloudKitContainer
    
    static let perview:DataController = {
        let dataController = DataController(inMemory: false)
        dataController.createSampleData()
        return dataController
    }()
    

    init(inMemory:Bool = false) {
        // inMemory Boolean when creating our data controller. When this is set to true, we’ll create our data entirely in memory rather than on disk
        // it’s great for previewing in SwiftUI, but also helpful for writing tests.
        
        container = NSPersistentCloudKitContainer(name: "Main")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(filePath: "dev/null/")
        }
        
        container.loadPersistentStores { storeDesc, error in
            if let error {
                fatalError("fatal error Loading Store:\(error.localizedDescription)")
            }
        }
    }
    
    
    // This is only useful for testing and previewing, but it really does come in handy.
    func createSampleData()
    {
        let veiwContext = container.viewContext
        
        for i in 1...5 {
            let tag = Tags(context: veiwContext)
            tag.id = UUID()
            tag.name = "Tag number: \(i)"
            
            for j in 1...10 {
                let issue = Bugs(context: veiwContext)
                issue.content = "Description goes here"
                issue.title = "issue number #\(j)"
                issue.completed = Bool.random()
                issue.creationDate = .now
                issue.periority = Int16.random(in:0...2)
                tag.addToBugs(issue)
            }
        }
        
        try? veiwContext.save()
    }
    
    func save() {
        if container.viewContext.hasChanges {
           try? container.viewContext.save()
        }
    }
    
    func delete(_ object:NSManagedObject) {
        objectWillChange.send()
        container.viewContext.delete(object)
        save()
    }
}
