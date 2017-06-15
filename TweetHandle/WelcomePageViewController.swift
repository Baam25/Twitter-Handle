//
//  ViewController.swift
//  TweetHandle
//
//  Created by Harish Gonnabhaktula on 13/06/17.
//  Copyright © 2017 Harish Gonnabattula. All rights reserved.
//

import UIKit
import TwitterKit
import SwiftyJSON
import RevealingSplashView

class WelcomePageViewController: UIViewController {

    let defaults = UserDefaults.standard
    let revealingSplashView = RevealingSplashView(iconImage: UIImage(named: "twitter")!,iconInitialSize: CGSize(width: 60, height: 60), backgroundColor: UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1.0))
    let accountStore = ACAccountStore()
    var accountType: ACAccountType?
    
    @IBOutlet weak var logoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        
        accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        if let accounts = accountStore.accounts(with: accountType) {
            if accounts.count == 0 {
                redirectToSettings()
            }
        }
        else{
            redirectToSettings()
        }
        setUpTwitterUI()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func isAlreadyAuthenticated() -> Bool {

        guard let session = Twitter.sharedInstance().sessionStore.existingUserSessions().last as? TWTRSession else{
            return false
        }
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: session)
        self.defaults.set(encodedData, forKey: "log_in_session")
        return true
    }
    
    func redirectToSettings(){
        let alert = UIAlertController(title: "Warning", message: "Please setup your Twitter Account", preferredStyle: .alert)
        let action = UIAlertAction(title: "SetUp", style: .default) { (action) in
            UIApplication.shared.open(URL(string:"App-prefs:root=TWITTER")!)
        }
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

}


extension WelcomePageViewController{
    
    func setUpTwitterUI(){
        twitterLogin()
        logoImageView.elevateShawdow()
    }
    func twitterLogin(){
        
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            guard let session = session else{
                print("error: \(error!.localizedDescription)")
                
                return
            }
            
            print("signed in as \(session.userID)")
            let encodedData = NSKeyedArchiver.archivedData(withRootObject: session)
            self.defaults.set(encodedData, forKey: "log_in_session")
            
            self.splashAnimation()
            
            
        })
        isAlreadyAuthenticated() ? removeTwitterButton(loginButton: logInButton) : addTwitterButton(loginButton: logInButton)
        
    }
    
    func addTwitterButton(loginButton:TWTRLogInButton){
        self.view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        let constraint1 = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: -30)
        let constraint2 = NSLayoutConstraint(item: loginButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self.view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        self.view.addConstraints([constraint1,constraint2])
        
        
    }
    
    func removeTwitterButton(loginButton:TWTRLogInButton){
        loginButton.removeFromSuperview()
        splashAnimation()
    }
    
    func splashAnimation() {
        
        
        revealingSplashView.useCustomIconColor = false
        revealingSplashView.animationType = .heartBeat
        
        //Adds the revealing splash view as a sub view
        self.view.addSubview(revealingSplashView)
        
        //Starts animation
        revealingSplashView.startAnimation()
        loadData()
    }
    
    func loadData(){
        APIManager.loadData { (error) in
            if (error != nil) {
                print(error!.localizedDescription) //handle error
            }
            else{
                DispatchQueue.global(qos: DispatchQoS.QoSClass.userInitiated).asyncAfter(deadline: .now() + 2.0, execute: { 
                    self.revealingSplashView.finishHeartBeatAnimation()
                    self.navigateTo(segueIdentifier: "ToTweetHandleSearch")
                })
                
            }
        }
    }
    
    func navigateTo(segueIdentifier:String){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: segueIdentifier, sender: nil)
        }
    }

}
