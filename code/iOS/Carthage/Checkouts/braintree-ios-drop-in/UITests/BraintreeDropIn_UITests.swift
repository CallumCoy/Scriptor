/*
 IMPORTANT
 Hardware keyboard should be disabled on simulator for tests to run reliably.
 */

import XCTest

class BraintreeDropIn_TokenizationKey_CardForm_UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launch()
        sleep(1)
        self.waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }
    
    func testDropIn_dismissesWhenCancelled() {
        self.waitForElementToBeHittable(app.buttons["Cancel"])
        app.buttons["Cancel"].forceTapElement()
        XCTAssertTrue(app.buttons["Cancelled🎲"].exists);
    }
    
    func testDropIn_displaysPaymentOptions_applePay_card_payPal() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        sleep(1)
        XCTAssertTrue(app.staticTexts["Credit or Debit Card"].exists);
        XCTAssertTrue(app.staticTexts["PayPal"].exists);
        XCTAssertTrue(app.staticTexts["Apple Pay"].exists);
    }
    
    func testDropIn_cardInput_receivesNonce() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")
        
        self.waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()
        
        let securityCodeField = elementsQuery.textFields["CVV"]
        self.waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")
        
        let postalCodeField = elementsQuery.textFields["12345"]
        self.waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")
        
        app.buttons["Add Card"].forceTapElement()
        
        self.waitForElementToAppear(app.staticTexts["ending in 11"])
        
        XCTAssertTrue(app.staticTexts["ending in 11"].exists);
    }
    
    func testDropIn_cardInput_showsInvalidState_withInvalidCardNumber() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4141414141414141")
        
        self.waitForElementToAppear(elementsQuery.staticTexts["You must provide a valid Card Number."])
    }
    
    func testDropIn_cardInput_hidesInvalidCardNumberState_withDeletion() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4141414141414141")
        
        self.waitForElementToAppear(elementsQuery.staticTexts["You must provide a valid Card Number."])
        
        cardNumberTextField.typeText("\u{8}")
        
        XCTAssertFalse(elementsQuery.textFields["Invalid: Card Number"].exists);
    }
}

