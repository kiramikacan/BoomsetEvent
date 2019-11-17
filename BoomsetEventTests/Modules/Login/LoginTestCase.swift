//
//  LoginTestCase.swift
//  BoomsetEventTests
//
//  Created by dev krm on 11/17/19.
//  Copyright © 2019 dev krm. All rights reserved.
//

import XCTest
@testable import BoomsetEvent

class LoginTestCase: XCTestCase {

    var loginVC: LoginViewController!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        loginVC = LoginViewController.initViewController()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testEmptyCredentials() {

        let loginPresenter = LoginTestPresenter()
        loginPresenter.startLoginWithCredentials(username: "", password: "")
        
        XCTAssertTrue(loginPresenter.isCredentialsEmpty , "Username or password may not be blank!")
        
    }
    
    func testFailedWithInvalidUsername() {

        let loginPresenter = LoginTestPresenter()
        loginPresenter.interactor = LoginTestInteractor(presenter: loginPresenter)
        loginPresenter.startLoginWithCredentials(username: "wrong_username", password: "Boomsettest123")
        
        XCTAssertTrue(loginPresenter.isLoginFailedWithInvalidCredentials , "Username or password incorrect!")
        
    }
    
    func testFailedWithInvalidPassword() {

        let loginPresenter = LoginTestPresenter()
        loginPresenter.interactor = LoginTestInteractor(presenter: loginPresenter)
        loginPresenter.startLoginWithCredentials(username: "testaccount@boomset.com", password: "wrong_password")
        
        XCTAssertTrue(loginPresenter.isLoginFailedWithInvalidCredentials , "Username or password incorrect!")
        
    }
    
    func testLoginSuccessful() {
        
        let loginPresenter = LoginTestPresenter()
        loginPresenter.interactor = LoginTestInteractor(presenter: loginPresenter)
        loginPresenter.startLoginWithCredentials(username: "testaccount@boomset.com", password: "Boomsettest123")
        
        XCTAssertTrue(loginPresenter.isLoginSuccessfull , "Congratulations you are successfully logged in")
    }
    
    func testLoginFailWithErrorMessage() {
        
        let loginPresenter = LoginTestPresenter()
        loginPresenter.interactor = LoginTestFakeInteractor(presenter: loginPresenter)
        loginPresenter.startLoginWithCredentials(username: "testaccount@boomset.com", password: "Boomsettest123")
        
        XCTAssertTrue(loginPresenter.loginFailedWithErrorMessage != nil , loginPresenter.loginFailedWithErrorMessage!)
    }
    
}
