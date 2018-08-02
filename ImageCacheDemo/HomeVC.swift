//
//  HomeVC.swift
//  ImageCacheDemo
//
//  Created by Abhinay on 02/08/18.
//  Copyright © 2018 ONS. All rights reserved.
//

import UIKit

struct ImageRecord {
    let title:String!
    let imageUrl:String!
    var image:UIImage?
}

class HomeVC:UITableViewController
{
    
    fileprivate var dataSource = [ImageRecord]()
    fileprivate let cellId = "cellId"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        navigationItem.title = "Image Loading"
        
        setDummyData()
        setURLCacheCapacity()
        
        tableView.backgroundColor = .white
        
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        
        tableView.register(ImageCell.self, forCellReuseIdentifier: cellId)
    }
    
    fileprivate func setDummyData()
    {
        dataSource.append(ImageRecord(title: "Recipe1", imageUrl: "https://firebasestorage.googleapis.com/v0/b/varanasi-diary.appspot.com/o/VegScrambleOats.jpg?alt=media&token=40179eb5-748a-4610-8d92-637243095fa7", image: nil))
        dataSource.append(ImageRecord(title: "Recipe2", imageUrl: "https://firebasestorage.googleapis.com/v0/b/varanasi-diary.appspot.com/o/Pancakes1.jpg?alt=media&token=15244959-47e0-4609-9a50-6a252c35a48e", image: nil))
        dataSource.append(ImageRecord(title: "Recipe3", imageUrl: "https://firebasestorage.googleapis.com/v0/b/varanasi-diary.appspot.com/o/PancakesSmoothie.jpg?alt=media&token=88055871-0733-4e55-9d04-de020692be79", image: nil))
        dataSource.append(ImageRecord(title: "Recipe4", imageUrl: "https://firebasestorage.googleapis.com/v0/b/varanasi-diary.appspot.com/o/VegetableScramble1.jpg?alt=media&token=f85403e9-56d2-44eb-b73b-c1696c5a522a", image: nil))
        dataSource.append(ImageRecord(title: "Recipe5", imageUrl: "https://firebasestorage.googleapis.com/v0/b/varanasi-diary.appspot.com/o/VegetableScramble2.jpg?alt=media&token=14cbfe5e-844d-465f-9d41-fa555e3a8e41", image: nil))
       //
    }
    
    fileprivate func setURLCacheCapacity()
    {
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "ImageCacheDemo")
        URLCache.shared = urlCache
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! ImageCell
        cell.record = dataSource[indexPath.row]
        return cell
    }
}




class ImageCell:UITableViewCell
{
    var record:ImageRecord!{
        didSet{
            titleLabel.text = record.title
            imageLoader.startAnimating()
            let urlString = record.imageUrl!
            let url = URL(string: urlString)!
            URLSession.shared.dataTask(with: url, completionHandler: {[weak self] (data, response, error) in
                DispatchQueue.main.async {
                    self?.imageLoader.stopAnimating()
                }
                
                if error != nil{
                    return
                }else{
                    let image = UIImage(data: data!)
                    DispatchQueue.main.async {
                        self?.imgView.image = image
                    }
                    
                }
            }).resume()
        }
            
    }
    
    private let titleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 24.0)
        return label
    }()
    
    private let imgView:UIImageView = {
        let iv = UIImageView()
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFit
        iv.layer.borderWidth = 1.0
        iv.layer.borderColor = UIColor.lightGray.cgColor
        return iv
    }()
    
    private let imageLoader:UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imgView.image = nil
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews()
    {
        selectionStyle = .none
        addSubview(titleLabel)
        addSubview(imgView)
        addSubview(imageLoader)
        imageLoader.startAnimating()
        setLayout()
    }
    
    private func setLayout()
    {
        addConstraint(visualLF: "H:|-8-[v0]|", forViews: titleLabel)
        addConstraint(visualLF: "H:|-8-[v0]-8-|", forViews: imgView)
        addConstraint(visualLF: "V:|-8-[v0]-8-[v1(150)]-8-|", forViews: titleLabel, imgView)
        
        imageLoader.centerXAnchor.constraint(equalTo: imgView.centerXAnchor).isActive = true
        imageLoader.centerYAnchor.constraint(equalTo: imgView.centerYAnchor).isActive = true
    }
}

extension UIView
{
    func addConstraint(visualLF format:String, forViews views:UIView...)
    {
        var dict = [String:UIView]()
        for (index, view) in views.enumerated()
        {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            dict[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: dict))
    }
}
