//
//  PassKitButtonViewController.swift
//  ApplePay-InApp-Provisioning
//
//  Created by Will Xavier on 10/02/23.
//

import Foundation

import UIKit
import PassKit

class PassKitButtonViewController: UIViewController {

//    private let inAppPassKitRepository: InAppPassKitRepository = InAppPassKitRepositoryImpl(pkPassLibrary: PKPassLibrary())
    private let inAppPassKitRepository: InAppPassKitRepository
    
    let walletConfiguration: AppleWalletConfiguration
    
    init(_ inAppPassKitRepository: InAppPassKitRepository, walletConfiguration: AppleWalletConfiguration) {
        self.walletConfiguration = walletConfiguration
        self.inAppPassKitRepository = inAppPassKitRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    /**
     This `initializer` is called when the UI is instanced on `StoryBoard`.
     There's no need to implement it for real.
     - Note: Do not use this `ViewController` on `Storyboards` or `Xibs`.
     To fix the usage of this `ViewController` in a `StoryBoard` implements the `Codable` protocol to the `Card` Structure
     */
    required init?(coder aDecoder: NSCoder) {
        if let walletConfiguration = aDecoder.decodeObject() as? AppleWalletConfiguration {
            self.walletConfiguration = walletConfiguration
            self.inAppPassKitRepository = DependencyInjector.shared.resolve()
        } else {
            return nil
        }
        super.init(coder: aDecoder)
    }
    
    /**
     This `encoder` is called when the UI is instanced on `StoryBoard`.
     There's no need to implement it for real.
     - Note: Do not use this `ViewController` on `Storyboards` or `Xibs`.
     To fix the usage of this `ViewController` in a `StoryBoard` implements the `Codable` protocol to the `Card` Structure
     */
    override func encode(with aCoder: NSCoder) {
        aCoder.encode(self.walletConfiguration)
        super.encode(with: aCoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupApplePayButton()
    }
    
    
    /**
     Create the `AddToWallet` button here we can customize the button to fit the designer layout.
     */
    private func setupApplePayButton() {
        @UsesAutoLayout var passKitButton = PKAddPassButton(addPassButtonStyle: .black)
        passKitButton.addTarget(self, action: #selector(self.onPress), for: .touchUpInside)
        view.addSubview(passKitButton)
    }
    
    
    /**
     The method to initialize the `Apple Wallet` flow.
     Verify again if the `PassKit` is available before call the Wallet app to enroll the new card.
     */
    @objc private func onPress(button: UIButton) {
        guard self.inAppPassKitRepository.isPassKitAvailable() else {
            self.showPassKitUnavailable(errorType: .notAvailable)
            return
        }
        self.initEnrollProcess()
    }
    
    /**
    Init enrollment process with the `Card` data from the main app.
    */
   private func initEnrollProcess() {
       /// Verify if is possible to create the `ViewModel`  to call the Wallet App or show the user the Enroll process cannot be continue.
       guard let configuration = PKAddPaymentPassRequestConfiguration(encryptionScheme: .ECC_V2) else {
           self.showPassKitUnavailable(errorType: .viewModelConfiguratonError)
           return
       }
       let card = self.walletConfiguration.card
       configuration.cardholderName = card.holderName
       configuration.primaryAccountIdentifier = card.primaryAccountIdentifier
       configuration.primaryAccountSuffix = card.panTokenSuffix
       configuration.localizedDescription = self.walletConfiguration.description
       
       /// Create the `ViewController` to call the Wallet App.
       guard let passKitAddPaymentPassViewController = PKAddPaymentPassViewController(requestConfiguration: configuration, delegate: self) else {
           showPassKitUnavailable(errorType: .viewControllerConfigurationError)
           return
       }
           /// Call the Wallet App, with the `ViewModel` to complete the Enroll process.
           present(passKitAddPaymentPassViewController, animated: true, completion: nil)
       }
              
   
}


/**
All ErrorType to be handled in the Flutter size
 */
enum EnrollmentTypeError {
    case notAvailable
    case viewModelConfiguratonError
    case viewControllerConfigurationError
}

extension PassKitButtonViewController {
    /**
     Throws an error to Flutter method channel
    */
    private func showPassKitUnavailable(errorType: EnrollmentTypeError) {
        print("Send to the Flutter App that something went wrong: \(errorType)")
        // TODO: Thow an exception to Flutter Method Channel handle the unavailable PassKit
       
   }
}

extension PassKitButtonViewController: PKAddPaymentPassViewControllerDelegate {
    
    func addPaymentPassViewController(
        _ controller: PKAddPaymentPassViewController,
        generateRequestWithCertificateChain certificates: [Data],
        nonce: Data, nonceSignature: Data,
        completionHandler handler: @escaping (PKAddPaymentPassRequest) -> Void) {
            /// Perform the bridge from Apple -> Issuer -> Apple
            ///  - Note: The app itself could do the requests to the `IssuerHost` (back-end) or run a `callback` from Flutter with the logic and requests.
        
    }
    
    
    func addPaymentPassViewController(
        _ controller: PKAddPaymentPassViewController,
        didFinishAdding pass: PKPaymentPass?,
        error: Error?) {
        /// This method will be called when enroll process ends (with success / error)
        // 4
                if let _ = pass {
                    print("Send to Flutter App the success")
                } else {
                    print("Send to the Flutter App that something went wrong")
                }
    }
}

