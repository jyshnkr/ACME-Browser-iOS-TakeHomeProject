//
//  BookmarksController.swift
//  ACMEMobileBrowseriOS
//
//  Created by JayaShankar Mangina on 4/15/22.
//

import Foundation
import UIKit

class BookmarksController {
    
    // MARK: 1 - Instances/Properties
    var bookmarks: [Bookmark] = []
    
    var tabPages: [Bookmark] = []
    
    var bookmarksURL: URL? {
        let fileManager = FileManager.default
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let bookmarkItemsURL = directory.appendingPathComponent("bookmarks.plist")
        return bookmarkItemsURL
    }
    
    var tabPagesURL: URL? {
        let fileManager = FileManager.default
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        let tabPageItemsURL = directory.appendingPathComponent("tabs.plist")
        return tabPageItemsURL
    }
    
    // MARK: 2 - Initializer
    init(){
        loadBookmarksFromPersistence()
        loadTabPagesFromPersistence()
    }
    
    func loadBookmarksFromPersistence(){
        guard let fileURL = bookmarksURL else {return}
        
        do{
            let data = try Data(contentsOf: fileURL)
            let dataDecoder = PropertyListDecoder()
            let itemsArray = try dataDecoder.decode([Bookmark].self, from: data)
        } catch {
            print("Error Loading from pList: \(error)")
        }
    }
    
    func loadTabPagesFromPersistence() {
        guard let fileURL = tabPagesURL else {return}
        
        do{
            let data = try Data(contentsOf: fileURL)
            let dataDecoder = PropertyListDecoder()
            let itemsArray = try dataDecoder.decode([Bookmark].self, from: data)
        } catch {
            print("Error Loading from pList: \(error)")
        }
    }
    
    func saveBookmarksToPersistence(){
        guard let fileURL = bookmarksURL else {return}
        
        do{
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(bookmarks)
            try data.write(to: fileURL)
        } catch {
            print("Error saving items: \(error)")
        }
    }
    
    func saveTabPagesToPersistence(){
        guard let fileURL = tabPagesURL else {return}
        
        do{
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(tabPages)
            try data.write(to: fileURL)
        } catch {
            print("Error saving items: \(error)")
        }
    }
    
    //MARK: CRUD OPERATIONS
    
    func addBookmark(newBookmark: Bookmark){
        bookmarks.append(newBookmark)
        saveBookmarksToPersistence()
    }
    
    func deleteBookmark(row: Int){
        bookmarks.remove(at: row)
        saveBookmarksToPersistence()
    }
    
    func addTabPage(newTabPage: Bookmark){
        tabPages.append(newTabPage)
        saveTabPagesToPersistence()
    }
    
    func deleteTabPage(row: Int, bookmark: Bookmark){
        tabPages.remove(at: row)
        UIImage.deleteImage()
    }
    
}
