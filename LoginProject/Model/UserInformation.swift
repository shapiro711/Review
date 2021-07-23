//
//  UserInfo.swift
//  LoginProject
//
//  Created by Kim Do hyung on 2021/07/21.
//

import UIKit

class UserInformation {
    static let shared = UserInformation()
    var id: String?
    var password: String?
    var birthDate: String?
    var introduce: String?
    var profileImage: UIImage?
    var phoneNumber: String?
    
    func resetUserInformation() {
        id = nil
        password = nil
        birthDate = nil
        introduce = nil
        profileImage = nil
        phoneNumber = nil
    }
    
    private init() {}
}
