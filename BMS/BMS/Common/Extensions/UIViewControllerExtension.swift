import Foundation
import Toast_Swift

@nonobjc extension UIViewController {
    
    func add(_ child: UIViewController, parentView: UIView? = nil) {
        addChild(child)
        parentView?.addSubview(child.view)
        if let frame = parentView?.bounds {
            child.view.frame = frame
        }

        
        child.didMove(toParent: self)
    }

    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    func showToast(_ message: String, backgroundColor: UIColor? = nil, onCompletion: (()-> Void)? = nil) {
        var style = ToastManager.shared.style
        if let backgroundColor = backgroundColor {
            style.backgroundColor = backgroundColor
        }
        style.titleAlignment = .center
        style.messageAlignment = .center
        style.messageFont = UIFont(name: "Helvetica", size: 13)!
        if let rootView = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            rootView.makeToast(message, style: style) { (bool) in
                onCompletion?()
            }
        } else{
             self.view.makeToast(message, style:style) { (bool) in
                 onCompletion?()
             }
        }
    }
}
