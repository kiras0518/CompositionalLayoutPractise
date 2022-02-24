//
//  ViewController.swift
//  Compositional Layout Practise
//
//  Created by yukun on 2022/2/24.
//

import UIKit

//MARK: - properties
enum Section {
    case main
}

class ViewController: UIViewController {

    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    
    let viewServiceFactory = ViewServiceFactory()
    
    //MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureDataSource()
        configureLayout()
    }

}

extension ViewController {
    
    func configureLayout() {
        //1
        collectionView.collectionViewLayout = viewServiceFactory.createRowLayout()
        //2
        collectionView.collectionViewLayout = viewServiceFactory.createOneRowNestedGroupLayout()
        //3
        collectionView.collectionViewLayout = viewServiceFactory.createTwoRowsNestedGroupLayout()
    }
    
    private func configureDataSource() {
        
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            
            // Get a cell of the desired kind.
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: MainCollectionViewCell.identifier,
                for: indexPath) as? MainCollectionViewCell else { fatalError("Cannot create new cell") }
       
            cell.title.text = "\(identifier)"
            
            cell.layer.cornerRadius = 8
            
            return cell
        }
        
        // initial data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<999))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}


