//
//  PlusViewController.swift
//  Kadai7-MVVM
//
//  Created by 近藤米功 on 2022/10/19.
//

import UIKit
import RxSwift
import RxCocoa

class PlusViewController: UIViewController {
    // MARK: - UI Parts
    @IBOutlet private weak var number1TextField: UITextField!
    @IBOutlet private weak var number2TextField: UITextField!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var resultLabel: UILabel!

    private let disposeBag = DisposeBag()

    // MARK: - ViewModel Connect
    private lazy var plusViewModel = PlusViewModel(number1TextFieldObservable: number1TextField.rx.text.map{$0 ?? ""}.asObservable(), number2TextFieldObservable: number2TextField.rx.text.map{$0 ?? ""}.asObservable(), plusButtonObservable: plusButton.rx.tap.asObservable())

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        plusViewModel.outputs.calcResultPublishRelay.bind(to: resultLabel.rx.text).disposed(by: disposeBag)
    }
}
