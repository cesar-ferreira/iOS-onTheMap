//
//  TableViewController.swift
//  onTheMap
//
//  Created by César Ferreira on 17/04/21.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet weak var myTableView: UITableView!

    var mock = ["teste 1","teste 2", "teste 3","teste 4", "teste 5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        myTableView.register(MyTableViewCell.nib(), forCellReuseIdentifier: MyTableViewCell.reuseIdentifier)

        myTableView.delegate = self
        myTableView.dataSource = self
    }

    @objc func addLocationTapped() {
        print("add location tapped")
    }

    @objc func refreshTapped() {
        print("refresh tapped")
    }

    private func setupNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(addLocationTapped))
        let addLocation = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLocationTapped))
        navigationItem.rightBarButtonItems = [addLocation]


        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "reload", style: .plain, target: self, action: #selector(refreshTapped))
        let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTapped))
        navigationItem.rightBarButtonItems = [refresh]
    }
}

extension TableViewController: UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
//        self.showEmptyView(isVisible: (memes?.count ?? 0 == 0))
//        return memes?.count ?? 0
        return 1
    }

}

extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mock.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let meme = memes?[indexPath.row]
//
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MemeDetailsViewController") as! MemeDetailsViewController
//        newViewController.image = meme!.memedImage
//
//        self.present(newViewController, animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: MyTableViewCell.reuseIdentifier, for: indexPath) as! MyTableViewCell

        cell.nameLabel.text = mock[indexPath.row]
//        let meme = memes?[indexPath.row]
//
//        cell.memedImage.image = (meme?.memedImage)!
//        cell.topLabel.text = meme?.bottomText
//        cell.bottomLabel.text = meme?.bottomText

        return cell
    }
}

