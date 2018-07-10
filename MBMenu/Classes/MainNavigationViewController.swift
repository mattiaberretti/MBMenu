//
//  MainNavigationViewController.swift
//  EquipeGiordani
//
//  Created by Mattia on 30/06/18.
//  Copyright © 2018 Mattia. All rights reserved.
//

import UIKit
import SideMenu

class MainNavigationViewController: UINavigationController, UITableViewDelegate {

    @IBInspectable var showMenu : Bool = true
    @IBInspectable var segueDefault : String?
    
    @IBInspectable var nomeStoryBoard : String?
    
    private lazy var controllerLeft : UISideMenuNavigationController = {
        return UIStoryboard(name: self.nomeStoryBoard!, bundle: Bundle.main).instantiateInitialViewController() as! UISideMenuNavigationController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SideMenuManager.default.menuLeftNavigationController = controllerLeft
        SideMenuManager.default.menuFadeStatusBar = false
        (SideMenuManager.default.menuLeftNavigationController?.topViewController as! UITableViewController).tableView.delegate = self
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.view)
        if let def = self.segueDefault {
            self.performSegue(withIdentifier: def, sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func showMenu(_ sender : UIBarButtonItem){
        present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        if showMenu, let controller = self.viewControllers.first {
            let img = UIImage(named: "menuIcon", in: Bundle(for: MainNavigationViewController.self), compatibleWith: nil)
            controller.navigationItem.leftBarButtonItem = UIBarButtonItem(image: img!, style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.showMenu(_:)))
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MenuTableViewCell, let segue = cell.segueIdentifer {
            self.viewControllers.removeAll()
            self.performSegue(withIdentifier: segue, sender: self)
            dismiss(animated: true, completion: nil)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
