//
//  CardIssuersViewController.swift
//  PaymentApp
//
//  Created by Diego on 10-04-21.
//  Copyright (c) 2021 DiegoS. All rights reserved.
//

import UIKit

protocol CardIssuersDisplayLogic: class
{
    func successCardIssuers(viewModel: CardIssuers.CardIssuer.ViewModel)
    func errorCardIssuers(viewModel: CardIssuers.CardIssuer.ViewModel)
    func successSelectedCardIssuer(viewModel: CardIssuers.CardIssuer.ViewModel)
    
}

class CardIssuersViewController: BaseViewController, CardIssuersDisplayLogic
{
    
  var interactor: CardIssuersBusinessLogic?
  var router: (NSObjectProtocol & CardIssuersRoutingLogic & CardIssuersDataPassing)?

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var refreshControl = UIRefreshControl()

    var cardIssuers: [CardIssuers.CardIssuer.Result] = []

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
    let interactor = CardIssuersInteractor()
    let presenter = CardIssuersPresenter()
    let router = CardIssuersRouter()
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
        setupView()
        loadCardIssuers()
    }
    
    func setupView() {
        title = "Bancos".localized
        messageLabel.text = "Selecciona banco".localized
        
        tableView.backgroundColor = Constants.Colors.defaultCellBGColor
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.reloadData()
        
        refreshControl.attributedTitle = NSAttributedString(string: "Tire para actualizar".localized)
        refreshControl.addTarget(self, action: #selector(loadCardIssuers), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    @objc func loadCardIssuers() {
        showActivityIndicator()
        let paymentMethodSelected = router?.dataStore?.paymentMethodSelected
        let request = CardIssuers.CardIssuer.Request(paymentMethodId: paymentMethodSelected!.id!)
        interactor?.requestCardIssuers(request: request)
    }
  
    // MARK: Display logic
    func successCardIssuers(viewModel: CardIssuers.CardIssuer.ViewModel) {
        hideActivityIndicator()
        stopRefresher()
        
        let unsortedCardIssuers = router?.dataStore!.cardIssuers ?? []
        cardIssuers = unsortedCardIssuers.sorted(by: { $0.name! < $1.name! })

        tableView.reloadData()
    }
    
    func errorCardIssuers(viewModel: CardIssuers.CardIssuer.ViewModel) {
        hideActivityIndicator()
        stopRefresher()
        alert(message: viewModel.message)
    }
    
    func successSelectedCardIssuer(viewModel: CardIssuers.CardIssuer.ViewModel) {
        hideActivityIndicator()
        router?.routeToInstallments(segue: nil)
    }
    
    func stopRefresher() {
        tableView!.refreshControl!.endRefreshing()
    }
}

extension CardIssuersViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if cardIssuers.isEmpty {
            return 1
        }
        return cardIssuers.count
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        if cardIssuers.isEmpty {
            return tableView.frame.height
        }
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if cardIssuers.isEmpty {
            return
        }
        selectFeedback()
        showActivityIndicator()
        let issuer = cardIssuers[indexPath.row]
        interactor?.selectCardIssuer(cardIssuerSelected: issuer)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cardIssuers.isEmpty {
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
            var cell: CardIssuerViewCell! = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as? CardIssuerViewCell
            if cell == nil {
                let nib: Array = Bundle.main.loadNibNamed("CardIssuerViewCell", owner: self, options: nil)!
                cell = nib[0] as? CardIssuerViewCell
            }

            cell.cardIssuer = cardIssuers[indexPath.row]
            return cell
        }
    }
}