class BraintreeDropIn_securityCodeValidation_CardForm_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-ThreeDSecureDefault")
        // NOTE: This sandbox client token has CVV validation enabled.
        app.launchArguments.append("-Authorization:eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiI2ZGE5Y2VhMzVkNGNlMjkxNGI3YzBiOGRiN2M5OWU4MjVmYTQ5ZTY5OTNiYWM4YmE3MTQwYjdiZjI0ODc4NGQ0fGNyZWF0ZWRfYXQ9MjAxOC0wMy0xMlQyMTo0MzoxMS4wOTI1MzAxNDcrMDAwMCZjdXN0b21lcl9pZD01ODA3NDE3NzEmbWVyY2hhbnRfaWQ9aGg0Y3BjMzl6cTRyZ2pjZyZwdWJsaWNfa2V5PXEzanRzcTNkM3Aycmg1dnQiLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvaGg0Y3BjMzl6cTRyZ2pjZy9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMVXJsIjoiaHR0cHM6Ly9wYXltZW50cy5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tL2dyYXBocWwiLCJjaGFsbGVuZ2VzIjpbImN2diJdLCJlbnZpcm9ubWVudCI6InNhbmRib3giLCJjbGllbnRBcGlVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvaGg0Y3BjMzl6cTRyZ2pjZy9jbGllbnRfYXBpIiwiYXNzZXRzVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhdXRoVXJsIjoiaHR0cHM6Ly9hdXRoLnZlbm1vLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhbmFseXRpY3MiOnsidXJsIjoiaHR0cHM6Ly9jbGllbnQtYW5hbHl0aWNzLnNhbmRib3guYnJhaW50cmVlZ2F0ZXdheS5jb20vaGg0Y3BjMzl6cTRyZ2pjZyJ9LCJ0aHJlZURTZWN1cmVFbmFibGVkIjp0cnVlLCJwYXlwYWxFbmFibGVkIjp0cnVlLCJwYXlwYWwiOnsiZGlzcGxheU5hbWUiOiJidCIsImNsaWVudElkIjoiQVZRSmY5YS1iNmptWUZnaW9OcEkyaTU3cnNRa0hqUlpadjRkOURaTFRVMG5CU3Vma2h3QUNBWnhqMGxkdTg1amFzTTAyakZSUEthVElOQ04iLCJwcml2YWN5VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3BwIiwidXNlckFncmVlbWVudFVybCI6Imh0dHA6Ly9leGFtcGxlLmNvbS90b3MiLCJiYXNlVXJsIjoiaHR0cHM6Ly9hc3NldHMuYnJhaW50cmVlZ2F0ZXdheS5jb20iLCJhc3NldHNVcmwiOiJodHRwczovL2NoZWNrb3V0LnBheXBhbC5jb20iLCJkaXJlY3RCYXNlVXJsIjpudWxsLCJhbGxvd0h0dHAiOnRydWUsImVudmlyb25tZW50Tm9OZXR3b3JrIjpmYWxzZSwiZW52aXJvbm1lbnQiOiJvZmZsaW5lIiwidW52ZXR0ZWRNZXJjaGFudCI6ZmFsc2UsImJyYWludHJlZUNsaWVudElkIjoibWFzdGVyY2xpZW50MyIsImJpbGxpbmdBZ3JlZW1lbnRzRW5hYmxlZCI6dHJ1ZSwibWVyY2hhbnRBY2NvdW50SWQiOiJjNXljdzJzdnlrbnp3anR6IiwiY3VycmVuY3lJc29Db2RlIjoiVVNEIn0sIm1lcmNoYW50SWQiOiJoaDRjcGMzOXpxNHJnamNnIiwidmVubW8iOiJvZmYiLCJicmFpbnRyZWVfYXBpIjp7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbSIsImFjY2Vzc190b2tlbiI6InNhbmRib3hfNmRkdG13X3B6YjZ3cF93ZHdoY3lfOWhnNm5iX2N5NiJ9fQ==")
        app.launch()
        sleep(1)
        self.waitForElementToBeHittable(app.buttons["Change Payment Method"])
        app.buttons["Change Payment Method"].tap()
    }

    func testDropIn_invalidSecurityCode_presentsAlert() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]

        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4000000000000002")

        self.waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()

        let securityCodeField = elementsQuery.textFields["CVV"]
        self.waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("200")

        app.buttons["Add Card"].forceTapElement()

        self.waitForElementToBeHittable(app.alerts.buttons["OK"])
        XCTAssertTrue(app.alerts.staticTexts["Please review your information and try again."].exists);
        app.alerts.buttons["OK"].tap()

        // Assert: can edit after dismissing alert
        self.waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("\u{8}1")
    }
}

class BraintreeDropIn_CardDisabled_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-CardDisabled")
        app.launch()
        sleep(1)
        self.waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }

    func testDropIn_cardDisabledOption_disablesCreditCard() {
        XCTAssertTrue(app.staticTexts["PayPal"].exists);
        XCTAssertFalse(app.staticTexts["Credit or Debit Card"].exists);
    }
}

class BraintreeDropIn_CardForm_RequestOptions_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launchArguments.append("-MaskSecurityCode")
        app.launch()
        sleep(1)
        self.waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }

    func testDropIn_maskSecurityCodeOption_enablesSecureTextEntry() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()

        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]

        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")

        let securityCodeField = elementsQuery.secureTextFields["CVV"]
        self.waitForElementToBeHittable(securityCodeField)

        XCTAssertFalse(elementsQuery.textFields["CVV"].exists)
    }
}

class BraintreeDropIn_CardholderNameNotAvailable_UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launch()
        sleep(1)
        self.waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }
    
    func testDropIn_cardholderNameNotAvailable_fieldDoesntExist() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")
        
        self.waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        
        let cardholderNameField = elementsQuery.textFields["Cardholder Name"]
        XCTAssertFalse(cardholderNameField.exists)
    }
}

class BraintreeDropIn_CardholderNameAvailable_UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launchArguments.append("-CardholderNameAccepted")
        app.launch()
        sleep(1)
        
        self.waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
        
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
    }
    
    func testDropIn_cardholderNameAvailable_fieldExists() {
        let elementsQuery = app.scrollViews.otherElements

        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")
        
        let cardholderNameField = elementsQuery.textFields["Cardholder Name"]
        self.waitForElementToAppear(cardholderNameField)
        XCTAssertTrue(cardholderNameField.exists)
    }
    
    func testDropIn_cardholderNameAvailable_canAddCardWithoutName() {
        let elementsQuery = app.scrollViews.otherElements

        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")
        
        let cardholderNameTextField = elementsQuery.textFields["Cardholder Name"]
        cardholderNameTextField.typeText("\n")
        
        self.waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()
        
        let securityCodeField = elementsQuery.textFields["CVV"]
        self.waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")
        
        let postalCodeField = elementsQuery.textFields["12345"]
        self.waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")
        
        app.buttons["Add Card"].forceTapElement()
        
        self.waitForElementToAppear(app.staticTexts["ending in 11"])
        
        XCTAssertTrue(app.staticTexts["ending in 11"].exists);
        
    }
}

