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
    var data:[String] = []
    var file:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "SimpleNote"
        let createNoteButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNote))
        UIBarButtonItem.appearance().tintColor = UIColor.white
        self.navigationItem.rightBarButtonItem = createNoteButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        
        let docsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true)
        file = docsDir[0].appending("notes.txt")
        
        loadNote()
    }
    
    func createNote(){
        if(table.isEditing) {
            return
        }
        let note:String = "Row \(data.count+1)"
        data.insert(note, at: 0)
        let index:IndexPath = IndexPath(row: 0, section: 0)
        table.insertRows(at: [index], with: .automatic)
        saveNote()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        table.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        data.remove(at: indexPath.row)
        table.deleteRows(at: [indexPath], with: .fade)
        saveNote()
    }
    
    func saveNote() {
        let newData:NSArray = NSArray(array: data)
        newData.write(toFile: file, atomically: true)
    }
    
    func loadNote() {
        if let loadedData = NSArray(contentsOfFile:file) as? [String] {
            data = loadedData
            table.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

