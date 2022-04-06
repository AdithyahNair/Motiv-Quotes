//
//  QuoteViewController.swift
//  Motiv Quotes
//
//  Created by Adithyah Nair on 06/04/22.
//

import UIKit
import Foundation


class QuoteViewController: UITableViewController {
    
    let quoteType = Quotes()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
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

    
    @IBAction func restorePressed(_ sender: UIBarButtonItem) {
        
        
    }
    
}
