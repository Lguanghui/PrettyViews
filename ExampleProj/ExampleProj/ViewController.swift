//
//  ViewController.swift
//  ExampleProj
//
//  Created by 梁光辉 on 2022/2/12.
//

import UIKit
import LoveUIKit
import FoundationX
import SnapKit

class RootViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }


    let controllersList = ["AlbumShadowViewController"]
    
    let controllerNames = ["合集/相册影子效果"]
    
    private lazy var tableView = UITableView().then { tab in
        tab.delegate = self
        tab.dataSource = self
    }
    
    func classFromString(_ className: String) -> AnyClass! {

        /// get namespace
        let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String

        /// get 'anyClass' with classname and namespace
        let cls: AnyClass = NSClassFromString("\(namespace).\(className)")!

        // return AnyClass!
        return cls
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return controllersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let label = UILabel()
        label.text = controllerNames[indexPath.row]
        cell.contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = classFromString(controllersList[indexPath.row]) as! UIViewController.Type
        let instance = vc.init()
        instance.title = controllerNames[indexPath.row]
        navigationController?.pushViewController(instance, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

class ViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rootVC = RootViewController()
        pushViewController(rootVC, animated: true)
    }
}
