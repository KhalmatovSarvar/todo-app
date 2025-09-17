//
//  KeyboardManager.swift
//  TODO app
//
//  Created by Sarvar on 17/09/25.
//


import UIKit

final class KeyboardManager {
    
    private let notificationCenter = NotificationCenter.default
    
    var keyboardWillShowObserver: ((CGFloat, TimeInterval) -> Void)?
    var keyboardWillHideObserver: (() -> Void)?
    
    init() {}
    
    func startObservingKeyboard() {
        notificationCenter.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func stopObservingKeyboard() {
        notificationCenter.removeObserver(self)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let timeInterval = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        keyboardWillShowObserver?(keyboardHeight, timeInterval)
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        keyboardWillHideObserver?()
    }
}