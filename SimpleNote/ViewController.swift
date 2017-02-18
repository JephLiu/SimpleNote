//
//  ViewController.swift
//  SimpleNote
//
//  Created by Jeph on 2/18/17.
//  Copyright © 2017 Jeph. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    var data:[String] = ["Row 1","Row 2","Row 3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "SimpleNote"
        let createNoteButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNote))
        self.navigationItem.rightBarButtonItem = createNoteButton
    }
    
    func createNote(){
        let note:String = "Row \(data.count+1)"
        data.insert(note, at: 0)
        let index:IndexPath = IndexPath(row: 0, section: 0)
        table.insertRows(at: [index], with: .automatic)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

