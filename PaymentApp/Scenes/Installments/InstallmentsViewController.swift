//
//  InstallmentsViewController.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

protocol InstallmentDelegate {
    func selectInstallment(installment: Installments.Installment.PayerCost, issuer: Installments.Installment.Issuer)
}

protocol InstallmentsDisplayLogic: class
{
    func successInstallments(viewModel: Installments.Installment.ViewModel)
    func errorInstallments(viewModel: Installments.Installment.ViewModel)

}

class InstallmentsViewController: BaseViewController, InstallmentsDisplayLogic
{
  var interactor: InstallmentsBusinessLogic?
  var router: (NSObjectProtocol & InstallmentsRoutingLogic & InstallmentsDataPassing)?

    var delegate: InstallmentDelegate?

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    var installments: [Installments.Installment.PayerCost] = []
    var issuer: Installments.Installment.Issuer!
  
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
    let interactor = InstallmentsInteractor()
    let presenter = InstallmentsPresenter()
    let router = InstallmentsRouter()
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
        loadInstallments()
    }

    func setupUI() {
        title = "Cuotas".localized
        messageLabel.text = "Selecciona cuotas".localized
        
        tableView.backgroundColor = Constants.Colors.defaultCellBGColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Tire para actualizar".localized)
        refreshControl.addTarget(self, action: #selector(loadInstallments), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func loadInstallments() {
        showActivityIndicator()
        
        let amount = router?.dataStore?.amount
        let paymentMethodId = router?.dataStore?.paymentMethodSelected.id
        let cardIssuerIdSelected = router?.dataStore?.cardIssuerSelected.id

        let request = Installments.Installment.Request(amount: amount!, issuerId: cardIssuerIdSelected!, paymentMethodId: paymentMethodId!)
        interactor?.requestInstallments(request: request)
    }
    
    func successInstallments(viewModel: Installments.Installment.ViewModel) {
        hideActivityIndicator()
        stopRefresher()
        
        guard let installments = router?.dataStore?.installments, !installments.isEmpty else {
            tableView.reloadData()
            return
        }
    
        self.installments = installments[0].payerCosts ?? []
        self.issuer = installments[0].issuer!
        tableView.reloadData()
    }
    
    func errorInstallments(viewModel: Installments.Installment.ViewModel) {
        hideActivityIndicator()
        alert(message: viewModel.message)
    }
    
    func stopRefresher() {
        tableView!.refreshControl!.endRefreshing()
    }


}

extension InstallmentsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if installments.isEmpty {
            return 1
        }
        return installments.count
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        if installments.isEmpty {
            return tableView.frame.height
        }
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if installments.isEmpty {
            return
        }
        selectFeedback()
        let installmentSelected = installments[indexPath.row]
        let cardIssuerSelected = router?.dataStore?.cardIssuerSelected
        let paymentMethodSelected = router?.dataStore?.paymentMethodSelected
        dismiss(animated: true) {
            
            NotificationCenter.default.post(name: HomeViewController.notificationName, object: nil,
                                            userInfo: ["installment": installmentSelected,
                                                       "cardIssuer":  cardIssuerSelected!,
                                                       "paymentMethod": paymentMethodSelected!,
                                                       "issuer": self.issuer!])
        }
//        delegate?.selectInstallment(installment: installmentSelected, issuer: issuer)
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if installments.isEmpty {
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
            var cell: InstallmentViewCell! = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as? InstallmentViewCell
            if cell == nil {
                let nib: Array = Bundle.main.loadNibNamed("InstallmentViewCell", owner: self, options: nil)!
                cell = nib[0] as? InstallmentViewCell
            }

            cell.installment = installments[indexPath.row]
            return cell
        }
    }
    
    
}
