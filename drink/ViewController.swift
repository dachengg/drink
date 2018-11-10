//
//  ViewController.swift
//  drink
//
//  Created by PengDa Cheng on 2018/10/24.
//  Copyright © 2018年 PengDa Cheng. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    var drinkData: [drinkInfo] = []
    var choseSuger:String?
    var choseIce:String?
    
    let pickerview = UIPickerView()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return drinkData.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return drinkData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        drinkfl.text = drinkData[row].name
        pricefL.text = "\(drinkData[row].price)"
        
    }
    

    @IBOutlet weak var nametfL: UITextField!
    @IBOutlet weak var drinkfl: UITextField!
    @IBOutlet weak var pricefL: UITextField!
    @IBOutlet weak var suger: UISegmentedControl!
    @IBOutlet weak var ice: UISegmentedControl!
    @IBOutlet weak var sendbtn: UIButton!
    @IBOutlet weak var checkbtn: UIButton!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        sendbtn.layer.cornerRadius = 6
        checkbtn.layer.cornerRadius = 6
        nametfL.becomeFirstResponder()
        getDrinkTxt()
        pickerview.delegate = self
        pickerview.dataSource = self
        
        drinkfl.inputView = pickerview
        
        
        pricefL.isUserInteractionEnabled = false
  
        

    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //鍵盤隱藏
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func sendbtn(_ sender: UIButton) {
        if nametfL.text != "" && drinkfl.text != ""{
            checkSugerAndIce()
            sendToserver()
            nametfL.text = ""
            drinkfl.text = ""
            pricefL.text = ""
            okAlert()
        }else{
            popAlert()
        }
    }
    
    
    
    @IBAction func checkbtn(_ sender: UIButton) {
        if let controller = self.storyboard?.instantiateViewController(withIdentifier: "result") as? ResultViewController{
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func popAlert(){
        let alert = UIAlertController(title: "訊息", message: "請填寫完整訊息", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    func okAlert(){
        let alert = UIAlertController(title: "訊息", message: "訂購成功", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    
    //甜度冰塊判斷
    func checkSugerAndIce(){
        switch suger.selectedSegmentIndex {
        case 0:
            choseSuger = "正常"
        case 1:
            choseSuger = "半糖"
        case 2:
            choseSuger = "微糖"
        case 3:
            choseSuger = "無糖"
        default:
            break
        }
        switch ice.selectedSegmentIndex {
        case 0:
            choseIce = "正常"
        case 1:
            choseIce = "少冰"
        case 2:
            choseIce = "去冰"
        case 3:
            choseIce = "熱"
        default:
            break
        }
    }
    //讀取Txt
    func getDrinkTxt(){
        if let url = Bundle.main.url(forResource: "迷克夏", withExtension: "txt"),let content = try?
            String(contentsOf: url){
            let listArray = content.components(separatedBy: "\n")
            for n in 0 ..< listArray.count{
                if n % 2 == 0 {
                    let name = listArray[n]
                    if let price = Int(listArray[n + 1]){
                        drinkData.append(drinkInfo(name: name, price: price))
                    }
                }
            }
        }
    }
    
    //將資料傳至後台
    func sendToserver(){
        let url = URL(string: "https://sheetdb.io/api/v1/5b8bf2a1f407f")
        var urlRequest = URLRequest(url: url!)
        
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let orderDictionary:[String:Any] = ["name":nametfL.text!,"drink":drinkfl.text!,"price":pricefL.text!,"suger":choseSuger!,"ice":choseIce!]
        let orderData:[String:Any] = ["data":orderDictionary]
    
        do {
            let data = try JSONSerialization.data(withJSONObject: orderData, options: [])
            let task = URLSession.shared.uploadTask(with: urlRequest, from: data, completionHandler: { (retData, res,
                err) in
                if let returnData = retData, let dic = (try? JSONSerialization.jsonObject(with: returnData)) as? [String:String] {
                    print(dic)
                }
                
            })
            task.resume()
        }
        catch{
        }
    
    }
}

