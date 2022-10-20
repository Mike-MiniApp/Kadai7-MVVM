//
//  MinusViewController.swift
//  Kadai7-MVVM
//
//  Created by 近藤米功 on 2022/10/19.
//

import UIKit
import RxSwift
import RxCocoa

class MinusViewController: UIViewController {
    // MARK: - UI Parts
    @IBOutlet private weak var number1TextField: UITextField!
    @IBOutlet private weak var number2TextField: UITextField!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var calcResultLabel: UILabel!

    private let disposeBag = DisposeBag()

    private lazy var minusViewModel = MinusViewModel(number1TextFieldObservable: number1TextField.rx.text.map{$0 ?? ""}.asObservable(), number2TextFieldObservable: number2TextField.rx.text.map{$0 ?? ""}.asObservable(), minusButtonObservable: minusButton.rx.tap.asObservable())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        minusViewModel.outputs.calcResultPublishRelay.bind(to: calcResultLabel.rx.text).disposed(by: disposeBag)
    }

}
