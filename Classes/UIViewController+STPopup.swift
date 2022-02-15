//
//  UIViewController+MTPopup.swift
//  MTPopup
//
//  Created by 伯驹 黄 on 2016/11/4.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

extension UIViewController {
    private struct AssociatedKeys {
        static var landscapeContentSizeInPopupKey: String? = "landscapeContentSizeInPopup"
        static var contentSizeInPopupKey: String? = "contentSizeInPopup"
        static var popupControllerKey: String? = "popupController"
    }

    func mt_viewDidLoad() {
        var contentSize = CGSize.zero
        switch UIApplication.shared.statusBarOrientation {
        case .landscapeLeft, .landscapeRight:
            contentSize = landscapeContentSizeInPopup
            if contentSize == .zero {
                contentSize = contentSizeInPopup
            }
        default:
            contentSize = contentSizeInPopup
        }

        if contentSize != .zero {
            view.frame = CGRect(origin: .zero, size: contentSize)
        }
    }

    func mt_presentViewController(_ viewControllerToPresent: UIViewController, animated: Bool, completion: (() -> Void)?) {
        guard let popupController = popupController else {
            mt_presentViewController(viewControllerToPresent, animated: animated, completion: completion)
            return
        }

        let controller = popupController.containerViewController!
  
        controller.present(viewControllerToPresent, animated: animated, completion: completion)
    }

    func mt_dismissViewControllerAnimated(_ animated: Bool, completion: (() -> Void)?) {
        guard let popupController = popupController else {
            mt_dismissViewControllerAnimated(animated, completion: completion)
            return
        }

        popupController.dismiss(with: completion)
    }

    var mt_presentedViewController: UIViewController? {
        guard let popupController = popupController else { return self.mt_presentedViewController }

        let controller = popupController.containerViewController!
        return controller.presentedViewController
    }

    var mt_presentingViewController: UIViewController? {
        guard let popupController = popupController else { return self.mt_presentingViewController }
        let controller = popupController.containerViewController!
        return controller.presentingViewController
    }

    static let screenW = UIScreen.main.bounds.width
    static let screenH = UIScreen.main.bounds.height

    public var contentSizeInPopup: CGSize {
        set {
            var value = newValue
            if value != .zero && value.width == 0 {
                switch UIApplication.shared.statusBarOrientation {
                case .landscapeLeft, .landscapeRight:
                    value.width = UIViewController.screenH
                default:
                    value.width = UIViewController.screenW
                }
            }

            objc_setAssociatedObject(self, &AssociatedKeys.contentSizeInPopupKey, NSValue(cgSize: value), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.contentSizeInPopupKey) as? CGSize) ?? .zero
        }
    }

    public var landscapeContentSizeInPopup: CGSize {
        set {
            var value = newValue
            if value != .zero && value.width == 0 {
                switch UIApplication.shared.statusBarOrientation {
                case .landscapeLeft, .landscapeRight:
                    value.width = UIViewController.screenW
                default:
                    value.width = UIViewController.screenH
                }
            }
            objc_setAssociatedObject(self, &AssociatedKeys.landscapeContentSizeInPopupKey, NSValue(cgSize: value), .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }

        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.landscapeContentSizeInPopupKey) as? CGSize) ?? .zero
        }
    }

    public var popupController: MTPopupController? {
        set {
            guard let newValue = newValue else { return }
            objc_setAssociatedObject(self, &AssociatedKeys.popupControllerKey, newValue, .OBJC_ASSOCIATION_ASSIGN)
        }

        get {
            let popupController = objc_getAssociatedObject(self, &AssociatedKeys.popupControllerKey) as? MTPopupController
            guard let controller = popupController else {
                return parent?.popupController
            }
            return controller
        }
    }
}
