//
//  VoiceRecorderViewController.swift
//  Navigation
//
//  Created by Артем on 23.02.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit
import AVFoundation

class VoiceRecorderViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate {
    
    private var viewModel: VoiceRecorderViewOutput
    private var recordingSession: AVAudioSession!
    private var audioRecorder: AVAudioRecorder!
    private var player = AVAudioPlayer()
    
    private lazy var recordButton: UpgradedButton = {
        let recordButton = UpgradedButton(titleText: "Tap to Record", titleColor: .white, backgroundColor: .red, tapAction: self.recordTapped)
       
        recordButton.layer.cornerRadius = 10
        recordButton.layer.borderWidth = 1
        recordButton.layer.borderColor = UIColor.black.cgColor
        recordButton.layer.masksToBounds = true
        
        return recordButton
    }()
    
    private lazy var playRecordButton: UpgradedButton = {
        let playRecordButton = UpgradedButton(titleText: "Play Recorded Audio", titleColor: .black, backgroundColor: .white, tapAction: self.playRecord)
       
        playRecordButton.layer.cornerRadius = 10
        playRecordButton.layer.borderWidth = 1
        playRecordButton.layer.borderColor = UIColor.black.cgColor
        playRecordButton.layer.masksToBounds = true
        
        return playRecordButton
    }()
    
    // MARK: - Init
    init(viewModel: VoiceRecorderViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkForPermission()
        setupViews()
        prepareRecorder()
    }
    
    func setupViews() {
        view.backgroundColor = .systemGray6

        view.addSubviews(
            recordButton,
            playRecordButton
        )
        
        let constraints = [
            recordButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            recordButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            recordButton.heightAnchor.constraint(equalToConstant: 60),
            recordButton.widthAnchor.constraint(equalToConstant: 300),
            
            playRecordButton.centerXAnchor.constraint(equalTo: recordButton.centerXAnchor),
            playRecordButton.centerYAnchor.constraint(equalTo: recordButton.centerYAnchor, constant: 90),
            playRecordButton.heightAnchor.constraint(equalToConstant: 60),
            playRecordButton.widthAnchor.constraint(equalToConstant: 300)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func checkForPermission() {
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio) { success in
                print(success)
            }
        case .authorized:
            print("Voice access authorized")
        default:
            break
        }
    }
    
    func prepareRecorder() {
        recordingSession = AVAudioSession.sharedInstance()

        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        // failed to record!
                    }
                }
            }
        } catch {
            // failed to record!
            print(error)
        }
    }
    
    func prepareRecordPlayer() {
        do {
            player = try AVAudioPlayer(contentsOf: getDocumentsDirectory().appendingPathComponent("recording.m4a"))
            player.prepareToPlay()
            player.delegate = self
        } catch {
            print(error)
        }
    }
    
    func loadRecordingUI() {

    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()

            recordButton.setTitle("Tap to Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil

        if success {
            recordButton.setTitle("Tap to Re-record", for: .normal)
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
            // recording failed :(
        }
    }
    
    @objc func recordTapped() {
        player.stop()
        player.currentTime = 0
        playRecordButton.backgroundColor = .white

        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    @objc func playRecord() {
        if player.isPlaying {
            player.stop()
            player.currentTime = 0
            playRecordButton.backgroundColor = .white
        } else {
            prepareRecordPlayer()
            player.play()
            playRecordButton.backgroundColor = .green
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}

