//
//  QuoteViewController.swift
//  Motiv Quotes
//
//  Created by Adithyah Nair on 06/04/22.
//

import UIKit
import Foundation
import ChameleonFramework


class QuoteViewController: UITableViewController {
    
    let quoteType = Quotes()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let backgroundColor = UIColor(hexString: "#0984e3") {
            modifyNavBar(backgroundColor)
        }
        
    }

    //MARK: - TableView DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return quoteType.normalQuotes.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        
        if indexPath.row < quoteType.normalQuotes.count {
            cell.textLabel?.text = quoteType.normalQuotes[indexPath.row]
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
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - modifyNavBar
    
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

    
    @IBAction func restorePressed(_ sender: UIBarButtonItem) {
        
        
    }
    
}
