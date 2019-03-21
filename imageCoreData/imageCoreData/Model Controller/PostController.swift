//
//  PostController.swift
//  imageCoreData
//
//  Created by Nelson Gonzalez on 3/20/19.
//  Copyright © 2019 Nelson Gonzalez. All rights reserved.
//

import Foundation

import CoreData

class PostController {
    // MARK: Properties
    
    var post: [Post] {
        
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    
    func create(with idString: String, completion: @escaping(Error?) -> Void) {
        let _ = Post(idString: idString)
        
        saveToPersistentStore()
        completion(nil)
    }
    
    func delete(postImage: Post) {
        if let moc = postImage.managedObjectContext {
            moc.delete(postImage)
            saveToPersistentStore()
        }
    }
    
    func saveToPersistentStore() {
        let moc = CoreDataStack.context
        do {
            try moc.save()
        } catch let error {
            print("There was a problem saving to the persistent store: \(error)")
        }
    }
    
    func delete(post: Post) {
        if let moc = post.managedObjectContext {
            moc.delete(post)
            saveToPersistentStore()
        }
    }
    
    
}
