import UIKit
import RxSwift
import RxCocoa

class UIDemo: UIViewController {
    
    let txtField: UITextField! = nil
    let txtView: UITextView! = nil
    let button: UIButton! = nil
    let txtFieldLabel: UILabel! = nil
    private let disposeBag = DisposeBag()
    
    func demoUI() {
        
        txtField.rx.text
            .bind(to: txtFieldLabel.rx.text)
            .disposed(by: disposeBag)
        
        txtView.rx.text.orEmpty.asDriver()
            .map{ "Char count: \($0.count)"}
            .drive(txtFieldLabel.rx.text)
            .disposed(by: disposeBag)
        
        button.rx.tap
            .bind (onNext: { [unowned self] _ in
                self.button.titleLabel!.text! += "Tap Clicked"
                self.view.endEditing(true)
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                }
            }).disposed(by: disposeBag)
    }
    
}
