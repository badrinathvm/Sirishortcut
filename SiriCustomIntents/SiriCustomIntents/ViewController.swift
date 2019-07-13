//
//  ViewController.swift
//  SiriCustomIntents
//
//  Created by Badarinath Venkatnarayansetty on 6/27/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import UIKit
import IntentsUI

class ViewController: UIViewController {
    
    lazy var shortcutManager: VoiceShortcutManager? = { return nil }()
    
    let addToSiri: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Add To Siri", for: UIControl.State.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(navigateToSiriScreen), for: UIControl.Event.touchUpInside)
        return button
    }()

    @objc func navigateToSiriScreen() {
        //show Siri Shortcut Voew Controller
        let navigateIntent = NavigateIntent()
        navigateIntent.suggestedInvocationPhrase = "Navigate to Screen"
        guard let shortcut = INShortcut(intent: navigateIntent) else { return }
        
        let addSiriShortcutVC = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        addSiriShortcutVC.delegate = self
        self.present(addSiriShortcutVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        // Do any additional setup after loading the view.
        
        view.addSubview(addToSiri)
        
        //set constraints
        NSLayoutConstraint.activate([
                self.addToSiri.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                self.addToSiri.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
                self.addToSiri.widthAnchor.constraint(equalToConstant: 100),
                self.addToSiri.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        shortcutManager = VoiceShortcutManager()
        
        //Add a right tab bar button
        let nextButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(nextScreen(_ :)))
        self.navigationItem.rightBarButtonItem = nextButton
        
        
        //listen to notification
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.nextScreen(_:)),
            name: .navigate,
            object: nil)
    }
    
    @objc func nextScreen(_ sender: UIBarButtonItem) {
        let nextVC = NextViewController()
//        self.navigationController?.pushViewController(nextVC, animated: true)
        
        self.navigationController?.replaceCurrentViewController(with: nextVC, animated: true)
    }
}

extension ViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        guard error != nil else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        
         self.dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension Notification.Name {
    static let navigate = Notification.Name("navigate")
}

