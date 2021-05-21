//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by dueda on 2021/3/9.
//

import UIKit
import RxDataSources
import RxSwift

class ViewController: UIViewController {

    var tableView: UITableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        let reuseIdentifier = "\(TableViewCell.self)"
    let viewModel = ViewModel()
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registCell(TableViewCell.self)
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        tableView.rowHeight = 50
        view.addSubview(tableView)
//        tableView.register(TableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        let  dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, User>>(configureCell: { _, tableView, indexPath, user in
            let cell = tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifier, for: indexPath) as! TableViewCell
            cell.textLabel?.text = user.screenName
            cell.tag = indexPath.row
            return cell
        })
        viewModel.getUser().bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
//        tableView.rx.itemSelected.map { indexPath in
//            return (indexPath, dataSource[indexPath])
//        }.subscribe(onNext: { indexPath, model in
//            self.navigationController?.pushViewController(ViewController(), animated: true)
//        })
//        .disposed(by: disposeBag)
        tableView.rx.modelSelected(User.self).subscribe { (model) in
            print(model.screenName)
        }.disposed(by: disposeBag)
//        text1()
//        test2()
        test3()
//        test4()
//        test5()
//        test6()
//        testMulticastConnectOperators()
//        testReplayConnectOperators()
//        SchedulerTest()
//        test7()
        
        let button = UIButton()
        button.rx.tap.subscribe(onNext:{ [weak self] in
            
        })
        .disposed(by: disposeBag)
        
        

    }
    
    func singleTest() -> Single<[String : Any]>{
        return Single.create { single in
            single(.success([:]))
            single(.failure("" as! Error))
            single(.init(catching: { () -> [String : Any] in
                return [:]
            }))
            return Disposables.create {
            
            }
        }
    }
    
    func completableTest() -> Completable {
        return Completable.create { completable in
            completable(.error("" as! Error))
            completable(.completed)
            return Disposables.create {
                
            }
        }
    }
    
    func maybeTest() -> Maybe<String> {
        return Maybe.create { maybe in
            maybe(.success(""))
            maybe(.error("" as! Error))
            maybe(.completed)
            return Disposables.create {
                
            }
        }
    }
    
    func driverTest()  {
        let textFiled = UITextField()
        let tmp = UITextField()
        let label = UILabel()
        let input = textFiled.rx.text.orEmpty.asDriver()
        input.drive(label.rx.text).disposed(by: DisposeBag())//textFiled 绑定label
        Observable.combineLatest(textFiled.rx.text.orEmpty, tmp.rx.text.orEmpty) {
            text1,text2 -> String in
            return text1 + text2
        }.bind(to: label.rx.text)
        .disposed(by: DisposeBag())
        
        
    }
    
    func text1()  {
        let disposeBag = DisposeBag()
        let sequenceThatFails = PublishSubject<String>()

        sequenceThatFails
            .catchAndReturn("😊")
            .subscribe { print($0) }
            .disposed(by: disposeBag)

        sequenceThatFails.onNext("😬")
        sequenceThatFails.onNext("😨")
        sequenceThatFails.onNext("😡")
        sequenceThatFails.onNext("🔴")
        sequenceThatFails.onError("" as! Error)

        let recoverySequence = PublishSubject<String>()

        sequenceThatFails
            .catch {
                print("Error:", $0)
                return recoverySequence
            }
            .subscribe { print($0) }
            .disposed(by: disposeBag)

        sequenceThatFails.onNext("😬")
        sequenceThatFails.onNext("😨")
        sequenceThatFails.onNext("😡")
        sequenceThatFails.onNext("🔴")
        sequenceThatFails.onError("" as! Error)

        recoverySequence.onNext("😊")
    

    }
    
    func test2() {
        let disposeBag = DisposeBag()
        let first = PublishSubject<String>()
        first.onNext("1")
        first.subscribe { (e) in
            print(e.element ?? "Error")
        }.disposed(by: disposeBag)
        first.onNext("2")
        first.onNext("3")
    }
    
    func test3() {
        let disposeBag = DisposeBag()
        let first = AsyncSubject<String>()
        first.onNext("1")
        first.subscribe { (e) in
            print(e.element ?? "Error")
        }.disposed(by: disposeBag)
        first.onNext("2")
        first.onNext("3")
        first.onCompleted()
    }
    
    func test4() {
        //去重
//        Observable.of("1", "2", "2", "2", "3", "3", "4")
//            .distinctUntilChanged()
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposeBag)
        //截取前几个
//        Observable.of("Hank", "Kody","Cooci", "CC")
//            .take(2)
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposeBag)
        //后几个
//        Observable.of("Hank", "Kody","Cooci", "CC")
//            .takeLast(3)
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposeBag)
        //从源可观察序列发出元素，直到参考可观察序列发出元素
