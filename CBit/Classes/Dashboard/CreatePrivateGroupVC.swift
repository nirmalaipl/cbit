//
//  CreatePrivateGroupVC.swift
//  CBit
//
//  Created by Emp-Mac-1 on 29/01/21.
//  Copyright © 2021 Bhavik Kothari. All rights reserved.
//

import UIKit
import M13Checkbox
import DropDown


class CreatePrivateGroupVC: UIViewController {

    @IBOutlet weak var chkeasy: M13Checkbox!
    @IBOutlet weak var chkmoderate: M13Checkbox!
    @IBOutlet weak var chkpro: M13Checkbox!
   
    
    @IBOutlet weak var chkClassic: M13Checkbox!
    @IBOutlet weak var chkSpinning: M13Checkbox!
    
    @IBOutlet weak var gameType1: M13Checkbox!
    @IBOutlet weak var gameType2: M13Checkbox!
    
    @IBOutlet weak var nos1: M13Checkbox!
    @IBOutlet weak var nos2: M13Checkbox!
    @IBOutlet weak var nos3: M13Checkbox!
    @IBOutlet weak var nos4: M13Checkbox!
    
    @IBOutlet weak var lockStyle1: M13Checkbox!
    @IBOutlet weak var lockStyle2: M13Checkbox!
    @IBOutlet weak var lockStyle3: M13Checkbox!
    
    private var arrUserGroupList = [AllUserListData]()
    
    @IBOutlet weak var img_spinningmachine: UIImageView!
    @IBOutlet weak var collectionviewtickets: UICollectionView!
    private var arrRandomNumbers = [Int]()
    var arrBarcketColor = [BracketData]()
    var startTimer: Timer?
    var timer: Timer?
    var seconds = Int()
    
    var dictContest = [String: Any]()
    var group_id : String?
    
    @IBOutlet weak var const_1: NSLayoutConstraint!
    @IBOutlet weak var const_2: NSLayoutConstraint!
    @IBOutlet weak var const_3: NSLayoutConstraint!
    
    @IBOutlet weak var const_GametypeVw: NSLayoutConstraint!
    @IBOutlet weak var const_NOSVw: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SetRandomNumber()
        setStartTimer()
        
        img_spinningmachine.isHidden = true
        collectionviewtickets.isHidden = true
        
        print(dictContest)
        
        
        let chkarr = [chkeasy,chkmoderate,chkpro,chkClassic,chkSpinning,gameType1,gameType2,nos1,nos2,nos3,nos4,lockStyle1,lockStyle2,lockStyle3]
        
        for chk in chkarr {
            chk?.markType = .radio
            chk?.boxType = .circle
            chk?.tintColor = #colorLiteral(red: 0.1019607843, green: 0.3098039216, blue: 0.3647058824, alpha: 1)
            chk?.secondaryTintColor = #colorLiteral(red: 0.1019607843, green: 0.3098039216, blue: 0.3647058824, alpha: 1)
            chk?.stateChangeAnimation = .fill
        }
        
        
        MyUserGroupList()
        
        
        const_1.constant = 10.0
        const_1.priority = UILayoutPriority(rawValue: 1000)
        
        const_2.constant = 10.0
        const_2.priority = UILayoutPriority(rawValue: 500)
        
        const_3.constant = 10.0
        const_3.priority = UILayoutPriority(rawValue: 500)
        
        const_GametypeVw.constant = 0.0
        const_GametypeVw.priority = UILayoutPriority(rawValue: 1000)
        
