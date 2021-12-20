//
//  CafeBlogTableViewController.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/09.
//

import UIKit
import SwiftSoup

class CafeBlogTableViewController: UIViewController {
    var areaName: String?
    var tagName: String?
    var cityName: String = ""
    var searchingContent: String = ""
    var urlQueryContent: String = ""
    
    let cafeBlogViewModel = CafeBlogViewModel()
    
    @IBOutlet weak var cafeBlogTableView: UITableView!
    
    @IBOutlet weak var backButton: UIButton! {
        didSet {
            self.backButton.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
            self.backButton.contentHorizontalAlignment = .fill
            self.backButton.contentVerticalAlignment = .fill
            self.backButton.tintColor = .darkGray
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let areaName = self.areaName, let tagName = self.tagName{
            urlQueryContent = cityName + " " + areaName + " " + tagName[tagName.index(after: tagName.startIndex)...] + " 카페"
        }
        self.fetchHTMLParsingResultWill {
            () in print()
        }
        
        cafeBlogTableView.dataSource = self
        cafeBlogTableView.delegate = self
    }
    
    // Mark: - fetchHTMLParsingResultWill
    func fetchHTMLParsingResultWill(completion: @escaping() -> ()) {
        let urlString = "https://search.naver.com/search.naver?query=" + urlQueryContent + "&nso=&where=blog&sm=tab_opt"
        let urlAddress = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        guard let url = URL(string: urlAddress) else {
            print(NetworkError.invalidURL)
            return
        }
        do {
            guard let html = try? String(contentsOf: url, encoding: .utf8)
            else {
                print(NetworkError.invalidHTML)
                return
            }
            
            guard let document: Document = try? SwiftSoup.parse(html)
            else {
                print(NetworkError.invalidParsing)
                return
            }
            
            print(document)
            
            for blogIndex in 1...10 {
                let blogIndex = String(blogIndex)

                let ImageSourceData: Elements = try document.select("div._more_contents_event_base").select("ul.lst_total").select("li#sp_blog_\(blogIndex).bx").select("img[src]")
                let ImageSourceArray = ImageSourceData.array()
                
                // 썸네일
                let blogThumnailStringName = try ImageSourceArray[1].attr("src").description
                guard let blogThumnailUrlImage = URL(string: blogThumnailStringName)
                else {
                    print(NetworkError.invalidBlogThumbnail)
                    return
                }
                let blogThumbnail = try Data(contentsOf: blogThumnailUrlImage)

                // 블로거 이미지
                let blogerImgStringImage = try ImageSourceArray[0].attr("src").description
                guard let blogerImgStringImageUrlImage = URL(string: blogerImgStringImage)
                else {
                    print(NetworkError.invalidBlogerImage)
                    return
                }
                let blogerImage = try Data(contentsOf: blogerImgStringImageUrlImage)
                
            
                let blogerTextData: Elements = try document.select("div._more_contents_event_base").select("ul.lst_total").select("li#sp_blog_\(blogIndex).bx").select("div.total_sub").select("span")
                var blogerTextArray = try blogerTextData.array()[1].text().components(separatedBy: " ")
                
                // 블로거 업로드 날짜
                var blogerUploadDate = blogerTextArray.removeFirst()
                
                if blogerTextArray[0].count == 1 && blogerTextArray[0] == "전" {
                    blogerUploadDate += " " + blogerTextArray.removeFirst()
                }
                
                // 블로거 이름
                let blogerName = blogerTextArray.joined(separator: " ")
                                
                let blogTextData: Elements = try document.select("div._more_contents_event_base").select("ul.lst_total").select("li#sp_blog_\(blogIndex).bx").select("div.total_area").select("a")
                let blogTextArray = blogTextData.array()
                
                // 블로그 타이틀
                guard let blogTitle = try? String(blogTextArray[blogTextArray.count - 2].text())
                else {
                    print(NetworkError.invalidBlogTitle)
                    return
                }
                
                // 블로그 컨텐츠
                guard let blogContent = try? String(blogTextArray[blogTextArray.count - 1].text())
                else {
                    print(NetworkError.invalidBlogContetnt)
                    return
                }
                
                let blogLinkSplit = try blogTextArray[blogTextArray.count - 1].absUrl("href").components(separatedBy: "?")
                let blogUrl = blogLinkSplit[0]
                let blogLinkLogNumSplit = blogLinkSplit[blogLinkSplit.count - 1].components(separatedBy: "=")
                let blogLinkLogNum = blogLinkLogNumSplit[blogLinkLogNumSplit.count - 1]
                
                let mobileKeywordIndex = blogUrl.index(blogUrl.startIndex, offsetBy: 8)
                
                var blogDetailUrl = blogUrl + "/" + blogLinkLogNum
                blogDetailUrl.insert(contentsOf: "m.", at: mobileKeywordIndex)
                                
                let cafeBlogTableViewCell = CafeBlogCellInfo(UIImage(data: blogThumbnail)!, UIImage(data: blogerImage)!, blogerName, blogerUploadDate, blogTitle, blogContent, blogDetailUrl)
                
                cafeBlogViewModel.appendCafeBlog(cafeBlogTableViewCell)
            }
        } catch {
            print(NetworkError.invalidRequest)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cafeBlogDetailViewController = segue.destination as? CafeBlogDetailViewController else { return }
        if let blogInfo = sender as? CafeBlogCellInfo {
            cafeBlogDetailViewController.cafeBlogUrlString = blogInfo.blogDetailUrl
        }
    }
    
    @IBAction func onBackButtonClicked() {
        dismiss(animated: false, completion: nil)
    }
}

// Mark: - UITableViewDataSource
extension CafeBlogTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cafeBlogViewModel.countCafeBlogList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cafeBlogTableViewCell", for: indexPath) as? CafeBlogTableViewCell else { return UITableViewCell() }
        let cafeBlogInfo = cafeBlogViewModel.cafeBlogInfo(at: indexPath.item)
        cell.update(cafeBlogInfo)
        return cell
    }
}

// Mark: - UITableViewDelegate
extension CafeBlogTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let blogInfo = cafeBlogViewModel.cafeBlogInfo(at: indexPath.item)
        performSegue(withIdentifier: "cafeBlogTableVCToCafeBlogDetailVC", sender: blogInfo)
    }
}
