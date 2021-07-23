//
//  PhotosCollectionVC.swift
//  PhotoTaps
//
//  Created by Владимир on 19.07.2021.
//

import UIKit

class PhotosCollectionVC: UICollectionViewController {
    let photos = ["dog1", "dog2", "dog3", "dog4", "dog5", "dog6", "dog7", "dog8", "dog9", "dog10"]
    
    var itemsPerRow: CGFloat = 2
    let sectionInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    
    
    
    var segment = UISegmentedControl()
    @objc func switchToDuoView(_ sender: UISegmentedControl) {
        switch (segment.selectedSegmentIndex) {
        case 0:
         itemsPerRow = 2
         print(itemsPerRow)
        case 1:
         itemsPerRow = 1
         print(itemsPerRow)
        default:
            break;
        }
        self.collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //create a button or any UIView and add to subview
        let solorect = UIImage(systemName: "rectangle.fill")
        let duorect = UIImage(systemName: "rectangle.grid.2x2.fill")
        
        segment = UISegmentedControl.init(items: [duorect!, solorect!])
        segment.selectedSegmentIndex = 0
        segment.backgroundColor = .systemGroupedBackground
        segment.selectedSegmentTintColor = UIColor(named: "ControlColorForSegment")
        segment.addTarget(self, action: #selector(switchToDuoView), for: .valueChanged)
        self.view.addSubview(segment)

        //set constrains
        segment.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            segment.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -145).isActive = true
             segment.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        } else {
            segment.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: 0).isActive = true
             segment.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -10).isActive = true
        }
//        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
//
//        let itemsPerRow: CGFloat = 2
//        let paddingWith: CGFloat = 20  * (itemsPerRow + 1) //общая ширина отступов
//        let availableWith: CGFloat = collectionView.frame.width - paddingWith //доступн. ширина
//        let widthOfItem: CGFloat = availableWit h / itemsPerRow //ширина каждого объекта
//        layout.itemSize = CGSize(width: widthOfItem, height: widthOfItem)
//
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//        layout.minimumLineSpacing = 20
//        layout.minimumInteritemSpacing = 20
//
//        collectionView.showsVerticalScrollIndicator = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "touchPhotoSegue" else { return }
        let photoVC = segue.destination as! PhotoVC
        let cell = sender as! CellVC
        photoVC.image = cell.dogImageView.image
    }
    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! CellVC
        let image = UIImage(named: photos[indexPath.item])
        cell.dogImageView.image = image
        cell.contentView.layer.cornerRadius = 30.0;
        cell.contentView.layer.masksToBounds = true

        cell.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.layer.shadowRadius = 2.0
        cell.layer.shadowOpacity = 0.4
        cell.layer.masksToBounds = false
        return cell
    }

    

}

    extension PhotosCollectionVC: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let paddingWith: CGFloat = sectionInsets.left  * (itemsPerRow + 1) //общая ширина отступов
            let availableWith: CGFloat = collectionView.frame.width - paddingWith //доступн. ширина
            let widthOfItem: CGFloat = availableWith / itemsPerRow //ширина каждого объекта
            return CGSize(width: widthOfItem, height: widthOfItem)
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return sectionInsets
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return sectionInsets.left
        }

        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return sectionInsets.left
        }
        
        
        
    }
