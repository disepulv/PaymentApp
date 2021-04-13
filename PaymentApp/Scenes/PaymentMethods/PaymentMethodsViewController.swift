//
//  PaymentMethodsViewController.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

protocol PaymentMethodsDisplayLogic: class
{
   
    func successPaymentMethods(viewModel: PaymentMethods.PaymentMethod.ViewModel)
    func errorPaymentMethods(viewModel: PaymentMethods.PaymentMethod.ViewModel)
    func successSelectedPaymentMethod(viewModel: PaymentMethods.PaymentMethod.ViewModel)
}

class PaymentMethodsViewController: BaseViewController, PaymentMethodsDisplayLogic
{
    
  var interactor: PaymentMethodsBusinessLogic?
  var router: (NSObjectProtocol & PaymentMethodsRoutingLogic & PaymentMethodsDataPassing)?
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var refreshControl = UIRefreshControl()
    
    var paymentMethods: [PaymentMethods.PaymentMethod.Result] = []

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
    let interactor = PaymentMethodsInteractor()
    let presenter = PaymentMethodsPresenter()
    let router = PaymentMethodsRouter()
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
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadPaymentMethods()
    }
  
    func setupUI() {
        title = "Medios de pago".localized
        messageLabel.text = "Selecciona medio de pago".localized
        
        tableView.backgroundColor = Constants.Colors.defaultCellBGColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Tire para actualizar".localized)
        refreshControl.addTarget(self, action: #selector(loadPaymentMethods), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc func loadPaymentMethods() {
        showActivityIndicator()
        let request = PaymentMethods.PaymentMethod.Request()
        interactor?.requestPaymentMethods(request: request)
    }

    // MARK: Display logic
    func successPaymentMethods(viewModel: PaymentMethods.PaymentMethod.ViewModel) {
        hideActivityIndicator()
        stopRefresher()
        
        let unsortedPaymentMethods = router?.dataStore!.paymentMethods ?? []
        paymentMethods = unsortedPaymentMethods.sorted(by: { $0.name! < $1.name! })
        
        tableView.reloadData()
    }
    
    func errorPaymentMethods(viewModel: PaymentMethods.PaymentMethod.ViewModel) {
        hideActivityIndicator()
        stopRefresher()
        alert(message: viewModel.message)
    }
    
    func successSelectedPaymentMethod(viewModel: PaymentMethods.PaymentMethod.ViewModel) {
        hideActivityIndicator()
        router?.routeToCardIssuers(segue: nil)
    }
    
    func stopRefresher() {
        tableView!.refreshControl!.endRefreshing()
    }
}

extension PaymentMethodsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if paymentMethods.isEmpty {
            return 1
        }
        return paymentMethods.count
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        if paymentMethods.isEmpty {
            return tableView.frame.height
        }
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if paymentMethods.isEmpty {
            return
        }
        selectFeedback()
        showActivityIndicator()
        let paymentMethod = paymentMethods[indexPath.row]
        interactor?.selectPaymentMethod(paymentMethodSelected: paymentMethod)
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if paymentMethods.isEmpty {
            var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
            if cell == nil {
                cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "reuseIdentifier")
            }

            cell!.textLabel!.text = "No hay registros".localized
            cell!.textLabel!.numberOfLines = 0
            cell!.textLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
            cell!.textLabel!.textAlignment = NSTextAlignment.center
            cell!.backgroundColor = Constants.Colors.defaultCellBGColor
            cell!.selectionStyle = .none
            return cell!
        } else {
            var cell: PaymentMethodViewCell! = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as? PaymentMethodViewCell
            if cell == nil {
                let nib: Array = Bundle.main.loadNibNamed("PaymentMethodViewCell", owner: self, options: nil)!
                cell = nib[0] as? PaymentMethodViewCell
            }

            cell.paymentMethod = paymentMethods[indexPath.row]
            return cell
        }
    }
}
