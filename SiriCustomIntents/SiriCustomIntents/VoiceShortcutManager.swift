//
//  VoiceShortcutManager.swift
//  SiriCustomIntents
//
//  Created by Badarinath Venkatnarayansetty on 6/27/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import Intents

class VoiceShortcutManager {
    
    lazy var voiceShortcuts: [INVoiceShortcut]? =  { return [] }()
    
    init() {
        updateShortcuts()
    }
    
    func updateShortcuts(_ completion: ( () -> Void )? = nil ) {
        INVoiceShortcutCenter.shared.getAllVoiceShortcuts { [weak self] (voiceShortcutsFromCenter, error) in
            guard let voiceShortcuts = voiceShortcutsFromCenter else {
                if let error = error as NSError? {
                    print(error)
                }
                return
            }
              self?.voiceShortcuts = voiceShortcuts
            completion?()
        }
    }
}
