//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import StorageService

final class FeedViewController: UIViewController {
    
    let post: Post = Post(title: "Пост")
    weak var coordinator: FeedCoordinator?
    
    init(viewModel: FeedModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        print(type(of: self), #function)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(type(of: self), #function)
        
        removeObservers()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(type(of: self), #function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(type(of: self), #function)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "post" else {
            return
        }
        guard let postViewController = segue.destination as? PostViewController else {
            return
        }
        postViewController.post = post
    }
    
    lazy var firtsStackViewButton: UIButton = {
        let fButton = UIButton()
        
        return fButton
    }()

    // MARK: - Feed Page Content
    var viewModel: FeedModel?
    
    // Background fader for animation
    private var fullscreenBackgroundView: UIView = {
        let fullscreenBackgroundView = UIView()
        fullscreenBackgroundView.backgroundColor = .black
        fullscreenBackgroundView.alpha = 0
        
        fullscreenBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        return fullscreenBackgroundView
    }()
    
    // Button for checking word
    private lazy var checkerButton: UpgradedButton  = {
        let button = UpgradedButton(titleText: "Check", titleColor: .white, backgroundColor: .gray, tapAction: self.actionSetStatusButtonPressed)
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.black, for: .highlighted)
        
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.masksToBounds = true
        
        return button
    }()
    
    // Textfield for word to be checked
    private lazy var secretwordTextField: UpgradedTextField = {
        let secretwordTextField = UpgradedTextField(placeholder: "Place for password to be checked", onText: self.secretwordTextFieldChanged)
        secretwordTextField.font = UIFont.systemFont(ofSize: 15)
        secretwordTextField.leftView = UIView(frame:
                                            CGRect(
                                                x: 0,
                                                y: 0,
                                                width: 10,
                                                height: 40
                                            )
        )
            
        secretwordTextField.layer.cornerRadius = 12
        secretwordTextField.layer.borderWidth = 1
        secretwordTextField.layer.borderColor = UIColor.white.cgColor
    
        return secretwordTextField
    }()
    
    // Result label
    private var resultLabel: UILabel = {
        let resultLabel = UILabel()
        resultLabel.font = UIFont.boldSystemFont(ofSize: 10)
        resultLabel.numberOfLines = 0
        resultLabel.textColor = .black
        resultLabel.backgroundColor = .systemGray3
        resultLabel.textAlignment = .center
        resultLabel.alpha = 0
        
        resultLabel.layer.cornerRadius = 20
        resultLabel.layer.borderWidth = 1
        resultLabel.layer.borderColor = UIColor.black.cgColor
        resultLabel.layer.masksToBounds = true
        
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
        return resultLabel
    }()
    
    private lazy var funnyPictureButton: UpgradedButton = {
        let button = UpgradedButton(titleText: "Don't be sad", titleColor: .black, backgroundColor: .yellow, tapAction: self.actionFunnyPictureButtonPressed)
        button.setTitleColor(.black, for: .selected)
        button.setTitleColor(.black, for: .highlighted)
        
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.masksToBounds = true
        
        return button
    }()
    
