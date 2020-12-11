//
//  ViewController.swift
//  BreakingBad
//
//  Created by Kevin Reid on 10/12/2020.
//

import UIKit


class CharactersListViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    var breakingBadCharacters:[Details] = []
    var filteredData:[Details] = []
    var imageURLs  = [String]()
    var isSearchBarSearch = false
    var person: Details? 
    let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    @IBOutlet weak var tableView: UITableView!
    
    fileprivate func getBreakingBadCharacters() {
        let jsonService = JsonService()
       
        jsonService.getBreakingBadCharacters{ (success, response, error) in
            if success {
                guard let details = response as? [Details] else { return }
                self.breakingBadCharacters = details
                DispatchQueue.main.async {
                    self.showTableView(isHidden: false)
                    self.showSearchBar(isHidden: false)
                    self.tableView.reloadData()
                }
            }
            
            else if let error = error {
                DispatchQueue.main.async { [self] in
                    showTableView(isHidden:true)
                    showSearchBar(isHidden: true)
                    errorAlertView(error: error)
                }
            }
        }
    }
    
    func showTableView(isHidden: Bool) {
        tableView.isHidden = isHidden
    }
    
    func showSearchBar(isHidden: Bool) {
        searchBar.isHidden = isHidden
    }
    
    func errorAlertView(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription.description)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
        })
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        showTableView(isHidden:true)
        showSearchBar(isHidden: true)
        getBreakingBadCharacters()
    }
    

}

extension CharactersListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.isSearchBarSearch {
            return self.filteredData.count
        }  else {
            return breakingBadCharacters.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") as! TableViewCell
        if self.isSearchBarSearch {
            cell.cell(details:self.filteredData[indexPath.row])
        } else {
            cell.cell(details:self.breakingBadCharacters[indexPath.row])
    
        }

        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.isSearchBarSearch {
            person = self.filteredData[indexPath.row]
        } else {
            person = breakingBadCharacters[indexPath.row]
        }
        
        performSegue(withIdentifier: "detailsTableViewController", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let detailsTableViewController = segue.destination as? DetailsTableViewController {
                detailsTableViewController .person = self.person
           }
       }
}


extension CharactersListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if self.searchBar.text == nil || self.searchBar.text == "" {
            self.isSearchBarSearch = false
            view.endEditing(true)
            self.tableView.reloadData()
        } else {
            self.isSearchBarSearch = true
            self.filteredData = self.breakingBadCharacters.filter{($0.name.localizedCaseInsensitiveContains(self.searchBar.text!))}
            self.tableView.reloadData()
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
    }
    
}
