//
//  ViewController.swift
//  InternetConnectionReachability
//
//  Created by Smita Kankayya on 22/02/24.
//

import UIKit

class ViewController: UIViewController {
    
    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async {
            self.reachability.whenReachable = { reachability in
                if reachability.connection == .wifi {
                    print("Reachable via WiFi")
                } else {
                    print("Reachable via Cellular")
                }
                self.view.window?.rootViewController?.dismiss(animated: true)
            }
            self.reachability.whenUnreachable = { _ in
                print("Not reachable")
                if let networkVC = self.storyboard?.instantiateViewController(withIdentifier: "NetworkErrorViewController") as? NetworkErrorViewController{
                    self.present(networkVC, animated: true)
                }
            }
            
            do {
                try self.reachability.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        }
    }
    
    deinit{
        reachability.stopNotifier()
    }
}