class BraintreeDropIn_CardholderNameRequired_UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launchArguments.append("-CardholderNameRequired")
        app.launch()
        sleep(1)

        self.waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()

        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
    }
    
    func testDropIn_cardholderNameRequired_fieldExists() {
        let elementsQuery = app.scrollViews.otherElements

        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")

        let cardholderNameField = elementsQuery.textFields["Cardholder Name"]
        self.waitForElementToAppear(cardholderNameField)

        XCTAssertTrue(cardholderNameField.exists)
    }
    
    func testDropIn_cardholderNameRequired_cannotAddCardWithoutName() {
        let elementsQuery = app.scrollViews.otherElements

        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")

        let cardholderNameTextField = elementsQuery.textFields["Cardholder Name"]
        cardholderNameTextField.typeText("\n")

        self.waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()

        let securityCodeField = elementsQuery.textFields["CVV"]
        self.waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")

        let postalCodeField = elementsQuery.textFields["12345"]
        self.waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")

        XCTAssertFalse(app.buttons["Add Card"].isEnabled)
    }
    
    func testDropIn_cardholderNameRequired_canAddCardWithName() {
        let elementsQuery = app.scrollViews.otherElements

        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")

        let cardholderNameField = elementsQuery.textFields["Cardholder Name"]
        self.waitForElementToBeHittable(cardholderNameField)
        cardholderNameField.typeText("First Last\n")

        self.waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()

        let securityCodeField = elementsQuery.textFields["CVV"]
        self.waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")

        let postalCodeField = elementsQuery.textFields["12345"]
        self.waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")

        app.buttons["Add Card"].forceTapElement()

        self.waitForElementToAppear(app.staticTexts["ending in 11"])

        XCTAssertTrue(app.staticTexts["ending in 11"].exists);
    }
}

class BraintreeDropIn_ClientToken_CardForm_UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-ClientToken")
        app.launchArguments.append("-ThreeDSecureDefault")
        app.launch()
        sleep(1)
        self.waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }
    
    func testDropIn_cardInput_receivesNonce() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")
        self.waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()
        
        let securityCodeField = app.scrollViews.otherElements.textFields["CVV"]
        self.waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")
        
        let postalCodeField = app.scrollViews.otherElements.textFields["12345"]
        self.waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")
        
        app.buttons["Add Card"].forceTapElement()
        
        self.waitForElementToAppear(app.staticTexts["ending in 11"])
        
        XCTAssertTrue(app.staticTexts["ending in 11"].exists);
    }
    
    func testDropIn_nonUnionPayCardNumber_showsNextButton() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        XCTAssertTrue(app.buttons["Next"].exists)
    }
    
    func testDropIn_hidesValidateButtonAfterCardNumberEntered() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")
        
        XCTAssertFalse(app.buttons["Next"].exists)
    }
    
    func pendDropIn_showsSpinnerDuringUnionPayCapabilitiesFetch() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("6212345678901232")
        
        self.waitForElementToBeHittable(app.buttons["Next"])
        app.buttons["Next"].forceTapElement()
        XCTAssertTrue(app.activityIndicators.count == 1 && app.activityIndicators["In progress"].exists)
    }
    
    func pendDropIn_unionPayCardNumber_receivesNonce() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("6212345678901232")
        
        self.waitForElementToBeHittable(app.buttons["Next"])
        app.buttons["Next"].forceTapElement()
        
        let expiryTextField = elementsQuery.textFields["MM/YYYY"]
        self.waitForElementToBeHittable(expiryTextField)
        
        self.waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()
        
        elementsQuery.textFields["Security Code"].typeText("565")
        app.typeText("65")
        
        app.staticTexts["Mobile Number"].forceTapElement()
        app.typeText("1235566543")
        
        app.buttons["Add Card"].forceTapElement()
        
        self.waitForElementToBeHittable(app.alerts.buttons["OK"])
        app.alerts.buttons["OK"].tap()
        
        self.waitForElementToBeHittable(app.textFields["SMS Code"])
        app.textFields["SMS Code"].forceTapElement()
        app.typeText("12345")
        
        self.waitForElementToBeHittable(app.buttons["Confirm"])
        app.buttons["Confirm"].forceTapElement()
        
        self.waitForElementToAppear(app.staticTexts["ending in 32"])
        
        XCTAssertTrue(app.staticTexts["ending in 32"].exists);
    }
    
    func testDropIn_cardInput_doesNotShowCardIOButton_inSimulator() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")
        XCTAssertFalse(app.staticTexts["Scan with card.io"].exists);
    }
}


