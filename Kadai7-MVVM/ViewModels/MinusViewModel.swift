//
//  MinusViewModel.swift
//  Kadai7-MVVM
//
//  Created by 近藤米功 on 2022/10/20.
//

import Foundation
import RxSwift
import RxCocoa
// MARK: - Inputs
protocol MinusViewModelInputs {
    var number1TextFieldObservable: Observable<String> { get }
    var number2TextFieldObservable: Observable<String> { get }
    var minusButtonObservable: Observable<Void> { get }
}
// MARK: - Outputs
protocol MinusViewModelOutputs {
    var calcResultPublishRelay: PublishRelay<String> { get }
}

// MARK: - Type
protocol MinusViewModelType {
    var inputs: MinusViewModelInputs { get }
    var outputs: MinusViewModelOutputs { get }
}

class MinusViewModel: MinusViewModelInputs,MinusViewModelOutputs {
    // MARK: - Inputs
    var number1TextFieldObservable: RxSwift.Observable<String>
    var number2TextFieldObservable: RxSwift.Observable<String>
    var minusButtonObservable: RxSwift.Observable<Void>
    // MARK: - Outputs
    var calcResultPublishRelay = RxRelay.PublishRelay<String>()

    // MARK: - Model Connect
    let calculator = Calculator()

    private let disposeBag = DisposeBag()

    private var number1 = Int()
    private var number2 = Int()
    private var calcResult = Int()

    init(number1TextFieldObservable: Observable<String>,number2TextFieldObservable: Observable<String>,minusButtonObservable: Observable<Void>) {
        self.number1TextFieldObservable = number1TextFieldObservable
        self.number2TextFieldObservable = number2TextFieldObservable
        self.minusButtonObservable = minusButtonObservable
        setupBindings()
    }

    private func setupBindings() {
        let totalNumberInputs = Observable.combineLatest(number1TextFieldObservable, number2TextFieldObservable)

        totalNumberInputs.subscribe { number1,number2 in
            self.number1 = Int(number1) ?? 0
            self.number2 = Int(number2) ?? 0
        }.disposed(by: disposeBag)

        minusButtonObservable.subscribe (onNext: {
            self.calcResult = self.calculator.subtraction(number1: self.number1, number2: self.number2)
            self.calcResultPublishRelay.accept(String(self.calcResult))
        }).disposed(by: disposeBag)
    }

}

// MARK: - MinusViewModelType
extension MinusViewModel: MinusViewModelType {
    var inputs: MinusViewModelInputs { return self }

    var outputs: MinusViewModelOutputs { return self }
}
