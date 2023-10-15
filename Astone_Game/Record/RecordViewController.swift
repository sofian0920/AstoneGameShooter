//
//  RecordTableViewController.swift
//  Astone_Game
//
//  Created by Софья Норина on 8.10.2023.
//

import UIKit

class RecordViewController: UIViewController {

    // MARK: - Properties
       
       let backgroundImageView = UIImageView()
       let recordTableView = UITableView()
       
       // MARK: - View Lifecycle
       
       override func viewDidLoad() {
           super.viewDidLoad()
           setUpNavigationBar()
           setUpUI()
       }
       
       // MARK: - UI Setup
       
       private func setUpNavigationBar() {
           navigationController?.isNavigationBarHidden = false
           navigationController?.navigationBar.tintColor = .black
       }
       
       private func setUpUI() {
           view.backgroundColor = .white
           addBackground()
           addRecordTable()
       }
       
       // MARK: - UI Helper Methods
    
    
    private func addBackground() {
        backgroundImageView.image = Image.background.wrappedValue
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func addRecordTable() {
        recordTableView.backgroundColor = .clear
        recordTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recordTableView)
        
        NSLayoutConstraint.activate([
            recordTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            recordTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            recordTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            recordTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        recordTableView.dataSource = self
        recordTableView.delegate = self
        recordTableView.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCell.identifier)
    }
}

extension RecordViewController: UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CherecterSettings.shared.score.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.identifier, for: indexPath) as? RecordTableViewCell else { return UITableViewCell() }
        cell.prepare(with: CherecterSettings.shared.score[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
    
