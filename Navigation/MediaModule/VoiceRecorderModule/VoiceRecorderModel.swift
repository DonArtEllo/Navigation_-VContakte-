//
//  VoiceRecorderModel.swift
//  Navigation
//
//  Created by Артем on 23.02.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

protocol VoiceRecorderViewOutput {
    var onTapGoBackToMedia: () -> Void { get }
}

final class VoiceRecorderModel: VoiceRecorderViewOutput {
        
    var onShowMedia: (() -> Void)?
    
    lazy var onTapGoBackToMedia: () -> Void = { [weak self] in
        self?.onShowMedia?()
    }
    
}
