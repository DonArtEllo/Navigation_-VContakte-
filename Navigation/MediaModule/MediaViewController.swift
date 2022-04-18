//
//  MediaViewController.swift
//  Navigation
//
//  Created by Артем on 23.02.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class MediaViewController: UIViewController {
    
    private var viewModel: MediaViewOutput
    private var player = AVAudioPlayer()
    private var currentSong = 0
    
    private let videosTableView = UITableView(frame: .zero, style: .grouped)
    
    private var previousTrackButton: UIButton = {
        let previousTrackButton = UIButton()
        previousTrackButton.contentMode = .scaleToFill
        previousTrackButton.tintColor = .black
            
        previousTrackButton.setImage(UIImage.init(systemName: "backward.end.alt.fill"), for: .normal)
        
        previousTrackButton.addTarget(self, action: #selector(tapOnPrevSongButton), for: .touchUpInside)
        previousTrackButton.translatesAutoresizingMaskIntoConstraints = false
        return previousTrackButton
    }()
    
    private var pauseButton: UIButton = {
        let pauseButton = UIButton()
        pauseButton.contentMode = .scaleToFill
        pauseButton.tintColor = .black
            
        pauseButton.setImage(UIImage.init(systemName: "pause.fill"), for: .normal)
        
        pauseButton.addTarget(self, action: #selector(tapOnPauseButton), for: .touchUpInside)
        pauseButton.translatesAutoresizingMaskIntoConstraints = false
        return pauseButton
    }()
    
    private var playButton: UIButton = {
        let playButton = UIButton()
        playButton.contentMode = .scaleToFill
        playButton.tintColor = .black
            
        playButton.setImage(UIImage.init(systemName: "play.fill"), for: .normal)

        playButton.addTarget(self, action: #selector(tapOnPlayButton), for: .touchUpInside)
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    }()
    
    private var stopButton: UIButton = {
        let stopButton = UIButton()
        stopButton.contentMode = .scaleToFill
        stopButton.tintColor = .black
            
        stopButton.setImage(UIImage.init(systemName: "stop.fill"), for: .normal)
        
        stopButton.addTarget(self, action: #selector(tapOnStopButton), for: .touchUpInside)
        stopButton.translatesAutoresizingMaskIntoConstraints = false
        return stopButton
    }()
    
    private var nextTrackButton: UIButton = {
        let nextTrackButton = UIButton()
        nextTrackButton.contentMode = .scaleToFill
        nextTrackButton.tintColor = .black
            
        nextTrackButton.setImage(UIImage.init(systemName: "forward.end.alt.fill"), for: .normal)
        
        nextTrackButton.addTarget(self, action: #selector(tapOnNextSongButton), for: .touchUpInside)
        nextTrackButton.translatesAutoresizingMaskIntoConstraints = false
        return nextTrackButton
    }()
    
    private let songNameLabel: UILabel = {
        let songNameLabel = UILabel()
        songNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        songNameLabel.numberOfLines = 0
        songNameLabel.textColor = .black
        songNameLabel.backgroundColor = .systemGray3
        songNameLabel.textAlignment = .center
        
        songNameLabel.text = "Song Name"
        
        songNameLabel.translatesAutoresizingMaskIntoConstraints = false
        return songNameLabel
    }()
    
    private lazy var voiceRecorderButton: UpgradedButton = {
        let voiceRecorderButton = UpgradedButton(titleText: "Open Voice Recorder", titleColor: .red, backgroundColor: .gray, tapAction: self.actionVoiceRecorderButtonPressed)

        voiceRecorderButton.layer.cornerRadius = 10
        voiceRecorderButton.layer.borderWidth = 1
        voiceRecorderButton.layer.borderColor = UIColor.red.cgColor
        voiceRecorderButton.layer.masksToBounds = true
        
        return voiceRecorderButton
    }()

    // MARK: - Init
    init(viewModel: MediaViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        prepareSong()
        setupConstraints()
        setupTableView()

    }
    
    // MARK: Setup Constraints
    private func setupConstraints() {
        videosTableView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubviews(
            previousTrackButton,
            pauseButton,
            playButton,
            stopButton,
            nextTrackButton,
            videosTableView,
            songNameLabel,
            voiceRecorderButton
        )
        
        let constraints = [
            videosTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            videosTableView.heightAnchor.constraint(equalToConstant: 250),
            videosTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            videosTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            
            songNameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            songNameLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 150),
            songNameLabel.heightAnchor.constraint(equalToConstant: 50),
            songNameLabel.widthAnchor.constraint(equalToConstant: 100),
            
            playButton.centerXAnchor.constraint(equalTo: songNameLabel.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: songNameLabel.centerYAnchor, constant: 75),
            playButton.heightAnchor.constraint(equalToConstant: 60),
            playButton.widthAnchor.constraint(equalToConstant: 60),
            
            pauseButton.centerXAnchor.constraint(equalTo: playButton.centerXAnchor, constant: -60),
            pauseButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            pauseButton.heightAnchor.constraint(equalToConstant: 60),
            pauseButton.widthAnchor.constraint(equalToConstant: 60),
            
            stopButton.centerXAnchor.constraint(equalTo: playButton.centerXAnchor, constant: 60),
            stopButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            stopButton.heightAnchor.constraint(equalToConstant: 60),
            stopButton.widthAnchor.constraint(equalToConstant: 60),
            
            previousTrackButton.centerXAnchor.constraint(equalTo: pauseButton.centerXAnchor, constant: -60),
            previousTrackButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            previousTrackButton.heightAnchor.constraint(equalToConstant: 60),
            previousTrackButton.widthAnchor.constraint(equalToConstant: 60),
            
            nextTrackButton.centerXAnchor.constraint(equalTo: stopButton.centerXAnchor, constant: 60),
            nextTrackButton.centerYAnchor.constraint(equalTo: playButton.centerYAnchor),
            nextTrackButton.heightAnchor.constraint(equalToConstant: 60),
            nextTrackButton.widthAnchor.constraint(equalToConstant: 60),
            
            voiceRecorderButton.centerXAnchor.constraint(equalTo: videosTableView.centerXAnchor),
            voiceRecorderButton.topAnchor.constraint(equalTo: videosTableView.bottomAnchor, constant: 25),
            voiceRecorderButton.heightAnchor.constraint(equalToConstant: 50),
            voiceRecorderButton.widthAnchor.constraint(equalToConstant: 250)
        ]
        
        NSLayoutConstraint.activate(constraints)

    }
    
    private func setupTableView() {
        videosTableView.register(VideosTableViewCell.self, forCellReuseIdentifier: String(describing: VideosTableViewCell.self))
        
        videosTableView.dataSource = self
        videosTableView.delegate = self
    }
    
    private func prepareSong() {
        do {
            player = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: viewModel.songsURLs[currentSong], ofType: "mp3")!))
            player.prepareToPlay()
            songNameLabel.text = viewModel.songsURLs[currentSong]
        }
        catch {
            print(error)
        }
    }
    
    // Tap on Play
    @objc private func tapOnPlayButton() {
        player.play()
    }

    // Tap on Stop
    @objc private func tapOnStopButton() {
        if player.isPlaying {
            player.stop()
            player.currentTime = 0
        }
        else {
            player.currentTime = 0
        }
    }
    
    // Tap on Pause
    @objc private func tapOnPauseButton() {
        if player.isPlaying {
            player.stop()
        }
        else {
            print("Already paused!")
        }
    }
    
    // Tap on Next Song
    @objc private func tapOnNextSongButton() {
        player.stop()
        currentSong += 1
        if currentSong == 6 {
            currentSong = 0
        }
        prepareSong()
        print(currentSong)
    }
    
    // Tap on Previous Song
    @objc private func tapOnPrevSongButton() {
        player.stop()
        currentSong -= 1
        if currentSong == -1 {
            currentSong = 5
        }
        prepareSong()
        print(currentSong)
    }
    
    // Tap to open Voice Recorder View Controller
    private func actionVoiceRecorderButtonPressed() {
        viewModel.onTapShowVoiceRecorder()
    }
}

// MARK: - Extensions
extension MediaViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.videosURLs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let videosTableViewCell = tableView.dequeueReusableCell(withIdentifier:  String(describing: VideosTableViewCell.self), for: indexPath) as! VideosTableViewCell
        
        return videosTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let player = AVPlayer(url: URL(fileURLWithPath: viewModel.videosURLs[indexPath.row]))

        let controller = AVPlayerViewController()
        controller.player = player

        present(controller, animated: true) {
            player.play()
        }
    }
    
}
