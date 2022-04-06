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
        
        return quoteType.normalQuotes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = quoteType.normalQuotes[indexPath.row]
        
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
