//
//  CafeBlogTableViewController.swift
//  Todays_Cafe
//
//  Created by SeungMin on 2021/08/09.
//

import UIKit
import SwiftSoup
import Foundation

class CafeBlogTableViewController: UIViewController {
    var tagName: String?
    var areaName: String?
    var searchingContent: String = ""
    var urlQueryContent: String = ""
    
    let cafeBlogViewModel = CafeBlogViewModel()
    
    @IBOutlet weak var cafeBlogTableView: UITableView!
    
    @IBOutlet weak var backBtn: UIButton! {
        didSet {
            self.backBtn.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
            self.backBtn.contentHorizontalAlignment = .fill
            self.backBtn.contentVerticalAlignment = .fill
            self.backBtn.tintColor = .darkGray
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if let areaName = self.areaName, let tagName = self.tagName{
            urlQueryContent = areaName + " " + tagName[tagName.index(after: tagName.startIndex)...] + " 카페"
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
        guard let url = URL(string: urlAddress) else { return }
        do {
            let html = try String(contentsOf: url, encoding: .utf8)

            let doc: Document = try SwiftSoup.parse(html)
            for blogIndex in 1..<10 {
                let blogIndex = String(blogIndex)

                let ImageSrcData: Elements = try doc.select("div._more_contents_event_base").select("ul.lst_total").select("li#sp_blog_\(blogIndex).bx").select("img[src]")
                let ImageSrcArray = ImageSrcData.array()
                
                // 썸네일
                let blogThumnailStringName = try ImageSrcArray[1].attr("src").description
                guard let blogThumnailUrlImage = URL(string: blogThumnailStringName) else { return }
                let blogThumbnail = try Data(contentsOf: blogThumnailUrlImage)

                // 블로거 이미지
                let blogerImgStringImage = try ImageSrcArray[0].attr("src").description
                guard let blogerImgStringImageUrlImage = URL(string: blogerImgStringImage) else { return }
                let blogerImage = try Data(contentsOf: blogerImgStringImageUrlImage)
                
                
                let blogerTextData: Elements = try doc.select("div._more_contents_event_base").select("ul.lst_total").select("li#sp_blog_\(blogIndex).bx").select("div.total_sub").select("span")
                var blogerTextArray = try blogerTextData.array()[1].text().components(separatedBy: " ")
                
                // 블로거 업로드 날짜
                var blogerUploadDate = blogerTextArray.removeFirst()
                
                if blogerTextArray[0].count == 1 && blogerTextArray[0] == "전" {
                    blogerUploadDate += " " + blogerTextArray.removeFirst()
                }
                
                // 블로거 이름
                let blogerName = blogerTextArray.joined(separator: " ")
                                
                let blogTextData: Elements = try doc.select("div._more_contents_event_base").select("ul.lst_total").select("li#sp_blog_\(blogIndex).bx").select("div.total_area").select("a")
                let blogTextArray = blogTextData.array()
                
                // 블로그 타이틀
                let blogTitle = try String(blogTextArray[blogTextArray.count - 2].text())
                
                // 블로그 컨텐츠
                let blogContent = try String(blogTextArray[blogTextArray.count - 1].text())
                                
                let cafeBlogTableViewCell = CafeBlogCellInfo(UIImage(data: blogThumbnail)!, UIImage(data: blogerImage)!, blogerName, blogerUploadDate, blogTitle, blogContent)
                cafeBlogViewModel.appendCafeBlog(cafeBlogTableViewCell)
            }
        } catch Exception.Error(let type, let message) {
            print(message)
        } catch {
            print("error")
        }
    }
    
    @IBAction func onBackBtnClicked() {
        dismiss(animated: true, completion: nil)
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
    
}
