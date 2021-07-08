//
//  ViewController.swift
//  PhotoInCollection
//
//  Created by Roma Test on 03.06.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView?
    var images = [UIImage]()
    var imagesIndexesForUpload = [IndexPath]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = cellLayout()
        collectionView?.collectionViewLayout = layout
        setupCollectionView()
    }

    private func setupCollectionView() {
        if let collectionView = collectionView {
            collectionView.register(CollectionViewCell.nib(), forCellWithReuseIdentifier: CollectionViewCell.identifier)
            collectionView.dataSource = self
        }
    }
    
    private func cellLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 90)
        layout.minimumLineSpacing = CGFloat(1)
        layout.minimumInteritemSpacing = CGFloat(1)
        return layout
    }
    
    @IBAction func openGalleryUIButton(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }
}


extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey(rawValue: "UIImagePickerControllerEditedImage")] as? UIImage {
            self.images.append(image)
            
            if let collectionView = collectionView {
                collectionView.reloadData()
            }
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}


extension ViewController:  /*UICollectionViewDelegate*/ UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell else {
            preconditionFailure("Coudn't find cell with identifier \(CollectionViewCell.identifier)")
        }
        
        cell.imageView?.image = images[indexPath.item]

        cell.buttonOnImageClicked = /*action*/
            { [weak self] in
            if let strongSelf = self {
                strongSelf.imagesIndexesForUpload.append(indexPath)
                print("imagesIndexesForUpload \(strongSelf.imagesIndexesForUpload)")
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 120, height: 120)
    }
    
//    func action() {
//    }
}