class BraintreeDropIn_PayPal_UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launch()
        sleep(1)
        self.waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }
    
    func testDropIn_paypal_showsPayPal() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        XCTAssertTrue(app.staticTexts["PayPal"].exists);
    }
    
    func testDropIn_paypal_receivesNonce() {
        if #available(iOS 11.0, *) {
            // SFSafariAuthenticationSession flow cannot be fully automated, so returning early
            return
        }
        
        self.waitForElementToBeHittable(app.staticTexts["PayPal"])
        app.staticTexts["PayPal"].tap()
        sleep(3)
        
        let webviewElementsQuery = app.webViews.element.otherElements
        
        self.waitForElementToBeHittable(webviewElementsQuery.links["Proceed with Sandbox Purchase"])
        
        webviewElementsQuery.links["Proceed with Sandbox Purchase"].forceTapElement()
        
        self.waitForElementToAppear(app.staticTexts["bt_buyer_us@paypal.com"])
        
        XCTAssertTrue(app.staticTexts["bt_buyer_us@paypal.com"].exists)
    }

    func testDropIn_paypal_cancelPopupShowsSelectPaymentMethodView() {
        if #available(iOS 11.0, *) {
            return
        }

        self.waitForElementToBeHittable(app.staticTexts["PayPal"])
        app.staticTexts["PayPal"].tap()
        sleep(3)

        let webviewElementsQuery = app.webViews.element.otherElements

        self.waitForElementToBeHittable(webviewElementsQuery.links["Cancel Sandbox Purchase"])

        webviewElementsQuery.links["Cancel Sandbox Purchase"].forceTapElement()

        self.waitForElementToAppear(app.staticTexts["Select Payment Method"])

        XCTAssertTrue(app.staticTexts["Select Payment Method"].exists)
    }
}

class BraintreeDropIn_PayPal_OneTime_UITests: XCTestCase {

    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-PayPalOneTime")
        app.launchArguments.append("-TokenizationKey")
        app.launch()
        sleep(1)
        self.waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }

    func testDropIn_paypal_showAmount_receivesNonce() {
        if #available(iOS 11.0, *) {
            // SFSafariAuthenticationSession flow cannot be fully automated, so returning early
            return
        }

        self.waitForElementToBeHittable(app.staticTexts["PayPal"])
        app.staticTexts["PayPal"].tap()
        sleep(3)

        let webviewElementsQuery = app.webViews.element.otherElements

        self.waitForElementToAppear(webviewElementsQuery.staticTexts["4.77"])

        self.waitForElementToBeHittable(webviewElementsQuery.links["Proceed with Sandbox Purchase"])

        webviewElementsQuery.links["Proceed with Sandbox Purchase"].forceTapElement()

        self.waitForElementToAppear(app.staticTexts["bt_buyer_us@paypal.com"])

        XCTAssertTrue(app.staticTexts["bt_buyer_us@paypal.com"].exists)
    }
}

class BraintreeDropIn_PayPal_Disabled_UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-DisablePayPal")
        app.launch()
        sleep(1)
        self.waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }
    
    func testDropIn_paypal_doesNotShowPayPal_whenDisabled() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        XCTAssertFalse(app.staticTexts["PayPal"].exists);
    }
}

