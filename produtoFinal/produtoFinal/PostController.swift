//
//  PostController.swift
//  produtoFinal
//
//  Created by Student on 12/16/15.
//  Copyright © 2015 Student. All rights reserved.
//

import UIKit
import CoreData

class PostController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var descricao: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    let contexto = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var imagePicker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let singleTap = UITapGestureRecognizer(target: self, action:"tapDetected:")
        singleTap.numberOfTapsRequired = 1
        
        imageView.addGestureRecognizer(singleTap)
        imageView.userInteractionEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func postar(sender: AnyObject) {
        save()
        navigationController?.popViewControllerAnimated(true)
    }
    
    func tapDetected(sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum){
            print("Button capture")
            
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
        
        imageView.image = image
        
    }
    
    
    func save(){
        let entityDescription = NSEntityDescription.entityForName("Post", inManagedObjectContext: contexto)
        let post = Post(entity: entityDescription!, insertIntoManagedObjectContext: contexto)
        
        
        post.descricao = descricao.text
        post.imagem = UIImageJPEGRepresentation(imageView.image!, 10)
        post.points = 0
        post.data = getCurrentDateAsNSDate()
        post.lingua = "portugues"
        
        do{
            try contexto.save()
        }catch let error as NSError{
            print (error)
        }
    }
    
    func getCurrentDateAsNSDate() -> NSDate {
        let currentDateTime = NSDate()
        let userCalendar = NSCalendar.currentCalendar()
        let requestedComponents: NSCalendarUnit = [
            NSCalendarUnit.Year,
            NSCalendarUnit.Month,
            NSCalendarUnit.Day,
            NSCalendarUnit.Hour,
            NSCalendarUnit.Minute,
            NSCalendarUnit.Second
        ]
        
        let dateTimeComponents = userCalendar.components(requestedComponents, fromDate: currentDateTime)
        let dateComponents = NSDateComponents()
        
        
        dateComponents.year = dateTimeComponents.year
        dateComponents.month = dateTimeComponents.month
        dateComponents.day = dateTimeComponents.day
        dateComponents.hour = dateTimeComponents.hour
        dateComponents.minute = dateTimeComponents.minute
        
        
        return NSCalendar.currentCalendar().dateFromComponents(dateComponents)!
        
    }
}