//        这个要重点,应用非常频繁 比如我页面销毁了,就不能获取值了(cell重用运用)
        //截取第二个事件的开始 第一个个就不发送消息
        print("*****takeUntil*****")
        let sourceSequence = PublishSubject<String>()
        let referenceSequence = PublishSubject<String>()

        sourceSequence
            .take(until: referenceSequence)
            .subscribe { print($0) }
            .disposed(by: disposeBag)

        sourceSequence.onNext("Cooci")
        sourceSequence.onNext("Kody")
        sourceSequence.onNext("CC")

        referenceSequence.onNext("Hank") // 条件一出来,下面就走不了

        sourceSequence.onNext("Lina")
        sourceSequence.onNext("小雁子")
        sourceSequence.onNext("婷婷")
        
        //截取后面的
        print("*****skip*****")
        Observable.of(1, 2, 3, 4, 5, 6)
            .skip(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        print("*****skipWhile*****")
        Observable.of(1, 2, 3, 4, 5, 6)
            .skip { $0 < 4 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        //截取信后之后的打印
        print("*****skipUntil*****")
        let sourceSeq = PublishSubject<String>()
        let referenceSeq = PublishSubject<String>()

        sourceSeq
            .skip(until: referenceSeq)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)

        // 没有条件命令 下面走不了
        sourceSeq.onNext("Cooci")
        sourceSeq.onNext("Kody")
        sourceSeq.onNext("CC")

        referenceSeq.onNext("Hank") // 条件一出来,下面就可以走了

        sourceSeq.onNext("Lina")
        sourceSeq.onNext("小雁子")
        sourceSeq.onNext("婷婷")
    }
    
    func test5() {
        //集合
        print("*****toArray*****")
        Observable.range(start: 1, count: 10)
            .toArray()
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        print("*****reduce*****")
        Observable.of(10, 100, 1000)
            .reduce(10000, accumulator: -) // 1 + 10 + 100 + 1000 = 1111
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        print("*****concat*****")
        //用于网络请求 订阅不完成onCompleted  下一个订阅不开始
        let subject1 = BehaviorSubject(value: "Hank")
        let subject2 = BehaviorSubject(value: "1")

        let subjectsSubject = BehaviorSubject(value: subject1)

        subjectsSubject.asObservable()
            .concat()
            .subscribe { print($0) }
            .disposed(by: disposeBag)

        subject1.onNext("Cooci")
        subject1.onNext("Kody")

        subjectsSubject.onNext(subject2)

        subject2.onNext("打印不出来")
        subject2.onNext("2")

        subject1.onCompleted() // 必须要等subject1 完成了才能订阅到! 用来控制顺序 网络数据的异步
        subject2.onNext("3")
        
        //替换Error并返回
        print("*****catchErrorJustReturn*****")
        let sequenceThatFails = PublishSubject<String>()
        sequenceThatFails.catchAndReturn("出错了").subscribe{
            print($0)
        }.disposed(by: disposeBag)
        sequenceThatFails.onNext("Hank")
        sequenceThatFails.onNext("Kody") // 正常序列发送成功的
        //发送失败的序列,一旦订阅到位 返回我们之前设定的错误的预案
        sequenceThatFails.onError(MyError.A)
        
        
        print("*****catchError*****")
        //将错误信息打印并转向下一个订阅
        let recoverySequence = PublishSubject<String>()

        sequenceThatFails
            .catch {
                print("Error:", $0)
                return recoverySequence  // 获取到了错误序列-我们在中间的闭包操作处理完毕,返回给用户需要的序列(showAlert)
            }
            .subscribe { print($0) }
            .disposed(by: disposeBag)

        sequenceThatFails.onNext("Hank")
        sequenceThatFails.onNext("Kody") // 正常序列发送成功的
        sequenceThatFails.onError(MyError.A) // 发送失败的序列

        recoverySequence.onNext("CC")
        
        
        
        print("*****retry*****")
        var count = 1 // 外界变量控制流程
        let sequenceRetryErrors = Observable<String>.create { observer in
            observer.onNext("Hank")
            observer.onNext("Kody")
            observer.onNext("CC")
            
            if count == 1 {
                // 流程进来之后就会过度-这里的条件可以作为出口,失败的次数
                observer.onError(MyError.B)  // 接收到了错误序列,重试序列发生
                print("错误序列来了")
                count += 1
            }
            
            observer.onNext("Lina")
            observer.onNext("小雁子")
            observer.onNext("婷婷")
            observer.onCompleted()
            
            return Disposables.create()
        }

        sequenceRetryErrors
            .retry()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        print("*****retry(_:)*****")
        let sequenceThatErrors = Observable<String>.create { observer in
            observer.onNext("Hank")
            observer.onNext("Kody")
            observer.onNext("CC")
            
            if count < 5 { // 这里设置的错误出口是没有太多意义的额,因为我们设置重试次数
                observer.onError(MyError.B)
                print("错误序列来了")
                count += 1
            }
            
            observer.onNext("Lina")
            observer.onNext("小雁子")
            observer.onNext("婷婷")
            observer.onCompleted()
            
            return Disposables.create()
        }

        sequenceThatErrors
            .retry(3)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)


    }
    
    func test6() {
//        print("*****debug*****")
//        var count = 1
//
//        let sequenceThatErrors = Observable<String>.create { observer in
//            observer.onNext("Hank")
//            observer.onNext("Kody")
//            observer.onNext("CC")
//
//            if count < 5 {
//                observer.onError(MyError.B)
//                print("错误序列来了")
//                count += 1
//            }
//
//            observer.onNext("Lina")
//            observer.onNext("小雁子")
//            observer.onNext("可心")
//            observer.onCompleted()
//
//            return Disposables.create()
//        }
//
//        sequenceThatErrors
//            .retry(3)
//            .debug()
//            .subscribe(onNext: { print($0) })
//            .disposed(by: disposeBag)
        
        


    }
    
    func testMulticastConnectOperators(){
        print("*****multicast*****")
        let subject = PublishSubject<Any>()
        subject.subscribe{print("00:\($0)")}
            .disposed(by: disposeBag)
        
        let netOB = Observable<Any>.create { (observer) -> Disposable in
                sleep(2)// 模拟网络延迟
                print("我开始请求网络了")
                observer.onNext("请求到的网络数据")
                observer.onNext("请求到的本地")
                observer.onCompleted()
                return Disposables.create {
                    print("销毁回调了")
                }
            }.publish()
        
        netOB.subscribe(onNext: { (anything) in
                print("订阅1:",anything)
            })
            .disposed(by: disposeBag)

        // 我们有时候不止一次网络订阅,因为有时候我们的数据可能用在不同的额地方
        // 所以在订阅一次 会出现什么问题?
        netOB.subscribe(onNext: { (anything) in
                print("订阅2:",anything)
            })
            .disposed(by: disposeBag)
        
        _ = netOB.connect()
    }
