//
//  InputUIViewController.swift
//  Input
//
//  Created by lben on 2021/2/7.
//

import UIKit

class InputUIViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let input = PasswordField()
        view.addSubview(input)
    }
}