        const_NOSVw.constant = 0.0
        const_NOSVw.priority = UILayoutPriority(rawValue: 1000)
        
    }
    private func setStartTimer() {
      
        startTimer = Timer.scheduledTimer(timeInterval:0.5,
                                          target: self,
                                          selector: #selector(handleStartTimer),
                                          userInfo: nil,
                                          repeats: true)
    }
    
    @objc func handleStartTimer() {
      
                updateColors()
              SetRandomNumber()
        collectionviewtickets.reloadData()

    }
    
    @IBAction func btn_CHOOSE_GAME(_ sender: M13Checkbox) {
        if sender.tag == 0
        {
            chkClassic.checkState = .checked
            chkSpinning.checkState = .unchecked
            img_spinningmachine.isHidden = true
            collectionviewtickets.isHidden = false
            
            const_1.constant = 10.0
            const_1.priority = UILayoutPriority(rawValue: 500)
            
            const_2.constant = 10.0
            const_2.priority = UILayoutPriority(rawValue: 1000)
            
            const_3.constant = 10.0
            const_3.priority = UILayoutPriority(rawValue: 500)
            
            
            const_GametypeVw.constant = 80.0
            const_GametypeVw.priority = UILayoutPriority(rawValue: 1000)
            
        }
        else
        {
            chkClassic.checkState = .unchecked
            chkSpinning.checkState = .checked
            img_spinningmachine.isHidden = false
            collectionviewtickets.isHidden = true
            
            const_1.constant = 10.0
            const_1.priority = UILayoutPriority(rawValue: 500)
            
            const_2.constant = 10.0
            const_2.priority = UILayoutPriority(rawValue: 500)
            
            const_3.constant = 10.0
            const_3.priority = UILayoutPriority(rawValue: 1000)
            
            const_GametypeVw.constant = 0.0
            const_GametypeVw.priority = UILayoutPriority(rawValue: 1000)
            
            const_NOSVw.constant = 0.0
            const_NOSVw.priority = UILayoutPriority(rawValue: 1000)
            
            //Unchecked GameType
            gameType1.checkState = .unchecked
            gameType2.checkState = .unchecked
            
        }
    }
    
    @IBAction func btn_CHOOSE_GAME_LAVEL(_ sender: M13Checkbox) {
        if sender.tag == 0
        {
            chkeasy.checkState = .checked
            chkmoderate.checkState = .unchecked
            chkpro.checkState = .unchecked
        }
        else if sender.tag == 1
        {
            chkeasy.checkState = .unchecked
            chkmoderate.checkState = .checked
            chkpro.checkState = .unchecked
        }
        else if sender.tag == 2
        {
            chkeasy.checkState = .unchecked
            chkmoderate.checkState = .unchecked
            chkpro.checkState = .checked
        }
        
    }
    
    @IBAction func btn_CHOOSE_GAME_TYPE(_ sender: M13Checkbox) {
        if sender.tag == 0
        {
            gameType1.checkState = .checked
            gameType2.checkState = .unchecked
            
            const_NOSVw.constant = 0.0
            const_NOSVw.priority = UILayoutPriority(rawValue: 1000)
        }
        else if sender.tag == 1
        {
            gameType1.checkState = .unchecked
            gameType2.checkState = .checked
            
            const_NOSVw.constant = 80.0
            const_NOSVw.priority = UILayoutPriority(rawValue: 1000)
        }
        
    }
    
    @IBAction func btn_CHOOSE_NUMOFSLOT(_ sender: M13Checkbox) {
        if sender.tag == 0
        {
            nos1.checkState = .checked
            nos2.checkState = .unchecked
            nos3.checkState = .unchecked
            nos4.checkState = .unchecked
        }
        else if sender.tag == 1
        {
            nos1.checkState = .unchecked
            nos2.checkState = .checked
            nos3.checkState = .unchecked
            nos4.checkState = .unchecked
        }
        else if sender.tag == 2
        {
            nos1.checkState = .unchecked
            nos2.checkState = .unchecked
            nos3.checkState = .checked
            nos4.checkState = .unchecked
        }
        else if sender.tag == 3
        {
            nos1.checkState = .unchecked
            nos2.checkState = .unchecked
            nos3.checkState = .unchecked
            nos4.checkState = .checked
        }
    }
    
    @IBAction func btn_CHOOSE_LOCKSTYLE(_ sender: M13Checkbox) {
        if sender.tag == 0
        {
            lockStyle1.checkState = .checked
            lockStyle2.checkState = .unchecked
            lockStyle3.checkState = .unchecked
        }
        else if sender.tag == 1
        {
            lockStyle1.checkState = .unchecked
            lockStyle2.checkState = .checked
            lockStyle3.checkState = .unchecked
        }
        else if sender.tag == 2
        {
            lockStyle1.checkState = .unchecked
            lockStyle2.checkState = .unchecked
            lockStyle3.checkState = .checked
        }
    }
    
    

    @IBAction func back_click(_ sender: UIButton) {
        //self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func choosegame_click(_ sender: UIButton) {
        let  dropDown1 = DropDown()
                
        let pgname = arrUserGroupList.map { $0.privateGroupName }
        
        dropDown1.dataSource = pgname as! [String]
        dropDown1.anchorView =  sender
              
                dropDown1.selectionAction = {
                  
                  [unowned self] (index: Int, item: String) in
                  print("Selected item: \(item) at index: \(index)")
                    group_id = "\(arrUserGroupList[index].id ?? 0)"
                    sender.setTitle(item, for: .normal)
              }
              dropDown1.show()
    }
    @IBAction func numberofoption_click(_ sender: UIButton) {
        let  dropDown1 = DropDown()
                
             // dropDown1.dataSource = self.TimeList.compactMap{$0["StartTime"] as? String}
        
        dropDown1.dataSource = ["Game","Classic Grids","Spinning Machine"]
        dropDown1.anchorView =  sender
              
                dropDown1.selectionAction = {
                  
                  [unowned self] (index: Int, item: String) in
                  print("Selected item: \(item) at index: \(index)")
                    sender.setTitle(item, for: .normal)
              }
              dropDown1.show()
    }
    @IBAction func numberofitem_click(_ sender: UIButton) {
        let  dropDown1 = DropDown()
                
             // dropDown1.dataSource = self.TimeList.compactMap{$0["StartTime"] as? String}
        
        dropDown1.dataSource = ["1","2","3","4","5","6","7","8"]
        dropDown1.anchorView =  sender
              
                dropDown1.selectionAction = {
                  
                  [unowned self] (index: Int, item: String) in
                  print("Selected item: \(item) at index: \(index)")
                    sender.setTitle(item, for: .normal)
              }
              dropDown1.show()
    }
    @IBAction func numberof_click(_ sender: UIButton) {
        let  dropDown1 = DropDown()
                
             // dropDown1.dataSource = self.TimeList.compactMap{$0["StartTime"] as? String}
        
        dropDown1.dataSource = ["Win,draw,win","Win,win,win","Win,win,win,win","Win,win,win,win,win"]
        dropDown1.anchorView =  sender
              
                dropDown1.selectionAction = {
                  
                  [unowned self] (index: Int, item: String) in
                  print("Selected item: \(item) at index: \(index)")
                    sender.setTitle(item, for: .normal)
              }
              dropDown1.show()
    }
    @IBAction func next_click(_ sender: UIButton) {
       
        if group_id != nil
        {
            if chkClassic.checkState.rawValue == "Checked" ||  chkSpinning.checkState.rawValue == "Checked"
            {
                if chkClassic.checkState.rawValue == "Checked"
                {
                    if chkeasy.checkState.rawValue == "Checked" ||  chkmoderate.checkState.rawValue == "Checked" || chkpro.checkState.rawValue == "Checked"
                    {
                        if gameType1.checkState.rawValue == "Checked" || gameType2.checkState.rawValue == "Checked"
                        {
                            if gameType1.checkState.rawValue == "Checked"
                            {//Color color selected
                                
                                if lockStyle1.checkState.rawValue == "Checked" || lockStyle2.checkState.rawValue == "Checked" || lockStyle3.checkState.rawValue == "Checked"
                                {
                                    //showToast(message: "All Condition DONE.", font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin))
                                    CallEditPrivateGame()
                                }
                                else
                                {
                                    showToast(message: "Plese Select Number Of Items.", font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin))
                                }
                            }
                            else
                            {//Number Slot selected
                                if nos1.checkState.rawValue == "Checked" || nos2.checkState.rawValue == "Checked" || nos3.checkState.rawValue == "Checked" || nos4.checkState.rawValue == "Checked"
                                {
                                    if lockStyle1.checkState.rawValue == "Checked" || lockStyle2.checkState.rawValue == "Checked" || lockStyle3.checkState.rawValue == "Checked"
                                    {
                                        //showToast(message: "All Condition DONE.", font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin))
                                        CallEditPrivateGame()
                                    }
                                    else
                                    {
                                        showToast(message: "Plese Select Number Of Items.", font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin))
                                    }
                                }
                                else
                                {
                                    showToast(message: "Plese Select Number of characters.", font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin))
                                }
                            }
                        }
                        else
                        {
                            showToast(message: "Plese Select Game type.", font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin))
                        }
                    }
                    else
                    {
                        showToast(message: "Plese Choose Level.", font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin))
                    }
                }
                else
                {
                    if chkeasy.checkState.rawValue == "Checked" ||  chkmoderate.checkState.rawValue == "Checked" || chkpro.checkState.rawValue == "Checked"
                    {
                        if lockStyle1.checkState.rawValue == "Checked" || lockStyle2.checkState.rawValue == "Checked" || lockStyle3.checkState.rawValue == "Checked"
                        {
                            //showToast(message: "All Condition DONE.", font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin))
                            CallEditPrivateGame()
                        }
                        else
                        {
                            showToast(message: "Plese Select Number Of Items.", font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin))
                        }
                    }
                    else
                    {
                        showToast(message: "Plese Choose Level.", font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin))
                    }
                }
                
            }
            else
            {
                showToast(message: "Plese Choose Game.", font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin))
            }
        }
        else
        {
            showToast(message: "Plese Select Group.", font: UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin))
        }
        
        //CallEditPrivateGame()
    }
    
    
    func MyUserGroupList() {
        Loading().showLoading(viewController: self)
        let parameter: [String: Any] = [
            "userID":Define.USERDEFAULT.value(forKey: "UserID") as? String ?? ""
        ]
        let strURL = Define.APP_URL + Define.ALL_USER_PRIVATE_GROUP
        print("Parameter: \(parameter)\nURL: \(strURL)")
        
        let jsonString = MyModel().getJSONString(object: parameter)
        let encriptString = MyModel().encrypting(strData: jsonString!, strKey: Define.KEY)
        let strBase64 = encriptString.toBase64()
        
        SwiftAPI().postMethodSecure(stringURL: strURL,
                                    parameters: ["data": strBase64!],
                                    header: Define.USERDEFAULT.value(forKey: "AccessToken") as? String,
                                    auther: Define.USERDEFAULT.value(forKey: "UserID") as? String)
        { (result, error) in
            if error != nil {
                Loading().hideLoading(viewController: self)
                print("Error: \(error!.localizedDescription)")
                self.retry()
            } else {
                Loading().hideLoading(viewController: self)
                print("Result: \(result!)")
                let status = result!["statusCode"] as? Int ?? 0
                if status == 200 {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: result!, options: .prettyPrinted)
                        // here "jsonData" is the dictionary encoded in JSON data

                        let allUserListModel = try? JSONDecoder().decode(AllUserListModel.self, from: jsonData)
                        
                        self.arrUserGroupList = allUserListModel?.content ?? [AllUserListData]()
                        
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    
                    
                } else if status == 401 {
                    Define.APPDELEGATE.handleLogout()
                } else {
                    Alert().showAlert(title: "Alert",
                                      message: result!["message"] as! String,
                                      viewController: self)
                }
            }
        }
    }
    
    func CallEditPrivateGame() {
        //Loading().showLoading(viewController: self)
        var game_type = ""
        var lock_style = ""
        var game_lavel = ""
        var col = 0
        var raw = 0
        
        
        if chkClassic.checkState.rawValue == "Checked"
        {
            game_type = "rdb"
        }
        else
        {
            game_type = "spinning-machine"
        }
        
        if lockStyle1.checkState.rawValue == "Checked"
        {
            lock_style = "basic"
        }
        else if lockStyle2.checkState.rawValue == "Checked"
        {
            lock_style = "paper_chit"
        }
        else
        {
            lock_style = "catch_the_object"
        }
        
        if chkeasy.checkState.rawValue == "Checked"
        {
            if chkSpinning.checkState.rawValue == "Checked"
            {
                raw = 3
                col = 5
            }
            else
            {
                raw = 2
                col = 4
            }
        }
        else if chkmoderate.checkState.rawValue == "Checked"
        {
            if chkSpinning.checkState.rawValue == "Checked"
            {
                raw = 4
                col = 5
            }
            else
            {
                raw = 4
                col = 4
            }
        }
        else
        {
            if chkSpinning.checkState.rawValue == "Checked"
            {
                raw = 5
                col = 5
            }
            else
            {
                raw = 6
                col = 4
            }
        }
        
        
        var slotesArrayList = [[String:Any]]()
        var slotes = [String:Any]()
        var ans_min = ""
        var ans_max = ""
        
        if gameType1.checkState.rawValue == "Checked"
        {
            slotes = ["display_Name":"Red Win",
                      "start_value":"-100",
                      "end_value":"-1"]
            slotesArrayList.append(slotes)
            
            slotes.removeAll()
            slotes = ["display_Name":"Draw",
                      "start_value":"0",
                      "end_value":"0"]
            slotesArrayList.append(slotes)
            
            slotes.removeAll()
            slotes = ["display_Name":"Blue Win",
                      "start_value":"1",
                      "end_value":"100"]
            slotesArrayList.append(slotes)
            ans_min = "-100"
            ans_max = "100"
        }
        else
        {
            lock_style = "paper_chit"
        }
        
        if nos1.checkState.rawValue == "Checked"
        {
            ans_min = "0"
            ans_max = "9"
        }
        else if nos2.checkState.rawValue == "Checked"
        {
            ans_min = "0"
            ans_max = "9"
        }
        else if nos3.checkState.rawValue == "Checked"
        {
            ans_min = "0"
            ans_max = "9"
        }
        else
        {
            ans_min = "0"
            ans_max = "9"
        }
        
        var slotesArrayjsonString = [String:Any]()
        
        do {

            //Convert to Data
            let jsonData = try JSONSerialization.data(withJSONObject: slotesArrayList, options: JSONSerialization.WritingOptions.prettyPrinted)

            //Convert back to string. Usually only do this for debugging
            if let JSONString = String(data: jsonData, encoding: String.Encoding.utf8) {
               print(JSONString)
            }

            //In production, you usually want to try and cast as the root data structure. Here we are casting as a dictionary. If the root object is an array cast as [Any].
            slotesArrayjsonString = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String: Any] ?? [String: Any]()

            
        } catch {
            print(error)
        }
        
        let parameter: [String: Any] = [
            "contest_id":dictContest["id"]!,
            "group_id":group_id ?? "",
            "lock_style":lock_style,
            "cols":col,
            "rows":raw,
            "game_type":game_type,
            "ansRangeMin":ans_min,
            "ansRangeMax":ans_max,
            "no_of_items":"0",
            "categoryId":"0",
            "slots":slotesArrayjsonString,
            "Items_value":"[]"
            
          
        ]
        let strURL = Define.APP_URL + Define.PrivateGroup_EditPrivateGroup
        print("Parameter: \(parameter)\nURL: \(strURL)")
        
        let jsonString = MyModel().getJSONString(object: parameter)
        let encriptString = MyModel().encrypting(strData: jsonString!, strKey: Define.KEY)
        let strBase64 = encriptString.toBase64()
        
     /*   SwiftAPI().postMethodSecure(stringURL: strURL,
                                    parameters: ["data": strBase64!],
                                    header: Define.USERDEFAULT.value(forKey: "AccessToken") as? String,
                                    auther: Define.USERDEFAULT.value(forKey: "UserID") as? String)
        { (result, error) in
            if error != nil {
                Loading().hideLoading(viewController: self)
                print("Error: \(error!.localizedDescription)")
                self.retry()
            } else {
                Loading().hideLoading(viewController: self)
                print("Result: \(result!)")
                let status = result!["statusCode"] as? Int ?? 0
                if status == 200 {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: result!, options: .prettyPrinted)
                        // here "jsonData" is the dictionary encoded in JSON data

                        let allUserListModel = try? JSONDecoder().decode(AllUserListModel.self, from: jsonData)
                        
                        self.arrUserGroupList = allUserListModel?.content ?? [AllUserListData]()
                        
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    
                    
                } else if status == 401 {
                    Define.APPDELEGATE.handleLogout()
                } else {
                    Alert().showAlert(title: "Alert",
                                      message: result!["message"] as! String,
                                      viewController: self)
                }
            }
        }*/
    }
    
    func SetRandomNumber() {
        
        self.view.layoutIfNeeded()
        let rangeMinNumber = 0
        let rangeMaxNumber = 99
        
        let gamelevel = 1
        
        if gamelevel == 1 {
            arrRandomNumbers = MyModel().createRandomNumbers(number: 8, minRange: rangeMinNumber, maxRange: rangeMaxNumber)
            arrBarcketColor = MyDataType().getArrayBrackets(index: 8)
            //constraintCollectionViewHeight.constant = 50
        }
        self.view.layoutIfNeeded()
    }
    
    func updateColors()
    {
        for _ in 1...4 {
            let index = arrBarcketColor.count
            let lastColor = arrBarcketColor[index - 1]
            arrBarcketColor.remove(at: arrBarcketColor.count - 1)
            arrBarcketColor.insert(lastColor, at: 0)
        }
        arrRandomNumbers = MyModel().createRandomNumbers(number: 8, minRange: 0, maxRange: 99)
        
    }

}

extension CreatePrivateGroupVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       

        return arrRandomNumbers.count
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionviewtickets.frame.width / 4, height: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        
        let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "Bracketcv", for: indexPath) as! Bracketcv
        
            cell1.labelNumber.text = "\(arrRandomNumbers[indexPath.row])"
            cell1.viewColor.backgroundColor = arrBarcketColor[indexPath.row].color
      
        return cell1
        
    }
}

extension CreatePrivateGroupVC {
    func retry() {
        let alertController = UIAlertController(title: Define.ERROR_TITLE,
                                                message: Define.ERROR_SERVER,
                                                preferredStyle: .alert)
        let buttonRetry = UIAlertAction(title: "Retry",
                                        style: .default)
        { _ in
            self.MyUserGroupList()
        }
        let cancel = UIAlertAction(title: "Cancel",
                                   style: .cancel,
                                   handler: nil)
        alertController.addAction(cancel)
        alertController.addAction(buttonRetry)
        self.present(alertController,
                     animated: true,
                     completion: nil)
    }
    
  
}