    // MARK: - Functions
    // MARK: Setup
    func setup() {

        addObrervers()
        
        view.backgroundColor = .systemGreen

        view.addSubviews(
            checkerButton,
            funnyPictureButton,
            secretwordTextField,
            fullscreenBackgroundView,
            resultLabel
        )
        
        fullscreenBackgroundView.frame = .init(
            x: 0,
            y: 0,
            width: view.bounds.width,
            height: view.bounds.height
        )

        // Constraints
        let constraints = [
            checkerButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            checkerButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -50),
            checkerButton.widthAnchor.constraint(equalToConstant: 100),
            
            funnyPictureButton.centerXAnchor.constraint(equalTo: checkerButton.centerXAnchor),
            funnyPictureButton.centerYAnchor.constraint(equalTo: checkerButton.centerYAnchor, constant: 50),
            funnyPictureButton.widthAnchor.constraint(equalToConstant: 200),
            
            secretwordTextField.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            secretwordTextField.centerYAnchor.constraint(equalTo: checkerButton.topAnchor, constant: -25),
            secretwordTextField.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.75),
            secretwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            resultLabel.centerXAnchor.constraint(equalTo: secretwordTextField.centerXAnchor),
            resultLabel.centerYAnchor.constraint(equalTo: secretwordTextField.centerYAnchor),
            resultLabel.heightAnchor.constraint(equalToConstant: 50),
            resultLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.25)
            
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: Actions
    private func actionSetStatusButtonPressed() {
        secretwordTextField.endEditing(true)
        
        if secretwordTextField.text != nil && secretwordTextField.text?.count != 0 {
            print("Password sent to server")
            viewModel?.check(word: secretwordTextField.text!)
        }
    }
    
    private func actionFunnyPictureButtonPressed() {
        viewModel?.onTapShowFunnyPicture()
    }
    
    private func secretwordTextFieldChanged(_: String) {
        print("Some password has been typed")
    }
    
    @objc func trueSelector() {
        print("Password is true")
        
        resultLabel.text = "You've done well!"
        resultLabel.textColor = .green
        
        resultLabel.layer.borderColor = UIColor.green.cgColor
        
        resultAnimation()
    }

    @objc func falseSelector() {
        print("Password is false")
        
        resultLabel.text = "Wrong! Try again."
        resultLabel.textColor = .red
        
        resultLabel.layer.borderColor = UIColor.red.cgColor
        
        resultAnimation()
    }
    
    // MARK: Observers
    // Add
    func addObrervers() {
        NotificationCenter.default.addObserver(self, selector: #selector(trueSelector), name: NSNotification.Name(rawValue: "Word is correct") , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(falseSelector), name: NSNotification.Name(rawValue: "Word is not correct") , object: nil)
    
    }
    
    // Remove
    func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Word is correct"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "Word is not correct"), object: nil)
    }
    
    // MARK: - Animations
    func resultAnimation() {
        // Appering animation
        let xScaleAppearAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        xScaleAppearAnimation.fromValue = 1
        xScaleAppearAnimation.toValue = 2

        let yScaleAppearAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        yScaleAppearAnimation.fromValue = 1
        yScaleAppearAnimation.toValue = 2
        
        let resultAppearAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        resultAppearAlphaAnimation.fromValue = 0
        resultAppearAlphaAnimation.toValue = 1
        
        let appearGroupForResult = CAAnimationGroup()
        appearGroupForResult.animations = [xScaleAppearAnimation, yScaleAppearAnimation, resultAppearAlphaAnimation]

        appearGroupForResult.duration = 0.25
        appearGroupForResult.isRemovedOnCompletion = true
        appearGroupForResult.fillMode = .forwards

        resultLabel.layer.add(appearGroupForResult, forKey: "result appear animation")
        
        let backgroundAppearAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        backgroundAppearAlphaAnimation.fromValue = 0
        backgroundAppearAlphaAnimation.toValue = 0.5
        
        let appearGroupForBackground = CAAnimationGroup()
        appearGroupForBackground.animations = [backgroundAppearAlphaAnimation]
        
        appearGroupForBackground.duration = 0.25
        appearGroupForBackground.isRemovedOnCompletion = true
        appearGroupForBackground.fillMode = .forwards
        
        fullscreenBackgroundView.layer.add(appearGroupForBackground, forKey: "background appear animation")
        
        // Static animation
        let xScaleShowAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        xScaleShowAnimation.fromValue = 2
        xScaleShowAnimation.toValue = 2

        let yScaleShowAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        yScaleShowAnimation.fromValue = 2
        yScaleShowAnimation.toValue = 2
        
        let resultShowAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        resultShowAlphaAnimation.fromValue = 1
        resultShowAlphaAnimation.toValue = 1
        
        let showGroupForResult = CAAnimationGroup()
        showGroupForResult.animations = [xScaleShowAnimation, yScaleShowAnimation, resultShowAlphaAnimation]

        showGroupForResult.beginTime = CACurrentMediaTime() + 0.25
        showGroupForResult.duration = 0.5
        showGroupForResult.isRemovedOnCompletion = true
        showGroupForResult.fillMode = .forwards

        resultLabel.layer.add(showGroupForResult, forKey: "result static animation")
        
        let backgroundShowAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        backgroundShowAlphaAnimation.fromValue = 0.5
        backgroundShowAlphaAnimation.toValue = 0.5
        
        let showGroupForBackground = CAAnimationGroup()
        showGroupForBackground.animations = [backgroundShowAlphaAnimation]
        
        showGroupForBackground.beginTime = CACurrentMediaTime() + 0.25
        showGroupForBackground.duration = 0.5
        showGroupForBackground.isRemovedOnCompletion = true
        showGroupForBackground.fillMode = .forwards
        
        fullscreenBackgroundView.layer.add(showGroupForBackground, forKey: "background static animation")
    
        // Dissappearing animation
        let xScaleDissappearAnimation = CABasicAnimation(keyPath: "transform.scale.x")
        xScaleDissappearAnimation.fromValue = 2
        xScaleDissappearAnimation.toValue = 1

        let yScaleDissappearAnimation = CABasicAnimation(keyPath: "transform.scale.y")
        yScaleDissappearAnimation.fromValue = 2
        yScaleDissappearAnimation.toValue = 1
        
        let resultDissappearAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        resultDissappearAlphaAnimation.fromValue = 1
        resultDissappearAlphaAnimation.toValue = 0
        
        let dissappearGroupForResult = CAAnimationGroup()
        dissappearGroupForResult.animations = [xScaleDissappearAnimation, yScaleDissappearAnimation, resultDissappearAlphaAnimation]

        dissappearGroupForResult.beginTime = CACurrentMediaTime() + 0.75
        dissappearGroupForResult.duration = 0.25
        dissappearGroupForResult.isRemovedOnCompletion = true
        dissappearGroupForResult.fillMode = .removed

        resultLabel.layer.add(dissappearGroupForResult, forKey: "result dissappear animation")
        
        let backgroundDissappearAlphaAnimation = CABasicAnimation(keyPath: "opacity")
        backgroundDissappearAlphaAnimation.fromValue = 0.5
        backgroundDissappearAlphaAnimation.toValue = 0
        
        let dissappearGroupForBackground = CAAnimationGroup()
        dissappearGroupForBackground.animations = [backgroundDissappearAlphaAnimation]
        
        dissappearGroupForBackground.beginTime = CACurrentMediaTime() + 0.75
        dissappearGroupForBackground.duration = 0.25
        dissappearGroupForBackground.isRemovedOnCompletion = true
        dissappearGroupForBackground.fillMode = .forwards
        
        fullscreenBackgroundView.layer.add(dissappearGroupForBackground, forKey: "background dissappear animation")
    }
}
