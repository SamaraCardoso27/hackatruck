//
//  TimelineController.swift
//  produtoFinal
//
//  Created by Student on 12/16/15.
//  Copyright © 2015 Student. All rights reserved.
//

import UIKit
import CoreData
import FBSDKCoreKit
import FBSDKLoginKit

class TimelineController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var fetchedResultController: NSFetchedResultsController = NSFetchedResultsController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        fetchedResultController = getFetchedResultController()
        fetchedResultController.delegate = self
        do{
            try fetchedResultController.performFetch()
        }catch let error as NSError{
            print(error)
        }
        
    }
    
    @IBAction func logout(sender: AnyObject) {
        let loginManager = FBSDKLoginManager()
        loginManager.logOut()
        
        let protectedPage = self.storyboard?.instantiateViewControllerWithIdentifier("LoginController") as! LoginController
        
        let protectedPageNav = UINavigationController(rootViewController: protectedPage)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = protectedPageNav
        
    }
    
    func getFetchedResultController() -> NSFetchedResultsController{
        fetchedResultController = NSFetchedResultsController(fetchRequest: nomeFetchRequest(), managedObjectContext: contexto, sectionNameKeyPath: nil, cacheName: nil)
        return fetchedResultController
    }
    
    func nomeFetchRequest() -> NSFetchRequest{
        let fetchRequest = NSFetchRequest(entityName: "Post")
        let sortDescriptor = NSSortDescriptor(key:"data", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        return fetchRequest
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //let numberOfSections = fetchedResultController.sections?.count
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRowsInSection = fetchedResultController.fetchedObjects?.count// .sections?[section].numberOfObjects
        return numberOfRowsInSection!
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> CellTimeline {
        let cell = tableView.dequeueReusableCellWithIdentifier("cellTimeline") as! CellTimeline
        
        //let post = fetchedResultController.objectAtIndexPath(indexPath) as! Post
        
        let posts = fetchedResultController.fetchedObjects as! [Post]
        
        //posts[indexPath.row].descricao
        
        cell.lblDescricao?.text = posts[indexPath.row].descricao
        cell.imgTimeline?.image = UIImage(data:posts[indexPath.row].imagem!)
        
        print("update tabelViewCell")
        
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let managedObject:NSManagedObject = fetchedResultController.objectAtIndexPath(indexPath) as! NSManagedObject
        
        contexto.deleteObject(managedObject)
        do{
            try contexto.save()
        }catch let error as NSError{
            print(error)
        }
    }*/
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
        print("update tabelView")
    }

}
