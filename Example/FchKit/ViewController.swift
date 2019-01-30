//
//  ViewController.swift
//  FchKit
//
//  Created by february29 on 10/31/2018.
//  Copyright (c) 2018 february29. All rights reserved.
//

import UIKit
import FchKit
import BAlert
import RxSwift
import RxCocoa



class ViewController: UIViewController {
    
    
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
    
    let scrollerView: BAutoHeightScrollView = {
        let temp = BAutoHeightScrollView();
        return temp
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
    
    let rightViewTF: BRightViewTextField = {
        let temp = BRightViewTextField();
        temp.rightImageView.image = UIImage(named: "login_check_on");
        temp.layer.borderWidth = 1;
        temp.layer.borderColor = UIColor.blue.cgColor;
      
        temp.rightImageView.snp.remakeConstraints({ (make) in
            make.centerY.equalTo(temp);
            make.right.equalTo(temp);
            make.width.height.equalTo(20);
            
        })
        temp.clickBlock = {(textField)in
            print("click")
            
//            let view = BPromptView(title: "客服哦", message: "法拉利短裤", okBtnTitle: "我知道了", cancelBtnTitle: nil, image: nil)
            let view = BPromptView(title: "客服哦", message: "法拉利短裤", okBtnTitle: "我知道了", cancelBtnTitle: "取消", image: nil)
            view.okButtonClickBlock = {()in
                BAlert.sharedInstance.hide(view: view);
            }
        
//            view.frame = CGRect(x: 0, y: 0, width: 350, height: 300);
            BAlert.sharedInstance.normalShow(view: view)
            
        }
        
        
       
        
        return temp;
    }()
    
    let inforView: BInfoView = {
        let temp = BInfoView.init(style: BInfoViewStyle.BInfoViewHorizontal);
//        let temp = BInfoView.init(style: BInfoViewStyle.BInfoViewvertical);
        
        temp.promptLabel.text = "name:"
        temp.infoLabel.text = "999000\ndd99hjjfkk-----------------------------------kkkkkkk";
        return temp ;
    }()
    
    let placeHolderTextView: BPlaceHolderTextView = {
        let temp = BPlaceHolderTextView();
        temp.layer.borderWidth = 1;
        temp.layer.borderColor = UIColor.blue.cgColor;
        temp.font = UIFont.systemFont(ofSize: 14);
        temp.placeholder = "请输入内容";
        return temp ;
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        print(Date().toString())
        
//        BDateTool.sharedInstance.timeIntervalSince1970FromDate(date: <#T##Date#>)
        
//        BStringTool.trimNil(str: <#T##String?#>)
        
//        BNetWorkingManager.sharedInstance()?.baseURL = "http://124.88.168.158:8098"
//        BNetWorkingManager.sharedInstance()?.get("backend/web/risk/control/preset/lists", paraments: nil, complete: { (respons, error) in
//            print(respons);
//        })
       let c =  #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        self.view.backgroundColor = c;

        self.view.addSubview(self.scrollerView);
        
        self.scrollerView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view);
        }
        
        
        //navigationBar 被所有vc共享
        self.navigationController?.navigationBar.barTintColor = UIColor.yellow;
       
        //每个 VC 有一个 UIBarButtonItem 设置以后显示d到navigationBar上
        let left = UIBarButtonItem.init(image: UIImage.init(color: UIColor.purple), style: .plain, target: self, action: #selector(back));
        self.navigationItem.leftBarButtonItem = left;
        
        let  bar = self.navigationController?.navigationBar
        let item = self.navigationItem
        
        let tf = UITextField();
        tf.setPlaceHolder(placeHolder: "ddd", color: UIColor.purple);
        self.scrollerView.contentView.addSubview(tf);
        tf.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.scrollerView.contentView);
            make.top.equalTo(self.scrollerView.contentView).offset(100);
            make.width.equalTo(100);
            make.height.equalTo(40);
        }
        
       
        
        
        
        
        
//        btn.rx.tap
//            .subscribe(onNext: {
//                print("button Tapped")
//            })
//            .disposed(by: disposeBag)
        
       
        self.scrollerView.contentView.addSubview(self.checkbox)
        self.checkbox.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.scrollerView.contentView);
            make.top.equalTo(self.scrollerView.contentView).offset(200);
            make.width.equalTo(100);
            make.height.equalTo(40);
        }
        
        self.scrollerView.contentView.addSubview(self.rightViewTF);
        self.rightViewTF.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.scrollerView.contentView);
            make.top.equalTo(self.checkbox.snp.bottom).offset(20);
            make.width.equalTo(100);
            make.height.equalTo(40);
        }
        
        
        self.scrollerView.contentView.addSubview(self.inforView);
        self.inforView.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.rightViewTF.snp.bottom).offset(20);
            make.left.equalTo(self.scrollerView.contentView).offset(20);
            make.right.equalTo(self.scrollerView.contentView).offset(-20);
            make.bottom.equalTo(self.inforView.infoLabel);
           
        }
        
        self.scrollerView.contentView.addSubview(self.placeHolderTextView);
        self.placeHolderTextView.snp.makeConstraints { (make) in
            
            make.top.equalTo(self.inforView.snp.bottom).offset(20);
            make.left.equalTo(self.scrollerView.contentView).offset(20);
            make.right.equalTo(self.scrollerView.contentView).offset(-20);
            make.height.equalTo(200);
            
        }
        
        
        
        
        //=======================RX======================
        
        let btn = UIButton();
        btn.backgroundColor = UIColor.yellow;
        self.view.addSubview(btn);
        btn.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.scrollerView.contentView);
            make.top.equalTo(placeHolderTextView.snp.bottom).offset(10);
            make.width.equalTo(100);
            make.height.equalTo(40);
        }
        
        
        btn.rx.tap.subscribe(onNext: {
            BAlert.sharedInstance.makeToast(message: "btn tap");
            self.navigationController?.pushViewController(ViewController2(), animated: true);
        }).disposed(by: disposeBag);
        
        
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
        
       
        
        
        
        
        
        self.scrollerView.setBottomView(view:self.placeHolderTextView);
        
        
        
        
        
    }
    
   
    @objc func back()  {
        self.navigationController?.popViewController(animated: true);
    }
    
    func launch() {
        
    }
    
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    
    
    
    

}

