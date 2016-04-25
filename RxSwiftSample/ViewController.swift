//
//  ViewController.swift
//  RxSwiftSample
//
//  Created by jollyjoester_pro on 4/26/16.
//  Copyright © 2016 jollyjoester. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

let disposeBag = DisposeBag()

class ViewController: UIViewController {

    // for Rx impl
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var textField1: UITextField!

    // for existing impl
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var textField2: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // for Rx impl
        textField1.rx_text
            .map {"「\($0)」"}
            .bindTo(label1.rx_text)
            .addDisposableTo(disposeBag)

        // for existing impl
        label2.text = "「」"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(UITextInputDelegate.textDidChange(_:)), name: UITextFieldTextDidChangeNotification, object: self.textField2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func textDidChange(notification: NSNotification) {
        if let text = textField2.text {
            label2.text = "「\(text)」"
        }
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

