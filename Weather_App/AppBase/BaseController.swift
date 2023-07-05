//
//  BaseController.swift
//  Weather_App
//
//  Created by manjil on 05/07/2023.
//

import UIKit
import Combine

// MARK: - Protocols
public protocol StoryboardIdentifiable {
    var identifier: String { get }
}

public protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
}

// MARK: - StoryboardInitializable Extension
extension StoryboardInitializable where Self: BaseController {
    
    public static var storyboardIdentifier: String {
        return String(describing: Self.self)
    }
    
    static func initialize(from storyboard: StoryboardIdentifiable, viewModel: BaseViewModel) -> Self {
        let storyboard = UIStoryboard(name: storyboard.identifier, bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
        controller.setViewModel(viewModel: viewModel)
        return controller
    }
}

// MARK: - BaseController
open class BaseController: UIViewController, StoryboardInitializable {
    
    // MARK: - Properties
    private(set) var baseScreen: BaseScreen!
    private(set) var baseViewModel: BaseViewModel!
    private let isStoryboardIntialized: Bool
    var isRoot: Bool {  navigationController?.viewControllers.count == 1 }
    
    // MARK: - UI Components
    private lazy var overlayView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.hidesWhenStopped = true
        view.color = .black
        view.style = .large
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: .back, style: .plain, target: self, action: #selector(backButtonClicked))
        button.tag = 1
        button.tintColor = .white
        return button
    }()
    
    // MARK: - Lifecycle
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupOverlayView()
        setupUI()
        observeScreen()
        observeEvents()
        setupBackButton()
    }
    
    // MARK: - Initializers
    init(baseScreen: BaseScreen, baseViewModel: BaseViewModel) {
        self.baseScreen = baseScreen
        self.baseViewModel = baseViewModel
        self.isStoryboardIntialized = false
        super.init(nibName: nil, bundle: nil)
    }
    
    required public init?(coder: NSCoder) {
        self.isStoryboardIntialized = true
        super.init(coder: coder)
    }
    
    // MARK: - Methods
    func setViewModel(viewModel: BaseViewModel) {
        guard baseViewModel == nil else { return }
        baseViewModel = viewModel
    }
    
    override open func loadView() {
        super.loadView()
        guard !isStoryboardIntialized else { return }
        view = baseScreen
    }
    
    open func setupUI() {}
    open func observeEvents() {}
    func observeScreen() {}
    
    // MARK: - Private Methods
    private func setupBackButton() {
        if !isRoot {
            navigationItem.leftBarButtonItem = backButton
        }
    }
    
    private func setupOverlayView() {
        view.addSubview(overlayView)
        view.addSubview(indicator)
        
        NSLayoutConstraint.activate([
            overlayView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            overlayView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            overlayView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            overlayView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func backButtonClicked(sender: UIBarButtonItem) {
        pop()
    }
    
    // MARK: - Navigation
    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func get<T: BaseController>(type: T.Type) -> T? {
        navigationController?.viewControllers.first(where: { $0 is T }) as? T
    }
    
    // MARK: - Alert Method
    func alert(title: String, message: String, actions: [Alertable], style: UIAlertController.Style = .alert, titleAttribute: [NSAttributedString.Key: Any]? = nil, messageAttribute: [NSAttributedString.Key: Any]? = nil, completion: ((Alertable) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        if let attributes = titleAttribute {
            let attributedTitle = NSAttributedString(string: title, attributes: attributes)
            alertController.setValue(attributedTitle, forKey: "attributedTitle")
        }
        
        if let attributes = messageAttribute {
            let attributedMsg = NSAttributedString(string: message, attributes: attributes)
            alertController.setValue(attributedMsg, forKey: "attributedMessage")
        }
        
        actions.forEach { action in
            let alertAction = UIAlertAction(title: action.title, style: action.style) { _ in
                completion?(action)
            }
            alertController.addAction(alertAction)
        }
        present(alertController, animated: true, completion: nil)
    }
    
    @objc private func expire(_ sender: NSNotification) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            // Add your code here
        }
    }
    
    // MARK: - Deinit
    deinit {
        debugPrint("De-Initialized --> \(String(describing: self))")
    }
}
