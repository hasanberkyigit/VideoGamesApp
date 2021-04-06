//
//  HomeHeaderPagerView.swift
//  VideoGamesApp
//
//  Created by hasanberk yigit on 31.03.2021.
//

import UIKit

class HomeHeaderPagerView: UIView {
    
    private var viewModel: HomeHeaderPagerViewModel?
    weak var controller: UIViewController?
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.registerHomeHeaderCell()
            collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    private var currentIndex: Int = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    private func initView(){
        Bundle.main.loadNibNamed("HomeHeaderPagerView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
    }
    func setViewModel(viewModel: HomeHeaderPagerViewModel){
        self.viewModel = viewModel
        pageControl.numberOfPages = viewModel.numberOfRowsInSection()
    }
}

extension HomeHeaderPagerView: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return viewModel?.numberOfRowsInSection() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeHeaderCollectionViewCell", for: indexPath) as? HomeHeaderCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.configure(game: viewModel?.cellForRowAt(index: indexPath.row))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(identifier: "DetailsVC") as DetailViewController
        detailVC.setViewModel(viewModel: (viewModel?.didSelectItemAt(index: indexPath.row))!)
        detailVC.modalPresentationStyle = .fullScreen
        
        self.controller?.present(detailVC, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: collectionView.frame.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard scrollView == collectionView else { return }

        let pageWidth = collectionView.frame.width - 32 + 16
        currentIndex = Int((scrollView.contentOffset.x + 16) / pageWidth)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity _: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard scrollView == collectionView else { return }

        let pageWidth = collectionView.frame.width - 32 + 16
        var targetIndex = Int(roundf(Float(targetContentOffset.pointee.x / pageWidth)))
        targetIndex = targetIndex > currentIndex ? currentIndex + 1 : targetIndex < currentIndex ? currentIndex - 1 : currentIndex

        let count = collectionView.numberOfItems(inSection: 0)
        targetIndex = max(min(targetIndex, count - 1), 0)

        targetContentOffset.pointee = scrollView.contentOffset
        let offsetX: CGFloat = targetIndex < count - 1 ? (pageWidth * CGFloat(targetIndex) - 16) : (scrollView.contentSize.width - scrollView.frame.width) + 16

        pageControl.currentPage = targetIndex
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0.0), animated: true)
    }
}
