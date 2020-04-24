//
//  ViewController.swift
//  Simple Note
//
//  Created by 이민규 on 2020/04/18.
//  Copyright © 2020 이민규. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var noteTableView: UITableView!
    
    var notesData: [Notes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegate
        self.noteTableView.delegate = self
        self.noteTableView.dataSource = self
        
        // font setting
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "SDMiSaeng", size: 30)!]
        
        // fetch core data
        self.fetch()
        
    }
    
    // show memo segue action
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMemo" {
            let memoVC = segue.destination as! MemoDetailViewController
            let indexPath = sender as? IndexPath
            memoVC.sendData(memo: self.notesData[indexPath!.row], row: indexPath!.row)
            memoVC.delegate = self
        }
    }

    @IBAction func addButtonClicked(_ sender: Any) {
        createNewMemo()
        self.tableView(self.noteTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
    }

    func createNewMemo() {
        self.save(title: "New Memo", date: Date(), content: "")
        self.noteTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
    
    // fetch all object
    func fetch() {
        self.notesData = CoreDataManager.shared.fetchObject(entityName: "Notes")!
    }
    
    // save new object
    func save(title: String, date: Date, content: String) {
        let note = CoreDataManager.shared.getNewObject(entityName: "Notes")!
        
        note.setValue(title, forKey: "title")
        note.setValue(date, forKey: "date")
        note.setValue(content, forKey: "contents")
        
        CoreDataManager.shared.saveContext()
        self.notesData.insert(note, at: 0)
    }
    
    // delete object
    func delete(obj: Notes) {
        CoreDataManager.shared.deleteObject(obj: obj);
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.notesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteTableViewCell
        let note = notesData[indexPath.row]
        let str = note.contents!
        let maxCount = 35
        
        cell.titleLabel.text = note.title
        
        // handle date
        cell.dateLabel.text = dateToString(note.date!)
        
        // TODO: cut string
        if str.count < maxCount {
            cell.detailLabel.text = str
        } else {
            cell.detailLabel.text = String(str[str.startIndex..<str.index(str.startIndex, offsetBy: maxCount)])
        }
        
        return cell
    }
    
    // row size
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    // cell selection action
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: "ShowMemo", sender: indexPath as Any)
    }
    
    // deleting cell
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.delete(obj: self.notesData[indexPath.row])
            self.notesData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
}

extension ViewController: DataShareDelegate {
    
    // send data protocol
    func sendData(memo: Notes, row: Int) {
        //self.notesData[row] = memo
        self.notesData.remove(at: row)
        self.notesData.insert(memo, at: 0)
        CoreDataManager.shared.saveContext()
        self.noteTableView.reloadData()
    }
    
}
