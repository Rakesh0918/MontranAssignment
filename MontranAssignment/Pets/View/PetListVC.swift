//
//  ViewController.swift
//  MontranAssignment
//
//  Created by Rakesh Sharma on 20/04/24.
//
import Foundation
import UIKit

class PetListVC: UIViewController {
    
    @IBOutlet weak var stkCallAndChat: UIStackView!
    @IBOutlet weak var btnChat: UIButton!
    @IBOutlet weak var btnCall: UIButton!
    @IBOutlet weak var lblWorkingDayAndTime: UILabel!
    @IBOutlet weak var tblPetDetail: UITableView!
    
    private let viewModel = PetViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblPetDetail.register(PetDetailTVC.nib, forCellReuseIdentifier: PetDetailTVC.identifire)
        initViewModel()
    }
    
    func initViewModel() {
        viewModel.reloadView = self
        viewModel.fetchSettingData()
        viewModel.loadConfigJsonFile(forName: "config")
        viewModel.loadPetJsonFile(forName: "Pets")
    }
    
    func configureChatAndCallOption(model: Settings) {
        lblWorkingDayAndTime.text = model.workHours ?? ""
        if (model.isChatEnabled ?? false) && (model.isCallEnabled ?? false) {
            stkCallAndChat.isHidden = false
            btnChat.isHidden = false
            btnCall.isHidden = false
        }else if (model.isChatEnabled ?? false) && !(model.isCallEnabled ?? false) {
            stkCallAndChat.isHidden = false
            btnChat.isHidden = true
            btnCall.isHidden = false
        }else if !(model.isChatEnabled ?? false) && (model.isCallEnabled ?? false) {
            stkCallAndChat.isHidden = false
            btnChat.isHidden = false
            btnCall.isHidden = true
        }else {
            stkCallAndChat.isHidden = true
        }
    }
    
    @IBAction func btnChatTapped(_ sender: Any) {
        checkWorkingTimeAndShowMessage()
    }
    
    @IBAction func btnCallTapped(_ sender: Any) {
        checkWorkingTimeAndShowMessage() 
    }
    
    
    func checkWorkingTimeAndShowMessage() {
        if isInBusinessHours() {
            showAlert(message: const.withinWorkingHrMessage)
        }else{
            showAlert(message: const.outsideWorkingHrMessage)
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func isInBusinessHours() -> Bool {
        let currentDate = Date()
        let calendar = Calendar.current
        let timeZone = TimeZone(identifier: "Asia/Kolkata")!
        let currentDateTimeComponents = calendar.dateComponents(in: timeZone, from: currentDate)
        
        guard let weekday = currentDateTimeComponents.weekday, (1...5).contains(weekday) else {
            return false
        }
        guard let currentHour = currentDateTimeComponents.hour, (9...17).contains(currentHour) else {
            return false
        }
        return true
    }
    
}

extension PetListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PetDetailTVC.identifire, for: indexPath) as? PetDetailTVC else { return UITableViewCell() }
        cell.setData(model: viewModel.pets[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let patDetailVC = (Storyboards.mainSB.instantiateViewController(withIdentifier: "PetDetailVC") as? PetDetailVC) {
            patDetailVC.petDetailUrl = viewModel.pets[indexPath.row].content_url
            self.navigationController?.pushViewController(patDetailVC, animated: true)
        }
    }
    
}


extension PetListVC: ReloadView {
    
    func loadSettings(model: Settings) {
        DispatchQueue.main.async {
            self.configureChatAndCallOption(model: model)
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tblPetDetail.reloadData()
        }
    }
}
