//
//  CodeAssignmentViewController.swift
//  SeSACDiary
//
//  Created by 이승후 on 2022/08/17.
//

import UIKit

final class CodeAssignmentViewController: UIViewController {
    
    private lazy var backGroundView = UIImageView()
    private lazy var cancelButton = UIButton()
    private lazy var heartButton = UIButton()
    private lazy var diceButton = UIButton()
    private lazy var settingButton = UIButton()
    private lazy var profileImage = UIImageView()
    private lazy var profileLabel = UILabel()
    private lazy var chatToMeButton = UIButton()
    private lazy var editProfileButton = UIButton()
    private lazy var moveToKakaoStoryButton = UIButton()
    private lazy var messageLabel = UILabel()
    private lazy var profileEditLabel = UILabel()
    private lazy var kakaoStroyLabel = UILabel()
    private lazy var viewCollection: [UIView] = []
    
    private let largeConfigure = UIImage.SymbolConfiguration(pointSize: 20, weight: .bold, scale: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewCollection =  [backGroundView, cancelButton, heartButton, diceButton, settingButton, profileImage, profileLabel, chatToMeButton, editProfileButton, moveToKakaoStoryButton, messageLabel, profileEditLabel, kakaoStroyLabel]
        viewCollection.forEach {
            view.addSubview($0)
            $0.tintColor = .white
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        configureView()
    }
    
    private func configureView() {
        setBackGroundViewIamge()
        setCancelButton()
        setHeartButton()
        setDiceButton()
        setSettingButton()
        setProfileImageView()
        setProfileLabel()
        setChatToMeButton()
        setEditProfileButton()
        setKaKaoStroyButton()
        setMessageLabel()
        setProfileEditLabel()
        setKakaoStoryLabel()
    }
    
    private func setBackGroundViewIamge() {
        backGroundView.backgroundColor = .darkGray
        NSLayoutConstraint.activate([
            backGroundView.heightAnchor.constraint(equalTo: view.heightAnchor),
            backGroundView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    private func setCancelButton() {
        cancelButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            cancelButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
    }
    
    private func setHeartButton() {
        heartButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        NSLayoutConstraint.activate([
            heartButton.topAnchor.constraint(equalTo: cancelButton.topAnchor),
            heartButton.trailingAnchor.constraint(equalTo: diceButton.leadingAnchor, constant: -16)
        ])
    }
    
    private func setDiceButton() {
        diceButton.setImage(UIImage(systemName: "dice"), for: .normal)
        NSLayoutConstraint.activate([
            diceButton.topAnchor.constraint(equalTo: cancelButton.topAnchor),
            diceButton.trailingAnchor.constraint(equalTo: settingButton.leadingAnchor , constant: -16)
            
        ])
    }
    
    private func setSettingButton() {
        settingButton.setImage(UIImage(systemName: "gearshape.circle"), for: .normal)
        NSLayoutConstraint.activate([
            settingButton.topAnchor.constraint(equalTo: cancelButton.topAnchor),
            settingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    private func setProfileImageView() {
        profileImage.image = UIImage(named: "profileImage")
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = 32
        profileImage.layer.borderWidth = 1
        profileImage.layer.borderColor = UIColor(white: 1, alpha: 1).cgColor
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 160),
            profileImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            profileImage.heightAnchor.constraint(equalTo: profileImage.widthAnchor)
        ])
    }
    
    private func setProfileLabel() {
        profileLabel.text = "MosonLee"
        profileLabel.textColor = .white
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8),
            profileLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setChatToMeButton() {
        let messageImage = UIImage(systemName: "message.fill", withConfiguration: largeConfigure)
        chatToMeButton.setImage(messageImage, for: .normal)
        NSLayoutConstraint.activate([
            chatToMeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            chatToMeButton.leadingAnchor.constraint(equalTo: editProfileButton.leadingAnchor, constant: -128),
        ])
    }
    
    private func setEditProfileButton() {
        let pencilImage = UIImage(systemName: "pencil", withConfiguration: largeConfigure)
        editProfileButton.setImage(pencilImage, for: .normal)
        NSLayoutConstraint.activate([
            editProfileButton.bottomAnchor.constraint(equalTo: chatToMeButton.bottomAnchor),
            editProfileButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func setKaKaoStroyButton() {
        let messageImage = UIImage(systemName: "waveform.path.ecg", withConfiguration: largeConfigure)
        moveToKakaoStoryButton.setImage(messageImage, for: .normal)
        NSLayoutConstraint.activate([
            moveToKakaoStoryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            moveToKakaoStoryButton.leadingAnchor.constraint(equalTo: editProfileButton.leadingAnchor, constant: 128),
        ])
    }
    
    private func setMessageLabel() {
        messageLabel.text = "나와의 채팅"
        messageLabel.textColor = .white
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: chatToMeButton.bottomAnchor, constant: 16),
            messageLabel.centerXAnchor.constraint(equalTo: chatToMeButton.centerXAnchor)
        ])
    }
    
    private func setProfileEditLabel() {
        profileEditLabel.text = "프로필 편집"
        profileEditLabel.textColor = .white
        NSLayoutConstraint.activate([
            profileEditLabel.topAnchor.constraint(equalTo: editProfileButton.bottomAnchor, constant: 16),
            profileEditLabel.centerXAnchor.constraint(equalTo: editProfileButton.centerXAnchor)
        ])
    }
    
    private func setKakaoStoryLabel() {
        kakaoStroyLabel.text = "카카오스토리"
        kakaoStroyLabel.textColor = .white
        NSLayoutConstraint.activate([
            kakaoStroyLabel.topAnchor.constraint(equalTo: moveToKakaoStoryButton.bottomAnchor, constant: 16),
            kakaoStroyLabel.centerXAnchor.constraint(equalTo: moveToKakaoStoryButton.centerXAnchor)
        ])
    }
}
