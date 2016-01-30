//
//  LoginController.swift
//  produtoFinal
//
//  Created by Student on 12/16/15.
//  Copyright © 2015 Student. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if(FBSDKAccessToken.currentAccessToken() == nil){
            print("usuario deslogado")
        }else{
            print("usuario logado")
            iniTimeline()
        }
        
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!){
        if(error != nil)
        {
            print(error.localizedDescription)
            return
        }
        
        if let userToken = result.token
        {
            //Get user access token
            let token:FBSDKAccessToken = result.token
            print("Token = \(FBSDKAccessToken.currentAccessToken().tokenString)")
            
            print("User ID = \(FBSDKAccessToken.currentAccessToken().userID)")
            
            iniTimeline()
        }

    }
    

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!){
        print("Usuario deslogou.")
    }
    
    func iniTimeline(){
        let protectedPage = self.storyboard?.instantiateViewControllerWithIdentifier("TimelineController") as! TimelineController
        
        let protectedPageNav = UINavigationController(rootViewController: protectedPage)
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = protectedPageNav
    }
}
