//
//  PetDetailVC.swift
//  MontranAssignment
//
//  Created by Rakesh Sharma on 21/04/24.
//

import UIKit
import WebKit

class PetDetailVC: UIViewController {
    
    @IBOutlet weak var wbPetDetail: WKWebView!
    
    var petDetailUrl: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPetDetail()
    }
    
    func loadPetDetail() {
        guard let petDetailUrl = petDetailUrl else { return }
        guard let myURL = URL(string: petDetailUrl) else { return }
        let myRequest = URLRequest(url: myURL)
        wbPetDetail.load(myRequest)
    }
}
