//
//  RXViewController.swift
//  FchKit_Example
//
//  Created by bai on 2019/5/16.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import FchKit
import BAlert



class RXViewController: UIViewController {

    let disposeBag = DisposeBag();
    var netWork1:Observable = { () -> Observable<Any> in
        let net = Observable<Any>.create { (ob) -> Disposable in
            let task =  BNetWorkingManager.sharedInstance()!.get("http://oa.fchsoft.com:8442/mobile//checkImei.json?imei=5C812611-5C10-4FD7-9880-04F84BAA6C9D", paraments: nil, complete: { (respons, error) in
                
                if let error = error {
                    print("net 1 error")
                    ob.onError(error)
                    
                }
                if let respons = respons{
                    ob.onNext(respons)
                    ob.onCompleted()
                }
                
            })
            
            return Disposables.create {
                task?.cancel();
            }
        }
        
        return net;
    }()
    var netWork2:Observable = { () -> Observable<Any> in
        let net2 = Observable<Any>.create { (ob) -> Disposable in
            let task =  BNetWorkingManager.sharedInstance()!.get("http://oa.fchsoft.com:8442/mobile//checkImei.json?imei=5C812611-5C10-4FD7-9880-04F84BAA6C9D", paraments: nil, complete: { (respons, error) in
                
                if let error = error {
                    print("net 2 error")
                    ob.onError(error)
                    
                }
                if let respons = respons{
                    ob.onNext(respons)
                    ob.onCompleted()
                }
                
            })
            
            return Disposables.create {
                task?.cancel();
            }
        }
        return net2;
    }()
    
    
    let ob1 = Observable.of("1","2","3","4")
    let ob2 = Observable.of("a","b","c","d")
    
    let placeHolderTextView: BPlaceHolderTextView = {
        let temp = BPlaceHolderTextView();
        temp.layer.borderWidth = 1;
        temp.layer.borderColor = UIColor.blue.cgColor;
        temp.font = UIFont.systemFont(ofSize: 14);
        temp.placeholder = "请输入内容";
        return temp ;
    }()
    
    let checkbox: BCheckBox = {
        let temp = BCheckBox();
        temp.setCheckImage(onImage:UIImage(named: "login_check_on")!, offImage: UIImage(named: "login_check")!);
        temp.title = "ffdfasdf"
        temp.newCount = "2";
        temp.clickBlock = {(_,_)in
            print("click")
        }
        return temp
        
    }()
    

    //MARK: MARK

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "RX";
        
        
       self.initViews()
        
        
       
        
        
        let isValid =  placeHolderTextView.rx.text.orEmpty.asObservable().map { (text) -> Bool in
            return text.count>0
        }
        
        //        let observer = checkbox.rx.isHidden;
        //        isValid.bind(to: observer).disposed(by: disposeBag);
        
        isValid.bind { (isValid) in
            self.checkbox.isHidden = !isValid
            
            }.disposed(by: disposeBag);
        
        
        
        
        
       
        
        
        
        amb()
        combineLatest();
        zip();
        concat();
        startWith();
        merge();
        
        
        
        
        
