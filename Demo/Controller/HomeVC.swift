//
//  HomeVC.swift
//  Demo
//
//  Created by Deepak on 20/07/23.
//

import UIKit
import SDWebImage

class HomeVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    
    var dataArray = [Datum]()
    var isDataLoading = false
    var isLoadingList = false
    var currentPageNumber = 1
    var limit = 6
    var totalRecord = 0
    var totalPage = 1
    var offset = 0

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         
        self.fetchUserList()
    }
    
    private func createSpinnerFooter() -> UIView {
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
       }

    func fetchUserList(){
        
        if self.currentPageNumber == 1{
            self.showIndicator(withTitle: "Indicator", and: "fetching details")
        }
        
        InternetManager.isUnreachable { _ in
            DispatchQueue.main.async {
                self.hideIndicator()
                self.showAlert(title: "Alert!", message: "Please check your internet connection and try again.")
            }
            return
        }
        
        let params:[String:String] = ["page":"\(self.currentPageNumber)"]
        
        UserViewModel().getUserList(urlString: "https://reqres.in/api/users?", parameter: params, completion: { success,response,error in
            
            DispatchQueue.main.async {
                self.isLoadingList = false
                if success{
                    
                    self.currentPageNumber = response!.page
                    self.currentPageNumber = self.currentPageNumber + 1
                    self.limit = response!.perPage
                    self.totalRecord = response!.total
                    self.totalPage = response!.totalPages
                    
                    if self.currentPageNumber == 2{
                        self.dataArray = response!.data
                    }else{
                        
                        if (response?.data.count)! > 0{
                            for dict in response!.data{
                                self.dataArray.append(dict)
                            }
                        }
                    }
                    self.tblView.reloadData()
                }else{
                    self.showAlert(title: "Alert!", message: error!)
                }
                self.tblView.tableFooterView = nil
                self.hideIndicator()
            }
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    @IBAction func sideMenuBtnAction(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Alert!", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let cancleAction = UIAlertAction(title: "Cancle", style: .default, handler: nil)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: logoutHandler(alert:))
        alertController.addAction(cancleAction)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func logoutHandler(alert: UIAlertAction){
        
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: ViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }

    
    @IBAction func addUserBtnAction(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "navFromHomeToAddUser", sender: self)
    }
    
}

extension HomeVC:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTVCell.identifier, for: indexPath) as? CustomTVCell else { fatalError("cell does not exists") }
        
        cell.imgView.sd_setImage(with: URL(string: self.dataArray[indexPath.row].avatar), placeholderImage: nil)
        cell.lbl.attributedText = NSMutableAttributedString.setAttributedTextwithSubTitle(self.dataArray[indexPath.row].firstName + " " + self.dataArray[indexPath.row].lastName, withSubTitle: self.dataArray[indexPath.row].email, withTextFont: UIFont(name: "Arial-BoldMT", size: 15.0)!, withSubTextFont: UIFont(name: "ArialMT", size: 14.0)!, withTextColor: .black, withSubTextColor: .black, withTextAlignment: .left)
        
        return cell
    }
}

extension HomeVC:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

extension HomeVC:UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList){
            self.isLoadingList = true
            self.tblView.tableFooterView = createSpinnerFooter()
            self.fetchUserList()
        }
    }
}