class BraintreeDropIn_ThreeDSecure_UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-ClientToken")
        app.launchArguments.append("-ThreeDSecureRequired")
        app.launch()
        sleep(1)
        self.waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }
    
    func testDropIn_threeDSecure_showsThreeDSecureWebview_andTransacts() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")
        
        self.waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()
        
        let securityCodeField = elementsQuery.textFields["CVV"]
        self.waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")
        
        let postalCodeField = elementsQuery.textFields["12345"]
        self.waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")
        
        app.buttons["Add Card"].forceTapElement()
        
        self.waitForElementToAppear(app.staticTexts["Added Protection"])
        
        let textField = app.secureTextFields.element(boundBy: 0)
        self.waitForElementToBeHittable(textField)
        textField.forceTapElement()
        sleep(2)
        textField.typeText("1234")
        
        app.buttons["Submit"].forceTapElement()
        
        self.waitForElementToAppear(app.staticTexts["ending in 11"])
        
        XCTAssertTrue(app.staticTexts["ending in 11"].exists);
        
        self.waitForElementToBeHittable(app.buttons["Complete Purchase"])
        app.buttons["Complete Purchase"].forceTapElement()
        
        let existsPredicate = NSPredicate(format: "label LIKE 'created*'")
        
        self.waitForElementToAppear(app.buttons.containing(existsPredicate).element(boundBy: 0))
    }
    
    func testDropIn_threeDSecure_returnsToPaymentSelectionView_whenCancelled() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4111111111111111")
        
        self.waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["11"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()
        
        let securityCodeField = elementsQuery.textFields["CVV"]
        self.waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("123")
        
        let postalCodeField = elementsQuery.textFields["12345"]
        self.waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")
        
        app.buttons["Add Card"].forceTapElement()
        
        self.waitForElementToAppear(app.staticTexts["Added Protection"])
        
        app.buttons["Done"].forceTapElement()
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        self.waitForElementToAppear(app.staticTexts["Select Payment Method"])
        
        self.waitForElementToBeHittable(app.buttons["Cancel"])
        app.buttons["Cancel"].forceTapElement()
        
        self.waitForElementToAppear(app.buttons["Cancelled🎲"])
        XCTAssertTrue(app.buttons["Cancelled🎲"].exists);
    }
    
    func testDropIn_threeDSecure_tokenizationError_showsAlert() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        app.staticTexts["Credit or Debit Card"].tap()
        
        let elementsQuery = app.scrollViews.otherElements
        let cardNumberTextField = elementsQuery.textFields["Card Number"]
        
        self.waitForElementToBeHittable(cardNumberTextField)
        cardNumberTextField.typeText("4687380000000008")
        
        self.waitForElementToBeHittable(app.staticTexts[Date.getNextYear()])
        app.staticTexts["01"].forceTapElement()
        app.staticTexts[Date.getNextYear()].forceTapElement()
        
        let securityCodeField = elementsQuery.textFields["CVV"]
        self.waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("200")
        
        let postalCodeField = elementsQuery.textFields["12345"]
        self.waitForElementToBeHittable(postalCodeField)
        postalCodeField.forceTapElement()
        postalCodeField.typeText("12345")
        
        app.buttons["Add Card"].forceTapElement()
        
        self.waitForElementToBeHittable(app.alerts.buttons["OK"])
        XCTAssertTrue(app.alerts.staticTexts["Please review your information and try again."].exists);
        app.alerts.buttons["OK"].tap()
        
        // Assert: can edit after dismissing alert
        self.waitForElementToBeHittable(securityCodeField)
        securityCodeField.forceTapElement()
        securityCodeField.typeText("\u{8}1")
    }
}


class BraintreeDropIn_Venmo_Disabled_UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-ForceVenmo")
        app.launchArguments.append("-DisableVenmo")
        app.launch()
        sleep(1)
        self.waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }
    
    func testDropIn_venmo_doesNotShow_whenDisabled() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        XCTAssertFalse(app.staticTexts["Venmo"].exists);
    }
}

class BraintreeDropIn_Venmo_UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-ForceVenmo")
        app.launch()
        sleep(1)
        self.waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }
    
    func testDropIn_venmo_doesShow() {
        self.waitForElementToBeHittable(app.staticTexts["Credit or Debit Card"])
        XCTAssertTrue(app.staticTexts["Venmo"].exists);
    }
}

class BraintreeDropIn_Error_UITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("-EnvironmentSandbox")
        app.launchArguments.append("-TokenizationKey")
        app.launchArguments.append("-BadUrlScheme")
        app.launch()
        sleep(1)
        self.waitForElementToBeHittable(app.buttons["Add Payment Method"])
        app.buttons["Add Payment Method"].tap()
    }
    
    func testDropIn_paypal_receivesError_whenUrlSchemeIsIncorrect() {
        self.waitForElementToBeHittable(app.staticTexts["PayPal"])
        app.staticTexts["PayPal"].tap()
        sleep(3)
        
        let existsPredicate = NSPredicate(format: "label LIKE '*Application does not support One Touch callback*'")
        
        self.waitForElementToAppear(app.buttons.containing(existsPredicate).element(boundBy: 0))
    }
}
