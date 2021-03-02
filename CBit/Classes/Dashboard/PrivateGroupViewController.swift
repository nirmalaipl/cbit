//
//  PrivateGroupViewController.swift
//  CBit
//
//  Created by My Mac on 06/11/20.
//  Copyright © 2020 Bhavik Kothari. All rights reserved.
//

import UIKit

class privategroupcell: UITableViewCell {
    @IBOutlet var lblgroupname: UILabel!
    @IBOutlet var btnjoincontest: UIButton!
    
    @IBOutlet var topvw: UIView!
    @IBOutlet var bottomvw: UIView!
    
    @IBOutlet var lbltitle: UILabel!
    @IBOutlet var lbllockstyle: UILabel!
    
    @IBOutlet weak var img_lockstyle: UIImageView!
    @IBOutlet weak var img_grouptype: UIImageView!
    
}

class PrivateGroupViewController: UIViewController {

    @IBOutlet var lbltitle: UILabel!
    @IBOutlet var lbldate: UILabel!
    @IBOutlet var lblgametime: UILabel!
    @IBOutlet var lblremainingtime: UILabel!
    @IBOutlet var lblentryclosing: UILabel!
    
    @IBOutlet var tbllist: UITableView!
    var GroupList = [String]()
    private var arrGroupList = [[String: Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        GroupList = ["Happy family","Cousion","Friends Forever","Top 20","Land On moon","Old is Gold"]
        MyGroupList()
    }
    

 
    @IBAction func back_click(_ sender: UIButton) {
        // self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func searchgroup_click(_ sender: UIButton) {
    }
    @IBAction func creategroup_click(_ sender: UIButton) {
        let CreatePrivateGroupVC = self.storyboard?.instantiateViewController(withIdentifier: "CreatePrivateGroupVC") as! CreatePrivateGroupVC
        self.navigationController?.pushViewController(CreatePrivateGroupVC, animated: true)
    }
    
    @IBAction func btn_editgame_click(_ sender: UIButton) {
        //let CreatePrivateGroupVC = self.storyboard?.instantiateViewController(withIdentifier: "HostGameVC") as! HostGameVC
        //self.navigationController?.pushViewController(CreatePrivateGroupVC, animated: true)
        
        let jticketwaitinglists = self.storyboard?.instantiateViewController(withIdentifier: "HostGameVC") as! HostGameVC
        jticketwaitinglists.modalPresentationStyle = .fullScreen
        self.present(jticketwaitinglists, animated: true, completion: nil)
        
    }
    
    func MyGroupList() {
        Loading().showLoading(viewController: self)
        let parameter: [String: Any] = [
           
            :]
        let strURL = Define.APP_URL + Define.ALL_Contest_Request
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
                    let tempDict = result!["content"] as? [String: Any] ?? [:]
                    self.arrGroupList = tempDict["allRequest"] as? [[String:Any]] ?? []
                    
                    self.tbllist.reloadData()
                    
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
    
    
}


//MARK: - TableView Delegate Method
extension PrivateGroupViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrGroupList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "privategroupcell") as! privategroupcell
        
        //Set Data
       
        
        //Set Button
        cell.btnjoincontest.tag = indexPath.row
        cell.btnjoincontest.addTarget(self, action: #selector(buttonJoinContest(_:)), for: .touchUpInside)
        
        
        cell.lblgroupname.text = "Group Name : \(arrGroupList[indexPath.row]["group_name"] as? String ?? "N/A")"
        
        let lockStyle =  arrGroupList[indexPath.row]["lock_style"] as? String ?? "N/A"
        if lockStyle == "basic"
        {
            cell.lbllockstyle.text = "Lock Style : Basic"
            cell.img_lockstyle.image = #imageLiteral(resourceName: "classic_grid")
        }
        else if lockStyle == "paper_chit"
        {
            cell.lbllockstyle.text = "Lock Style : Paper Chit"
            cell.img_lockstyle.image = #imageLiteral(resourceName: "ic_paper_chit")
        }
        else
        {
            cell.lbllockstyle.text = "Lock Style : Other"
            cell.img_lockstyle.image = #imageLiteral(resourceName: "ic_paper_chit")
        }
        
        
        let soldTicket = arrGroupList[indexPath.row]["ticketSold"] as? String ?? "0"
        let gameType =  arrGroupList[indexPath.row]["game_type"] as? String ?? "N/A"
        if gameType == "spinning-machine"
        {
            cell.lbltitle.text = "Game Type : Spinning Machine (\(soldTicket) Tickets sold)"
            cell.img_grouptype.image = #imageLiteral(resourceName: "slot_machine")
        }
        else if gameType == "0-9"
        {
            cell.lbltitle.text = "Game Type : Classic Grid (\(soldTicket) Tickets sold)"
            cell.img_grouptype.image = #imageLiteral(resourceName: "classic_grid")
        }
        
        
        DispatchQueue.main.async {
            MyModel().roundCorners(corners: [.topRight,.topLeft,.bottomRight, .bottomLeft], radius: 10, view: cell.topvw)
            MyModel().roundCorners(corners: [.topRight,.topLeft,.bottomRight, .bottomLeft], radius: 10, view: cell.bottomvw)
            MyModel().roundCorners(corners: [.bottomLeft], radius: 10, view: cell.btnjoincontest)
            cell.bottomvw.createDottedLine(width: 3, color: UIColor.black.cgColor)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
//        let ticketVC = self.storyboard?.instantiateViewController(withIdentifier: "TicketVC") as! TicketVC
//        ticketVC.dictContest = arrContest[indexPath.row]
//        self.navigationController?.pushViewController(ticketVC, animated: true)
    }
    
    //MARK: - Tableview Button Mathod
    @objc func buttonJoinContest(_ sender: UIButton) {
        print(sender.tag)

    }
}

extension PrivateGroupViewController {
    func retry() {
        let alertController = UIAlertController(title: Define.ERROR_TITLE,
                                                message: Define.ERROR_SERVER,
                                                preferredStyle: .alert)
        let buttonRetry = UIAlertAction(title: "Retry",
                                        style: .default)
        { _ in
            self.MyGroupList()
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
