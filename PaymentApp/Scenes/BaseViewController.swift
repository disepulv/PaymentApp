//
//  BaseViewController.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//

import UIKit

class BaseViewController: UIViewController, ActivityIndicatorPresenter {

    @IBOutlet weak var headerStack: UIStackView!
    @IBOutlet weak var footerStack: UIStackView!
    @IBOutlet weak var logoImageVeiw: UIImageView!

    var activityIndicator = UIActivityIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarItems()
    }
    

    func setupNavigationBarItems() {
        logoImageVeiw.image = Constants.Images.baseLogo
        headerStack.backgroundColor = Constants.Colors.defaultBGColor

        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.darkGray]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.darkGray]
        navBarAppearance.backgroundColor = Constants.Colors.defaultBGColor
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }

}
