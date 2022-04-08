//
//  QuoteViewController.swift
//  Motiv Quotes
//
//  Created by Adithyah Nair on 06/04/22.
//

import UIKit
import Foundation
import ChameleonFramework
import StoreKit


class QuoteViewController: UITableViewController, SKPaymentTransactionObserver {
    
    let quoteType = Quotes()
    
    let productID = "com.adithyahnair.Motiv-Quotes.PremiumQuotes"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isPurchased() {
            showPremiumQuotes()
        }
        
        SKPaymentQueue.default().add(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let backgroundColor = UIColor(hexString: "#0984e3") {
            modifyNavBar(backgroundColor)
        }
    }

    //MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isPurchased() {
            return quoteType.normalQuotes.count
        } else {
            return quoteType.normalQuotes.count + 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        
        if indexPath.row < quoteType.normalQuotes.count {
            
            cell.textLabel?.text = quoteType.normalQuotes[indexPath.row]
            
            cell.textLabel?.textColor = .none
            
            cell.accessoryType = .none
        } else {
            cell.textLabel?.text = "Buy Premium Quotes"
            
            cell.textLabel?.textColor = UIColor(hexString: "#0984e3")
            
            tableView.rowHeight = 70
            
            cell.accessoryType = .disclosureIndicator
        }
        
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == quoteType.normalQuotes.count {
            buyPremiumQuotes()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - modifyNavBar() method
    
    func modifyNavBar(_ backgroundColor: UIColor) {
        
        guard let navBar = navigationController?.navigationBar else {fatalError("Navigation Controller does not exist.")}
        
        let appearance = UINavigationBarAppearance()

        let contrastColor = ContrastColorOf(backgroundColor, returnFlat: true)
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: contrastColor]
        
        navBar.tintColor = contrastColor
        navBar.standardAppearance = appearance
        navBar.scrollEdgeAppearance = navBar.standardAppearance
        
    }
    
    //MARK: - buyPremiumQuotes() method
    
    func buyPremiumQuotes() {
        
        if SKPaymentQueue.canMakePayments() {
            
            let paymentRequest = SKMutablePayment()// creates a payment request
            
            paymentRequest.productIdentifier = productID// adds the productID, or the product which we want to get a payment request for
            
            SKPaymentQueue.default().add(paymentRequest)// we add this payment request to the queue
        } else {
            // can't make payments
            print("Can't make payments.")
        }
        
    }
    
    // gets triggered each time the payment queue is updated.
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        
        for transaction in transactions {
            if transaction.transactionState == .purchased {
                
                print("Transaction Successful")
                
                showPremiumQuotes()
                
                SKPaymentQueue.default().finishTransaction(transaction)
            } else if transaction.transactionState == .failed {
                print("Transaction failed.")
                if let error = transaction.error {
                    print("Error: \(error)")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        showPremiumQuotes()
    }
    
    func showPremiumQuotes() {
        UserDefaults.standard.set(true, forKey: K.productID)

        quoteType.normalQuotes.append(contentsOf: quoteType.premiumQuotes)
        navigationItem.setRightBarButton(nil, animated: true)
        tableView.reloadData()
    }
    
    //MARK: - isPurchased() method
    
    func isPurchased() -> Bool {
        let purchaseStatus = UserDefaults.standard.bool(forKey: K.productID)
        
        if purchaseStatus {
            return true
        } else {
            return false
        }
    }
    
    
    
    

    
    @IBAction func restorePressed(_ sender: UIBarButtonItem) {
        
        SKPaymentQueue.default().restoreCompletedTransactions()
    }
    
}
