//
//  HomeViewController.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

protocol HomeDisplayLogic: class
{
    func successAmount(viewModel: Home.Amount.ViewModel)
    func errorAmount(viewModel: Home.Amount.ViewModel)
}

class HomeViewController: BaseViewController, HomeDisplayLogic
{
  var interactor: HomeBusinessLogic?
  var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    static let notificationName = Notification.Name("_installmentsAlreadySelected")
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountTextField: CustomUITextField!
    
    @IBOutlet weak var paymentMethodLabel: UILabel!
    @IBOutlet weak var paymentMethodValueLabel: UILabel!
    
    @IBOutlet weak var issuerLabel: UILabel!
    @IBOutlet weak var issuerValueLabel: UILabel!
    
    @IBOutlet weak var installmentsLabel: UILabel!
    @IBOutlet weak var installmentsValueLabel: UILabel!
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var payButton: UIButton!
    
    @IBOutlet weak var summaryStack: UIStackView!
    
  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
  {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup()
  {
    let viewController = self
    let interactor = HomeInteractor()
    let presenter = HomePresenter()
    let router = HomeRouter()
    viewController.interactor = interactor
    viewController.router = router
    interactor.presenter = presenter
    presenter.viewController = viewController
    router.viewController = viewController
    router.dataStore = interactor
  }
  
  // MARK: Routing
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
    if let scene = segue.identifier {
      let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
      if let router = router, router.responds(to: selector) {
        router.perform(selector, with: segue)
      }
    }
  }
  
  // MARK: View lifecycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupUI()
        NotificationCenter.default.addObserver(self, selector: #selector(onInstallmentSelectedNotification(notification:)), name: HomeViewController.notificationName, object: nil)
    }
    
    func setupUI() {
        title = "Home".localized
        amountTextField.placeholder = "Monto".localized
        amountLabel.text = "Ingresa monto".localized
        continueButton.setTitle("Continuar".localized, for: .normal)
        payButton.setTitle("Pagar".localized, for: .normal)
        
        paymentMethodLabel.text = "Medio de pago".localized
        issuerLabel.text = "Banco".localized
        installmentsLabel.text = "Cuotas".localized
        
        summaryStack.isHidden = true
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    @IBAction func amountChanged(_ sender: Any) {
        continueButton.setTitle("Continuar".localized, for: .normal)
        summaryStack.isHidden = true
    }
    
    // MARK: Display logic
    func successAmount(viewModel: Home.Amount.ViewModel) {
        hideActivityIndicator()
        successFeedback()
        router?.routeToPaymentMethods(segue: nil)
    }
    
    func errorAmount(viewModel: Home.Amount.ViewModel) {
        hideActivityIndicator()
        warningFeedback()
        alert(message: viewModel.message)
    }
    
    // MARK: Actions
    @IBAction func continueAction(_ sender: Any) {
        showActivityIndicator()
        
        let amount = amountTextField.text
        let request = Home.Amount.Request(amount: amount!)
        interactor?.doCheckAmount(request: request)
    }
    
    @objc func onInstallmentSelectedNotification(notification:Notification) {
        continueButton.setTitle("Cuotas".localized, for: .normal)
        
        let installment = notification.userInfo!["installment"] as! Installments.Installment.PayerCost
        let cardIssuer = notification.userInfo!["cardIssuer"] as! CardIssuers.CardIssuer.Result
        let paymentMethod = notification.userInfo!["paymentMethod"] as! PaymentMethods.PaymentMethod.Result
        
        paymentMethodValueLabel.text = paymentMethod.name
        issuerValueLabel.text = cardIssuer.name
        installmentsValueLabel.text = installment.recommendedMessage
        
        summaryStack.isHidden = false
        
    }
}
