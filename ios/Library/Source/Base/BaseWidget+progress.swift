/**
* Copyright (c) 2000-present Liferay, Inc. All rights reserved.
*
* This library is free software; you can redistribute it and/or modify it under
* the terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1 of the License, or (at your option)
* any later version.
*
* This library is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
* details.
*/
import Foundation

// WORKAROUND!
// This hack is because compiler error "Class variables not yet supported"
struct Lock {
	static var token = "token"
}

struct MBProgressHUDInstance {
	static var instance:MBProgressHUD? = nil
}

/*!
 * This extension to BaseWidget adds methods to display an "In Progress" HUD.
 */
extension BaseWidget {

    /*
     * showHUDWithMessage shows an animated Progress HUD with the message and details provided.
     */
	public func showHUDWithMessage(message:String?, details:String?) {
		synchronized(Lock.token) {
			if !MBProgressHUDInstance.instance {
				MBProgressHUDInstance.instance = MBProgressHUD.showHUDAddedTo(self.rootView(self), animated:true)
			}

			if message {
				MBProgressHUDInstance.instance!.labelText = message
			}

			MBProgressHUDInstance.instance!.detailsLabelText = details?

			MBProgressHUDInstance.instance!.show(true)
		}
	}

    /*
     * hideHUDWithMessage hides an existing animated Progress HUD displaying the message and details provided first for
     * a few seconds, calculated based on the length of the message.
     */
	public func hideHUDWithMessage(message:String, details:String?) {
		synchronized(Lock.token) {
			if let instance = MBProgressHUDInstance.instance {
				instance.mode = MBProgressHUDModeText
				instance.labelText = message
				instance.detailsLabelText = details ? details : ""

				let len: Int =
                    countElements(instance.labelText as String) + countElements(instance.detailsLabelText as String)
				let delay = 1.5 + (Double(len) * 0.01)

				instance.hide(true, afterDelay: delay)
			}
		}
	}

    // PRIVATE METHODS

    private func rootView(currentView:UIView) -> UIView {
        if !currentView.superview {
            return currentView;
        }
        
        return rootView(currentView.superview!)
    }
    
    private func synchronized(lock:AnyObject, closure: () -> ()) {
        objc_sync_enter(lock)
        closure()
        objc_sync_exit(lock)
    }
    
}