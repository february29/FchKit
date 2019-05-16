//
//  ViewController.swift
//  FchKit
//
//  Created by february29 on 10/31/2018.
//  Copyright (c) 2018 february29. All rights reserved.
//

import UIKit



class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    
    let tableView: UITableView = {
        let temp = UITableView();
        temp.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return temp ;
    }()
    
    
    var dataArray = ["commonViews","rx"];
    

    override func viewDidLoad() {
        super.viewDidLoad()
  
        self.view.addSubview(self.tableView);
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view);
        }
        
        
    }
    

    //MARK: table

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath))
        cell.textLabel?.text = self.dataArray[indexPath.row];
        return cell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            let vc = CommonViewViewController();
            self.navigationController?.pushViewController(vc, animated: true);
        }else if indexPath.row == 1{
            let vc = RXViewController();
            self.navigationController?.pushViewController(vc, animated: true);
        }
        
    }
    
   
   
    
    

}

