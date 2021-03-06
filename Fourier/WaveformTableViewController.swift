//
//  WaveformTableViewController.swift
//  Fourier
//
//  Created by Ziyao Zhang on 3/29/18.
//  Copyright © 2018 Ziyao Zhang. All rights reserved.
//

import UIKit

public class WaveformTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    private var waveFormViewControllers = [WaveformViewController]()
    private var tableView: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return waveFormViewControllers.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let waveFormView = waveFormViewControllers[indexPath.row].view!
        let cell = tableView.dequeueReusableCell(withIdentifier: "plain") ?? UITableViewCell(style: .default, reuseIdentifier: "plain")
        cell.contentView.fillSelfWith(subView: waveFormView)
        return cell
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.Table.RowHeight
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.backgroundColor = Constants.Colors.LightGray
        self.view.backgroundColor = Constants.Colors.LightGray
        self.view.fillSelfWith(subView: tableView, insetLeft: 30, insetRight: 30, insetTop: 80, insetBottom: 80)
    }
    
    public func addWaveForm(withFrequency frequency: Int) {
        let waveFormViewController = WaveformViewController()
        waveFormViewController.mediaType = .frequency(frequency)
        waveFormViewController.titleText = String(frequency) + " Hz"
        waveFormViewController.currentFunction = FunctionGenerator.generateSineForPlotting(withFrequency: frequency)
        waveFormViewControllers.append(waveFormViewController)
    }
}
