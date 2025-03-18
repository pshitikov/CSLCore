
import SwiftUI

extension CSLNavigationBarLargeTitleItems {
    
    public class Wrapper: UIViewController {
        
        // MARK: - Enums
        
        private enum Values {
            
            static var navigationBarLargeTitleClass: String { "_UINavigationBarLargeTitleView" }
            static var focusGroupIdentifier: String { "LargeTitleViews" }
            static var bottomPadding: CGFloat { -11 }
            static var trailingPadding: CGFloat { -20 }
        }
        
        // MARK: - Properties
        
        private let representable: CSLNavigationBarLargeTitleItems?
        
        // MARK: - Initialization
        
        init(representable: CSLNavigationBarLargeTitleItems) {
            self.representable = representable
            
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            self.representable = nil
            
            super.init(coder: coder)
        }
        
        // MARK: - Life cycle
        
        override public func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            
            addTrailingItems()
        }
        
        override public func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            hideTralingItems()
        }
        
        // MARK: - Internal functions
        
        func addTrailingItems() {
            guard let representable,
                  let navigationBar = navigationController?.navigationBar,
                  let UINavigationBarLargeTitleView = NSClassFromString(Values.navigationBarLargeTitleClass) else { return }
            
            navigationBar.subviews.forEach { subview in
                guard subview.isKind(of: UINavigationBarLargeTitleView.self) else { return }
                
                subview.subviews.forEach { subview in
                    if subview.focusGroupIdentifier == Values.focusGroupIdentifier {
                        subview.removeFromSuperview()
                    }
                }
                
                let controller = UIHostingController(rootView: representable.trailingItems())
                controller.view.translatesAutoresizingMaskIntoConstraints = false
                controller.view.backgroundColor = UIColor.clear
                controller.view.focusGroupIdentifier = Values.focusGroupIdentifier
                
                subview.addSubview(controller.view)
                
                NSLayoutConstraint.activate([
                    controller.view.bottomAnchor.constraint(
                        equalTo: subview.bottomAnchor,
                        constant: Values.bottomPadding
                    ),
                    controller.view.trailingAnchor.constraint(
                        equalTo: subview.trailingAnchor,
                        constant: Values.trailingPadding
                    ),
                ])
            }
        }
        
        // MARK: - Private Functions
        
        private func hideTralingItems() {
            guard let navigationBar = navigationController?.navigationBar,
                  let UINavigationBarLargeTitleView = NSClassFromString(Values.navigationBarLargeTitleClass) else { return }
            
            navigationBar.subviews.forEach { subview in
                guard subview.isKind(of: UINavigationBarLargeTitleView.self) else { return }
                
                subview.alpha = 0
            }
        }
    }
}
