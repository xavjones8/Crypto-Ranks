//
//  CryptoCollectionViewController.swift
//  Crypto Ranks
//
//  Created by Xavier Jones on 6/25/21.
//

import UIKit
import Foundation



class CryptoCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    let reuseIdentifier = "cell"
    
    //Array to test out collection view before implementing API.
   
    var currenciesArray: [Cryptocurrency] = []
    
    @IBOutlet weak var cryptoCollection: UICollectionView!
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //Fetches data and reloads collection view.
        loadingIndicator.startAnimating()
            self.fetchCurrencies { (result) in
                DispatchQueue.main.async {
                    switch result{
                    
                    case .success(let array ):
                        //Retrieves and sorts the array by rank
                        self.currenciesArray = array.data
                        self.currenciesArray.sort(by: <)
                        //Reloads the collection view and hides the loading indicator
                        self.cryptoCollection.reloadData()
                        self.loadingIndicator.stopAnimating()
                        
                    case .failure:
                        //Prompts user to connect to the internet ro retrieve data
                        //ISSUE If the user connects to wifi after this alert has been shown, the view won't refresh.
                        let alertController = UIAlertController(title: "Network Error", message: "This app requires a network connection to display cryptocurrencies. Please connect to a network to continue", preferredStyle: .alert)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                }
                
            }
        //Updates collection view layout to the predefined layout made in the generateLayout() method
        cryptoCollection.setCollectionViewLayout(generateLayout(), animated: false)
        // Do any additional setup after loading the view.
       // collectionView!.register(CryptoCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currenciesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! CryptoCollectionViewCell
        let currency = currenciesArray[indexPath.item]
        
        //Updates values for cell labels
        cell.nameLabel.text = currency.name
        cell.symbolLabel.text = currency.symbol
        cell.priceLabel.text = "$\(currency.price)"
        
        //Edits the appearance of the collection view items
        cell.layer.backgroundColor = currency.color
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.gray.cgColor
        cell.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        cell.layer.shadowRadius = 10.0
        cell.layer.shadowOpacity = 0.25
        cell.layer.masksToBounds = false
        cell.layer.shadowPath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius).cgPath
        
        return cell
    }
    //Handles touch input for the collection view.
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          performSegue(withIdentifier: "cryptoDetailsSegue", sender: currenciesArray[indexPath.item])
      }
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          super.prepare(for: segue, sender: sender)
        //This takes the Crypto item that was set as a sender when the segue is performed and sends it to the CryptoDetailsViewController
          guard segue.identifier == "cryptoDetailsSegue" else {return}
          let selectedCrypto = sender as! Cryptocurrency
          let destinationVC = segue.destination as! CryptoDetailsViewController
          destinationVC.selectedCrypto = selectedCrypto
          // Get the new view controller using segue.destination.
          // Pass the selected object to the new view controller.
      }
    /*
    // MARK: - Functions
    
    */
    private func generateLayout() -> UICollectionViewLayout{
        //This sets the spacing for the items and arrangement in the collection view
        let spacing: CGFloat = 5.0
        
        //Establsihes and sets the size for each row item
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: 0, trailing: spacing)
        
        //Establishes and sets the sizes for each group
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(80.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: spacing, leading: spacing, bottom: 0, trailing: spacing)
        
        //Establishes and sets the sizes for the section and connects it to the group.
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    func fetchCurrencies(completion: @escaping (Result<CurrenciesResults, Error>) -> Void){
        
        //Creates URL for API Call
        var urlComponents = URLComponents(string: "https://api.coinlore.net/api/tickers/")!
        urlComponents.queryItems = [
            "start": "0",
            "limit": "100"].map {URLQueryItem(name: $0.key, value: $0.value)}
        
        //Calls API
        let task = URLSession.shared.dataTask(with: urlComponents.url!) { (data, response, error) in
           let jsonDecoder = JSONDecoder()
            if let data = data{
                do{
                    //Decodes retrieved JSON and sends the results to completion.
                    let currencies = try jsonDecoder.decode(CurrenciesResults.self, from: data)
                    completion(.success(currencies))
                    
                }catch{
                    //Sends error results to completion
                    completion(.failure(error))
                }
            }else{
                //This is added to ensure that an error is shown when network connection is not present whne loading data.
                completion(.failure(error!))
            }
            
        }
        task.resume()
    }
    
}