//    func testReplayConnectOperators(){
//        print("*****replay*****")
//
//        let interval = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).replay(5)
//
//        interval.subscribe(onNext: { print(Date.,"订阅: 1, 事件: \($0)") })
//            .disposed(by: self.disposeBag)
//
//        delay(2) { _ = interval.connect() }
//
//        delay(4) {
//            interval.subscribe(onNext: { print(Date.time,"订阅: 2, 事件: \($0)") })
//                .disposed(by: self.disposeBag)
//        }
//
//        delay(8) {
//            interval.subscribe(onNext: { print(Date.time,"订阅: 3, 事件: \($0)") })
//                .disposed(by: self.disposeBag)
//        }
//        delay(20, closure: {
//            self.disposeBag = DisposeBag()
//        })
//
//        /**
//         订阅: 1, 事件: 4
//         订阅: 1, 事件: 0
//         2019-05-28 21-32-42 订阅: 2, 事件: 0
//         2019-05-28 21-32-42 订阅: 1, 事件: 1
//         2019-05-28 21-32-42 订阅: 2, 事件: 1
//         2019-05-28 21-32-45 订阅: 2, 事件: 4
//         2019-05-28 21-32-46 订阅: 3, 事件: 0
//         2019-05-28 21-32-46 订阅: 3, 事件: 1
//         2019-05-28 21-32-46 订阅: 3, 事件: 2
//         2019-05-28 21-32-46 订阅: 3, 事件: 3
//         2019-05-28 21-32-46 订阅: 3, 事件: 4
//
//         // 序列从 0开始
//         // 定时器也没有断层  sub2 sub3 和 sub1 是同步的
//         */
//    }
    //调度者
//    func SchedulerTest() {
//        let button = UIButton()
//        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
//        button.backgroundColor = UIColor.red
//        view.addSubview(button)
//        DispatchQueue.global().async {
//            button.rx.tap
//                .subscribe(onNext: { () in
//                    print("点击了按钮 --- \(Thread.current)")
//                })
//                .disposed(by: self.disposeBag)
//        }
//    }
    
    //controlEvent
    func test7() {
        let button = UIButton()
        button.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
       button.backgroundColor = UIColor.red
   view.addSubview(button)
        let controlEventOB = button.rx.controlEvent(.touchUpInside)

        controlEventOB.subscribe { (reslut) in
                print("订阅:\(reslut) \n \(Thread.current)")
            }.disposed(by: disposeBag)

        controlEventOB.subscribe { (reslut) in
                print("订阅:\(reslut) \n \(Thread.current)")
            }.disposed(by: self.disposeBag)
        button.rx.title(for: .normal).asObserver().onNext("11")
    }


}

enum MyError: Error {
    case A
    case B
    var errorType: String {
        switch self {
        case .A:
            return "I am error A"
        case .B:
            return "I am error B"
        }
    }
}
