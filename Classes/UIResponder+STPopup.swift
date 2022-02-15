//
//  UIResponder+MTPopup.swift
//  MTPopup
//
//  Created by 伯驹 黄 on 2016/11/4.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

let MTPopupFirstResponderDidChange = Notification.Name(rawValue: "MTPopupFirstResponderDidChange")

extension UIResponder {

    @objc func mt_becomeFirstResponder() -> Bool {
        let accepted = mt_becomeFirstResponder()
        if accepted {
            NotificationCenter.default.post(name: MTPopupFirstResponderDidChange, object: self)
        }
        return accepted
    }
}

extension DispatchQueue {

    private static var _onceTracker = [String]()

    public class func once(token: String, block: () -> Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }

        if _onceTracker.contains(token) {
            return
        }

        _onceTracker.append(token)
        block()
    }
}
