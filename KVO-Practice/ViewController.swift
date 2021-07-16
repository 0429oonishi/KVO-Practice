//
//  ViewController.swift
//  KVO-Practice
//
//  Created by 大西玲音 on 2021/07/16.
//

import UIKit

final class Account: NSObject {
    
    @objc var balance: Double {
        willSet {
            self.willChangeValue(forKey: #keyPath(Account.balance))
        }
        didSet {
            self.didChangeValue(forKey: #keyPath(Account.balance))
        }
    }
    
    @objc var interestRate: Double
    
    init(_ balance: Double, _ interestRate: Double) {
        self.balance = balance
        self.interestRate = interestRate
    }
    
}

final class Person: NSObject {
    
    func registerAccount(_ account: Account) {
        account.addObserver(self,
                            forKeyPath: #keyPath(Account.balance),
                            options: [.new, .old],
                            context: nil)
        account.addObserver(self,
                            forKeyPath: #keyPath(Account.interestRate),
                            options: [.new, .old],
                            context: nil)
        
    }
    
    override func observeValue(forKeyPath keyPath: String?,
                               of object: Any?,
                               change: [NSKeyValueChangeKey : Any]?,
                               context: UnsafeMutableRawPointer?) {
        print(#function)
    }
    
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let account = Account(0, 0)
        let person = Person()
        person.registerAccount(account)
        account.balance = 100
        
    }


}
