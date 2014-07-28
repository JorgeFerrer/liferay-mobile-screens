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
import UIKit

class SignUpView: BaseWidgetView, UITextFieldDelegate {

	@IBOutlet var emailAddressField: UITextField?
	@IBOutlet var passwordField: UITextField?
	@IBOutlet var firstNameField: UITextField?
	@IBOutlet var lastNameField: UITextField?
	@IBOutlet var signUpButton: UIButton?


    // BaseWidgetView METHODS
    
    
    override func becomeFirstResponder() -> Bool {
        return emailAddressField!.becomeFirstResponder()
    }
    
    
    // UITextFieldDelegate METHODS
    
    
	func textFieldShouldReturn(textField: UITextField!) -> Bool {
		textField.resignFirstResponder()

		switch textField {
		case emailAddressField!:
			passwordField!.becomeFirstResponder()
		case passwordField!:
			firstNameField!.becomeFirstResponder()
		case firstNameField!:
			lastNameField!.becomeFirstResponder()
		case lastNameField!:
			signUpButton!.sendActionsForControlEvents(UIControlEvents.TouchUpInside)
		default:
			return false
		}

        return true
	}

}
