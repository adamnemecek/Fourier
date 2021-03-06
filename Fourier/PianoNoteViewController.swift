//
//  PianoNoteViewController.swift
//  Fourier
//
//  Created by Ziyao Zhang on 3/31/18.
//  Copyright © 2018 Ziyao Zhang. All rights reserved.
//

import UIKit

public class PianoNoteViewController: UIViewController {

    override public func viewDidLoad() {
        super.viewDidLoad()
        let waveFormViewController = WaveformViewController()
        waveFormViewController.titleText = Constants.StringLiterals.PianoA4
        waveFormViewController.mediaType = .file(Constants.Resources.PianoNoteURL)
        waveFormViewController.currentFunction = FunctionGenerator.generatePianoA4ForPlotting()
        self.view.fillSelfWith(subView: waveFormViewController.view)
    }

}
