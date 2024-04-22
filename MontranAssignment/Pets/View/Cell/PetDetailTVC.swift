//
//  PetDetailTVC.swift
//  MontranAssignment
//
//  Created by Rakesh Sharma on 20/04/24.
//

import UIKit

class PetDetailTVC: UITableViewCell {
    
    @IBOutlet weak var imgPet: UIImageView!
    @IBOutlet weak var lblPetName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    static var identifire : String{
        return String(describing: self)
    }
    
    static var nib : UINib{
        return UINib(nibName: identifire, bundle: Bundle.main)
    }
    
    func setData(model: Pets) {
        imgPet.loadImage(imageUrl: model.image_url ?? "")
        lblPetName.text = model.title
    }
}
