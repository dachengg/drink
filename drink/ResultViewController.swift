//
//  ResultViewController.swift
//  drink
//
//  Created by PengDa Cheng on 2018/10/24.
//  Copyright © 2018年 PengDa Cheng. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController ,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.order.count
    }
    
    @IBAction func Backbtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "result_cell", for: indexPath)as! ResultTableViewCell
        let order = self.order[indexPath.row]
        cell.nameLab.text = order.name
        cell.drinkLab.text = order.drink
        cell.priceLab.text = order.price
        cell.sugerLab.text = order.suger
        cell.iceLab.text = order.ice
        
        return cell
    }
    

    @IBOutlet weak var tableviewersult: UITableView!
    var order:[Result] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlStr = "https://sheetdb.io/api/v1/5b8bf2a1f407f"
        if let url = URL(string: urlStr){
            let task = URLSession.shared.dataTask(with: url){(data,response,error) in
                let decoder = JSONDecoder()
                if let data = data,let order = try? decoder.decode([Result].self, from: data){self.order = order
                    DispatchQueue.main.async {
                        self.tableviewersult.reloadData()
                    }
                    
                }
                
            }
            task.resume()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
