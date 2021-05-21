//
//  ViewModel.swift
//  RxSwiftDemo
//
//  Created by dueda on 2021/4/9.
//

import UIKit
import RxSwift
import RxDataSources
import Moya

class ViewModel: NSObject {
    func getUser() -> Observable<[SectionModel<String, User>]> {
        return Observable.create { (observer) -> Disposable in
            let users = [User(followersCount: 19_901_990, followingCount: 1990, screenName: "Marco Sun"),
                         User(followersCount: 19_890_000, followingCount: 1989, screenName: "Taylor Swift"),
                         User(followersCount: 250_000, followingCount: 25, screenName: "Rihanna"),
                         User(followersCount: 13_000_000_000, followingCount: 13, screenName: "Jolin Tsai"),
                         User(followersCount: 25_000_000, followingCount: 25, screenName: "Adele")]
            let section = [SectionModel(model: "", items: users)]
            observer.onNext(section)
            observer.onCompleted()
            return Disposables.create {
                print("Disposed")
            }
        }
    }
    
    func request(page: Int) -> Observable<Any>{
         return Observable<Any>.create { (obj) -> Disposable in
            let result =  KYProvider.request(.requestHome(page)) { (value) in
                //返回数组
                obj.onNext(value)
                obj.onCompleted()
        
            }
            return Disposables.create {
                print("Disposed")
                result.cancel()
            }
        }
    }

}
