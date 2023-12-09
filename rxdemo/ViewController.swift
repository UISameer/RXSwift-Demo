import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating Observables
        let observable1 = Observable.just(1)
        observable1.subscribe({ print($0) }).dispose()
        
        let observable2 = Observable.of(10, 20, 30)
        observable2.subscribe({ print($0) }).dispose()
        
        let observable3 = Observable.from([1, 2, 3, 4, 5])
        observable3.subscribe({ print($0) }).dispose()
        
        
        // Dispose and Disposebag
        let subscribed1 = Observable.from([100, 200, 300]).subscribe({
            print($0)
        })
        subscribed1.dispose()
        
        let disposeBag = DisposeBag()
        _ = Observable.from([1, 2, 3]).subscribe({ print($0) }).disposed(by: disposeBag)
        
        // Subscribing to next events only
        _ = Observable.from([11, 12, 13]).subscribe(onNext: { print($0) })
        
        
        // Subscribing to all only
        _ = Observable.from([21, 22, 23]).subscribe(onNext: { print($0) },
                                                    onError: { print("Error is \($0)")},
                                                    onCompleted: { print("Observable sequence Completed") },
                                                    onDisposed: { print("Observable sequence Disposed") })
        
        
        let s = Schedulers()
        s.scheduleConcurrent()
        s.scheduleOperation()
        s.scheduleSerial()
        
        
    }
    
    
}

