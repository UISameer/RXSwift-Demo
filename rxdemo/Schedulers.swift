import Foundation
import UIKit
import RxSwift
import RxCocoa

class Schedulers {
    
    private let disposeBag = DisposeBag()
    let imageData = PublishSubject<Data>()
    
    func scheduleConcurrent() {
        
        let imageView = UIImageView()
        let concurrentScheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        imageData.observe(on: concurrentScheduler)
            .map{ UIImage(data: $0) }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {imageView.image = $0})
            .disposed(by: disposeBag)
    }
    
    func scheduleSerial() {
        
        let imageView = UIImageView()
        let concurrentQueue = DispatchQueue(label: "com.concurrentQueue", attributes: .concurrent)
        let serScheduler = SerialDispatchQueueScheduler(queue: concurrentQueue, internalSerialQueueName: "com.serialQueue")
        imageData.observe(on: serScheduler)
            .map{ UIImage(data: $0) }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {imageView.image = $0})
            .disposed(by: disposeBag)
    }
    
    func scheduleOperation() {
        
        let imageView = UIImageView()
        let opQueue = OperationQueue()
        let oprQueueScheduler = OperationQueueScheduler(operationQueue: opQueue)
        imageData.observe(on: oprQueueScheduler)
            .map{ UIImage(data: $0) }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: {imageView.image = $0})
            .disposed(by: disposeBag)
    }
}
