//
//  ViewController.swift
//  CoverItExample
//
//  Created by minox8x11 on 5/4/15.
//

import UIKit
import ContactsUI

class ViewController: UIViewController {

    let contactStore = CNContactStore()
    let contact = CNMutableContact()
    let settingName = UserDefaults.standard.string(forKey: "name_preference") ?? ""
    
    @IBOutlet weak var needPermissionView: UIView!
    @IBOutlet weak var needSettingsView: UIView!

    @IBAction func tappedSettings() {
        print("Settings button pressed")
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)}
      
    override func viewWillAppear(_ animated: Bool) {
        checkContactsAuthorizationStatus()
        checkSettingsConfigured()
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("view did load")
            // If settings are changed...
            NotificationCenter.default.addObserver(forName: UserDefaults.didChangeNotification, object: nil, queue: OperationQueue.main) { notification in
                // ...Do something
                print("didChangeNotification")
                self.checkSettingsConfigured()
            } // [END] If settings are changed.
        } // [END] super.viewDidLoad()
        
        func checkSettingsConfigured() {
            let name = UserDefaults.standard.string(forKey: "name_preference")
            
            // If blank setting, show App Settings screen
            switch (name) {

            case "":
                // This happens on first-run
                print("Missing Settings")
                needSettingsView.fadeIn()

            default:
                needSettingsView.fadeOut()
                return
            }
        }

    
        func checkContactsAuthorizationStatus() {
        let contactStatus = CNContactStore.authorizationStatus(for: CNEntityType.contacts)
        
        switch (contactStatus) {
        case CNAuthorizationStatus.notDetermined:
            // This happens on first-run
            requestAccessToContacts()
        case CNAuthorizationStatus.authorized:
            // Things are in line with being able to show the calendars in the table view
            return // do something when requesting access
        case CNAuthorizationStatus.restricted, CNAuthorizationStatus.denied:
            // We need to help them give us permission
            needPermissionView.fadeIn()
//        case .limited:
//            // We need to help them give us permission
            needPermissionView.fadeIn()
        @unknown default:
            return
        }
    }

    func requestAccessToContacts() {
        contactStore.requestAccess(for: CNEntityType.contacts, completionHandler: { (accessGranted, accessError) -> Void in
            if accessGranted == true {
                DispatchQueue.main.async(execute: {
                    return // do something when requesting access
                })
            } else {
                DispatchQueue.main.async(execute: {
                    self.needPermissionView.fadeIn()
                })
            }
        })
    }

}

