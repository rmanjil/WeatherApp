//
//  BaseController.swift
//  Weather_App
//
//  Created by manjil on 05/07/2023.
//

import UIKit
import Combine

//// 1. make storyboard conforms to this for identification
public protocol StoryboardIdentifiable {
    var identifier: String { get }
}

//// 2. protocol to conforms to the storyboard identifier
public protocol StoryboardInitializable {
    static var storyboardIdentifier: String { get }
}

//// 3. create extension and implement the initialization
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

open class BaseController: UIViewController, StoryboardInitializable {
    
    /// The baseView of controller
    private(set) var baseScreen: BaseScreen!
    
    /// The baseViewModel of controller
    private(set) var baseViewModel: BaseViewModel!
    
    /// The flag to check if the controller was initialized from storyboard
    private let isStoryboardIntialized: Bool
    
    var isRoot: Bool {  navigationController?.viewControllers.count == 1 }
    
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
    
    var showOverlayView: Bool = false {
        didSet {
            view.bringSubviewToFront(overlayView)
            overlayView.isHidden = !showOverlayView
            indicate = showOverlayView
        }
    }
    
    var indicate: Bool = false {
        didSet {
            view.bringSubviewToFront(indicator)
            indicate ? indicator.startAnimating() : indicator.stopAnimating()
        }
    }
    
    /// The backButton
    lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: .back, style: .plain, target: self, action: #selector(backButtonClicked))
        button.tag = 1
        button.tintColor = .white
        return button
    }()
    
    /// when view is loaded
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        setupOverlayView()
        
        /// setup UI
        setupUI()
        
        /// observe screen
        observeScreen()
        
        /// observe events
        observeEvents()
        
        setupBackButton()
        
        
    }
    
    /// Method that will set the viewmodel after initialization from storyboard
    /// - Parameter viewModel: the viewmodel for the controller
    func setViewModel(viewModel: BaseViewModel) {
        guard baseViewModel == nil else { return }
        baseViewModel = viewModel
    }
    
    /// Initializer for a controller
    /// - Parameters:
    ///   - baseView: the view associated with the controller
    ///   - baseViewModel: viewModel associated with the controller
    init(baseScreen: BaseScreen, baseViewModel: BaseViewModel) {
        self.baseScreen = baseScreen
        self.baseViewModel = baseViewModel
        self.isStoryboardIntialized = false
        super.init(nibName: nil, bundle: nil)
    }
    
    /// Not available
    required public init?(coder: NSCoder) {
        self.isStoryboardIntialized = true
        super.init(coder: coder)
    }
    
    /// Load the base view as the view of controller
    override open func loadView() {
        super.loadView()
        guard !isStoryboardIntialized else { return }
        view = baseScreen
    }
    
    /// setup trigger
    open func setupUI() {}
    
    /// Observer for events
    open func observeEvents() {}
    
    func observeScreen() {
        
    }
    
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
    
    @objc func backButtonClicked(sender: UIBarButtonItem) {
        pop()
    }
    
    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func get<T: BaseController>(type: T.Type) -> T? {
        navigationController?.viewControllers.first(where: { $0 is T }) as? T
    }
    
    /// Deint call check
    deinit {
        debugPrint("De-Initialized --> \(String(describing: self))")
    }
}

// MARK: - Alert Method
extension BaseController {
    
    func alert(title: String, message: String, actions: [Alertable], style: UIAlertController.Style = .alert, titleAttribute: [NSAttributedString.Key: Any]? = nil, messageAttribute: [NSAttributedString.Key: Any]? = nil, completion: ((Alertable) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        if let attributes = titleAttribute {
            //attributed title
            let attributedTitle = NSAttributedString(string: title, attributes: attributes)
            alertController.setValue(attributedTitle, forKey: "attributedTitle")
        }
        
        if let attributes = messageAttribute {
            // Attributed message
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
            guard let self else { return }

        }
    }
}
