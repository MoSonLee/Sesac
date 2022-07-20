//
//  SearchTableViewController.swift
//  TrendMedia
//
//  Created by 이승후 on 2022/07/19.
//

import UIKit

class SearchTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return MovieEum.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieEum.allCases[section].movieSection
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as! SearchTableViewCell
        cell.posterImage.image = MovieEum.allCases[indexPath.section].movieImage
        cell.titleLabel.text = MovieEum.allCases[indexPath.section].movieTitle
        cell.dateLabel.text = MovieEum.allCases[indexPath.section].movieDate
        cell.descriptionLabel.text = MovieEum.allCases[indexPath.section].movieDescription
        cell.titleLabel.setTitleLabel()
        cell.dateLabel.setDateLabel()
        cell.descriptionLabel.setDescriptionLabel()
        
        return cell
    }
}
