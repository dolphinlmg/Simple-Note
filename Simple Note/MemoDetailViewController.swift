//
//  MemoDetailViewController.swift
//  Simple Note
//
//  Created by 이민규 on 2020/04/20.
//  Copyright © 2020 이민규. All rights reserved.
//

import UIKit
import CoreData

class MemoDetailViewController: UIViewController {

    var memoData: Notes?
    var indexPath: IndexPath = IndexPath(row: 0, section: 0)
    var delegate: DataShareDelegate?
    var isDataChanged: Bool = false
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.titleTextField.text = self.memoData?.title
        self.dateLabel.text = dateToStringDetail((self.memoData?.date)!)
        self.contentTextView.text = self.memoData?.contents
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isDataChanged { self.memoData?.date = Date() }
        delegate?.sendData(memo: self.memoData!, row: self.indexPath.row)
    }

}

extension MemoDetailViewController: DataShareDelegate {
    
    func sendData(memo: Notes, row: Int) {
        self.memoData = memo
        self.indexPath.row = row
    }
    
    
}

extension MemoDetailViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.memoData?.contents = self.contentTextView.text
        self.isDataChanged = true
    }
}