        //        net.asSingle();
        
        
        
        
        //        net.subscribe(onNext: { (rep) in
        //            print("rep")
        //        }, onError: { (error) in
        //            print(error);
        //
        //        }).disposed(by: disposeBag);
        
        
        
        
        
        
        
       
        
        
        
        
        
    }
    func initViews()  {
        self.view.addSubview(self.placeHolderTextView);
        self.placeHolderTextView.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.view.snp.bottom).offset(20);
            make.left.equalTo(self.view).offset(20);
            make.right.equalTo(self.view).offset(-20);
            make.height.equalTo(200);
            
        }
        
        self.view.addSubview(self.checkbox);
        self.checkbox.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.placeHolderTextView.snp.bottom).offset(10);
            make.width.equalTo(100);
            make.height.equalTo(40);
        }
        
        let btn = UIButton();
        btn.backgroundColor = UIColor.yellow;
        self.view.addSubview(btn);
        btn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.checkbox.snp.bottom).offset(10);
            make.width.equalTo(100);
            make.height.equalTo(40);
        }
        
        
        btn.rx.tap.subscribe(onNext: {
            BAlert.sharedInstance.makeToast(message: "btn tap");
            self.navigationController?.pushViewController(CommonViewViewController(), animated: true);
        }).disposed(by: disposeBag);
        
        
        
    }
    
    
    @objc func back()  {
        self.navigationController?.popViewController(animated: true);
    }
    
    func launch() {
        
    }
    
    //MARK: RX

    func amb() {
        
        print("-------------\(#function)-------------")
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()
        
        Observable.amb([first,second]).subscribe(onNext: { str in
            print("amb :\(str)");
        }).disposed(by: disposeBag);
        
        second.onNext("a");
        first.onNext("1");
        
        first.onNext("2");
        
        second.onNext("b");
        first.onNext("3");
        first.onNext("4");
        second.onNext("c");
        second.onNext("d");
        
        
    }
    
    func combineLatest() {
        print("-------------\(#function)-------------")
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()
        
        Observable.combineLatest(first, second) { (str1, str2) -> String in
            return str1+str2
            }.subscribe(onNext: { (str) in
                print("combineLatest:\(str)");
            }).disposed(by: disposeBag);
        
        second.onNext("a");
        first.onNext("1");
        
        first.onNext("2");
        
        second.onNext("b");
        first.onNext("3");
        first.onNext("4");
        second.onNext("c");
        second.onNext("d");
        
        
    }
    
    
    func zip()  {
        print("-------------\(#function)-------------")
        
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()
        let third = PublishSubject<Bool>()
        
        Observable.zip(first, third) { (r1, r3) -> String in
            
            return "";
        }
        Observable.zip(first, second) { (str1, str2) -> String in
            return str1+str2
            }.subscribe(onNext: { (str) in
                print("combineLatest:\(str)");
            }).disposed(by: disposeBag);
        
        second.onNext("a");
        first.onNext("1");
        
        first.onNext("2");
        
        second.onNext("b");
        first.onNext("3");
        first.onNext("4");
        second.onNext("c");
        second.onNext("d");
        
        
        //        Observable.zip(netWork1, netWork2) { result1,result2  in
        //            return (result1,result1);
        //            }.subscribe(onNext: { (zipResult) in
        //                let dic1 =  zipResult.0 as! Dictionary<String, Any>
        //                let dic2 =  zipResult.0 as! Dictionary<String, Any>
        //
        //                print("result1 is : \(dic1)");
        //                print("result2 is : \(dic2)");
        //
        //            }, onError: { (error) in
        //                print("an error happen:\(error)");
        //            }, onCompleted: {
        //                print("zip onCompleted")
        //            }).disposed(by: disposeBag)
        
        
        //任意 source 发生error后  都执行 zip onError 且只执行一次  无论其他source成功与否
        
        
    }
    
    
    func concat() {
        print("-------------\(#function)-------------")
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()
        
        first.concat(second).subscribe(onNext: { (str) in
            print("concat:\(str)")
        }).disposed(by: disposeBag)
        
        
        second.onNext("a");
        first.onNext("1");
        
        first.onNext("2");
        //        first.onCompleted();
        
        second.onNext("b");
        first.onNext("3");
        first.onNext("4");
        second.onNext("c");
        second.onNext("d");
        
        //
        
    }
    
    
    func concatMap() {
        print("-------------\(#function)-------------")
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()
        
        //
        //        first.concatMap { (str) -> ObservableConvertibleType in
        //            return str;
        //        }.sub
        //        first.concat(second).subscribe(onNext: { (str) in
        //            print("concat:\(str)")
        //        }).disposed(by: disposeBag)
        //
        //
        //        second.onNext("a");
        //        first.onNext("1");
        //
        //        first.onNext("2");
        //        //        first.onCompleted();
        //
        //        second.onNext("b");
        //        first.onNext("3");
        //        first.onNext("4");
        //        second.onNext("c");
        //        second.onNext("d");
        
        //
        
    }
    
    func connect() {
        print("-------------\(#function)-------------")
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()
        
        //        O
        //        first.concat(second).subscribe(onNext: { (str) in
        //            print("concat:\(str)")
        //        }).disposed(by: disposeBag)
        //
        //
        //        second.onNext("a");
        //        first.onNext("1");
        //
        //        first.onNext("2");
        //        //        first.onCompleted();
        //
        //        second.onNext("b");
        //        first.onNext("3");
        //        first.onNext("4");
        //        second.onNext("c");
        //        second.onNext("d");
        
        //
        
        
        
        
    }
    
    
    
    
    func startWith() {
        print("-------------\(#function)-------------")
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()
        
        
        first.startWith("0")
            .subscribe(onNext: { (str) in
                print("startWith:\(str)")
            }).disposed(by: disposeBag)
        
        
        second.onNext("a");
        first.onNext("1");
        
        first.onNext("2");
        
        second.onNext("b");
        first.onNext("3");
        first.onNext("4");
        second.onNext("c");
        second.onNext("d");
        
        
    }
    
    
    
    func merge () {
        print("-------------\(#function)-------------")
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()
        
        
        Observable.merge([first,second])
            .subscribe(onNext: { (str) in
                print("merge:\(str)")
            }).disposed(by: disposeBag)
        
        
        second.onNext("a");
        first.onNext("1");
        
        first.onNext("2");
        
        second.onNext("b");
        first.onNext("3");
        first.onNext("4");
        second.onNext("c");
        second.onNext("d");
        
        
        
        //        通过使用 merge 操作符你可以将多个 Observables 合并成一个，当某一个 Observable 发出一个元素时，他就将这个元素发出。
        //
        //        如果，某一个 Observable 发出一个 onError 事件，那么被合并的 Observable 也会将它发出，并且立即终止序列。
        
    }
    
   
    
    
    
    
    
}
