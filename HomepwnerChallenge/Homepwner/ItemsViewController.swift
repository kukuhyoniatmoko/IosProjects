//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Kukuh Yoniatmoko on 24/01/18.
//  Copyright © 2018 Kukuh Yoniatmoko. All rights reserved.
//

import UIKit

class ItemsViewController : UITableViewController {
    var store: ItemStore!
    private var helper: SectionHelper!
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = helper.sections
        if section >= sections.count {
            return 1
        } else {
            return sections[section].items.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sections = helper.sections
        let cell: UITableViewCell
        if indexPath.section >= sections.count {
            cell = tableView.dequeueReusableCell(withIdentifier: "NoMoreItems", for: indexPath)
            cell.textLabel?.text = "No More Items!"
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
            let item = sections[indexPath.section].items[indexPath.row]
            
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sections = helper.sections
        if section >= sections.count {
            return nil
        } else {
            return sections[section].name
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return helper.sections.count + 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        helper = SectionHelper(store: store)
        (view as! UITableView).tableFooterView = UIView(frame: .zero)
    }

    class SectionHelper {
        let sections: [(name: String, items: [Item])]
        
        init(store: ItemStore) {
            var section1 = [Item]()
            var section2 = [Item]()
            
            for item in store.getAll() {
                if item.valueInDollars < 50 {
                    section1.append(item)
                } else {
                    section2.append(item)
                }
            }
            
            var sections = [(name: String, items: [Item])]()
            if !section1.isEmpty {
                sections.append(("Under $50", section1))
            }
            if !section2.isEmpty {
                sections.append(("$50 and above", section2))
            }
            
            self.sections = sections
        }
    }
}
