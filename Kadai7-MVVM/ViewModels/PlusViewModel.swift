//
//  PlusViewModel.swift
//  Kadai7-MVVM
//
//  Created by 近藤米功 on 2022/10/20.
//

import Foundation
import RxSwift
import RxCocoa
// MARK: - Inputs
protocol PlusViewModelInputs {
    var number1TextFieldObservable: Observable<String> { get }
    var number2TextFieldObservable: Observable<String> { get }
    var plusButtonObservable: Observable<Void> { get }
}

// MARK: - Outputs
protocol PlusViewModelOutputs {
    var calcResultPublishRelay: PublishRelay<String> { get }
}

// MARK: - Type
protocol PlusViewModelType {
    var inputs: PlusViewModelInputs { get }
    var outputs: PlusViewModelOutputs { get }
}

class PlusViewModel: PlusViewModelInputs, PlusViewModelOutputs {
    // MARK: - Inputs
    var number1TextFieldObservable: RxSwift.Observable<String>
    var number2TextFieldObservable: RxSwift.Observable<String>
    var plusButtonObservable: RxSwift.Observable<Void>

    // MARK: - Outputs
    var calcResultPublishRelay = RxRelay.PublishRelay<String>()

    // MARK: - Model Connect
    let calculator = Calculator()

    private let disposeBag = DisposeBag()

    private var number1 = Int()
    private var number2 = Int()
    private var calcResult = Int()

    init(number1TextFieldObservable: Observable<String>,number2TextFieldObservable: Observable<String>,plusButtonObservable: Observable<Void>) {
        self.number1TextFieldObservable = number1TextFieldObservable
        self.number2TextFieldObservable = number2TextFieldObservable
        self.plusButtonObservable = plusButtonObservable
        setupBindings()
    }

    private func setupBindings() {
        let totalNumberInputs = Observable.combineLatest(number1TextFieldObservable, number2TextFieldObservable)

        totalNumberInputs.subscribe { number1,number2 in
            self.number1 = Int(number1) ?? 0
            self.number2 = Int(number2) ?? 0
        }.disposed(by: disposeBag)

        plusButtonObservable.subscribe (onNext: {
            self.calcResult = self.calculator.addition(number1: self.number1, number2: self.number2)
            self.calcResultPublishRelay.accept(String(self.calcResult))
        }).disposed(by: disposeBag)
    }
}

extension PlusViewModel: PlusViewModelType {
    var inputs: PlusViewModelInputs { return self }
    var outputs: PlusViewModelOutputs { return self }
}


