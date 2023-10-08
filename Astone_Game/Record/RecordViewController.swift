//
//  RecordTableViewController.swift
//  Astone_Game
//
//  Created by Софья Норина on 8.10.2023.
//

import UIKit

class RecordViewController: UIViewController{
    
    

    let backgroundImageView = UIImageView()
    let recordTableView = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = .white
        addBackground()
        addRecordTable()
        
    }

    private func addBackground() {
        backgroundImageView.image = Image.background.wrappedValue
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        view.layoutIfNeeded()
    }
    
    private func addRecordTable() {
        recordTableView.backgroundColor = .clear
        recordTableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(recordTableView)
        recordTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        recordTableView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor).isActive = true
        recordTableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        recordTableView.dataSource = self
        recordTableView.delegate = self
        recordTableView.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCell.identifier)
        view.layoutIfNeeded()
    }
}
extension RecordViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CherecterSettings.settingElement.score.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RecordTableViewCell.identifier, for: indexPath) as? RecordTableViewCell else { return UITableViewCell() }
        cell.prepare(with: CherecterSettings.settingElement.score[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
    

    
