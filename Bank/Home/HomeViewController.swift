
import UIKit
import RxSwift
import RxCocoa
import FSPagerView

class HomeViewController: UIViewController {

    @IBOutlet weak var bageView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var showAmountButton: UIButton!
    //USD
    @IBOutlet weak var usdView: UIView!
    @IBOutlet weak var usdLabel: UILabel!
    
    //KHU
    @IBOutlet weak var khuView: UIView!
    @IBOutlet weak var khuLabel: UILabel!
    
    @IBOutlet weak var adContentView: UIView!
    @IBOutlet weak var pageControlView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var favoriteEmptyView: UIView!
    
    var homeViewModel: HomeVMInterface!
    private var disposeBag = DisposeBag()
    var pagerView = FSPagerView(frame:CGRect.zero)
    var pageControl = FSPageControl(frame: CGRect.zero)
    var pagerArray: [BannerModel] = []
    var favoriteList: [FavoriteModel] = []
    
    //Amount
    var isShowAmount = true //是否顯示金額
    var usdTemp = ""
    var khuTemp = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inttView()
        homeViewModel = HomeVM()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeViewModel()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disposeBag = DisposeBag()
    }
    
    func subscribeViewModel() {
        homeViewModel.getFirstUSDTotalSubject
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { (result) in
            print("result: \(result)" )
            self.usdView.backgroundColor = .clear
            self.usdLabel.isHidden = false
            self.usdLabel.text = "\(result)".amount
        }).disposed(by: disposeBag)
        homeViewModel.getFirstUSDTotal()
        
        homeViewModel.getFirstKHRTotalSubject
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { (result) in
            print("result: \(result)" )
            self.khuView.backgroundColor = .clear
            self.khuLabel.isHidden = false
            self.khuLabel.text = "\(result)".amount
        }).disposed(by: disposeBag)
        homeViewModel.getFirstKHRTotal()
        
        //Refresh
        homeViewModel.getRefreshUSDTotalSubject
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { (result) in
            print("result: \(result)" )
            self.usdView.backgroundColor = .clear
            self.usdLabel.isHidden = false
            self.usdLabel.text = "\(result)".amount
        }).disposed(by: disposeBag)
        
        homeViewModel.getRefreshKHRTotalSubject
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { (result) in
            print("result: \(result)" )
            self.khuView.backgroundColor = .clear
            self.khuLabel.isHidden = false
            self.khuLabel.text = "\(result)".amount
        }).disposed(by: disposeBag)
        
        //最愛的功能清單
        homeViewModel.getFavoriteListSubject
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { (result) in
            self.favoriteEmptyView.isHidden = true
            self.collectionView.isHidden = false
            self.favoriteList = result.data
            self.collectionView.reloadData()
        }).disposed(by: disposeBag)
        
        
        //輪播圖
        homeViewModel.getBannerListSubject
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { (result) in
            self.setTopAdLoopCell(array: result.data)
        }).disposed(by: disposeBag)
        homeViewModel.getBannerList()
        
        //推播清單
        homeViewModel.getNotificationListSubject
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { (result) in
            print("result: \(result)" )
            self.bageView.isHidden = !(result.data.count > 0)
        }).disposed(by: disposeBag)
    }
    
    func refreshAmount() {
        isShowAmount = true
        showAmountButton.setImage(UIImage(named: "iconEye01On"), for: .normal)
        homeViewModel.getFavoriteList()
        homeViewModel.getNotificationList()
        homeViewModel.getRefreshUSDTotal()
        homeViewModel.getRefreshKHRTotal()
    }

    @IBAction func notificationAction(_ sender: UIButton) {
        guard let notificationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController else { return }
        self.navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    @IBAction func showAmountAction(_ sender: UIButton) {
        if isShowAmount {
            isShowAmount = false
            usdTemp = usdLabel.text ?? ""
            khuTemp = khuLabel.text ?? ""
            usdLabel.text = "********"
            khuLabel.text = "********"
            showAmountButton.setImage(UIImage(named: "iconEye02Off"), for: .normal)
        }else {
            isShowAmount = true
            usdLabel.text = usdTemp
            khuLabel.text = khuTemp
            showAmountButton.setImage(UIImage(named: "iconEye01On"), for: .normal)
        }
    }
    
    func inttView() {
        //通知紅點
        bageView.isHidden = true
        bageView.layer.cornerRadius = 5
        
        barView.layer.cornerRadius = 26
        barView.layer.shadowColor = UIColor.gray.cgColor
        barView.layer.shadowOpacity = 0.5
        barView.layer.shadowOffset = CGSize(width: 0, height: 2)
        barView.layer.shadowRadius = 5
        
        self.favoriteEmptyView.isHidden = false
        self.collectionView.isHidden = true
        
        scrollView.delegate = self
        usdLabel.isHidden = true
        khuLabel.isHidden = true
        collectionView.register(UINib(nibName: "FavoriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavoriteCollectionViewCell")
        
        //輪播圖
        adContentView.addFixView(view: pagerView)
        pageControlView.addFixView(view: pageControl)
        adContentView.addFixView(view: pagerView)
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.automaticSlidingInterval = 4.0
        pagerView.isInfinite = true
        pagerView.interitemSpacing = 4
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        let pageColor = UIColor.black
        self.pageControl.setFillColor(pageColor, for: .selected)
    }
    
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        cell.setData(imageString: favoriteList[indexPath.row].transType, title: favoriteList[indexPath.row].nickname)
        return cell
    }
}
extension HomeViewController: UIScrollViewDelegate {
    ///滑動停止後 設定UI狀態
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating")
        refreshAmount()
    }
    
}
extension HomeViewController {
    
    ///輪播廣告
    func setTopAdLoopCell(array: [BannerModel]) {
        
        pagerArray = array
        pageControl.numberOfPages = array.count
        pageControl.currentPage = pagerView.currentIndex
        self.pagerView.reloadData()
        if (array.count == 1) {
            pagerView.isScrollEnabled = false
            pagerView.automaticSlidingInterval = 0.0
            pagerView.isInfinite = false
            pageControl.isHidden = true
        }
    }
    
}
extension HomeViewController: FSPagerViewDataSource, FSPagerViewDelegate {
    
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return pagerArray.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "Cell", at: index)
        cell.contentView.layer.shadowOffset = CGSize(width: 5, height: 5)
        cell.contentView.layer.shadowOpacity = 0.7
        cell.layer.shadowRadius = 5
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        let defaultImage = UIImage(named: "welcome_ad_deful")
        UIImageView.loadUrlImage(urlString: self.pagerArray[index].linkUrl, cacheKey: "", callBack: { (_, _, image) in
            if image != nil {
                cell.imageView?.image = image
            }else{
                UIImageView.loadUrlImage(urlString: self.pagerArray[index].linkUrl, cacheKey: "", callBack:  { (type, _, image) in
                    cell.imageView?.image = image != nil ? image : defaultImage
                })
            }
        })
        let _ = cell.imageView?.image
        return cell
        
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        pageControl.currentPage = targetIndex
        
    }
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        pageControl.currentPage = pagerView.currentIndex
    }
    
    
}
