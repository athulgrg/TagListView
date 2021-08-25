//
//  ViewController.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit
import Foundation

let html = """
            <!DOCTYPE html PUBLIC \"-//W3C//DTD HTML 4.01//EN\"
 \"http://www.w3.org/TR/html4/strict.dtd\">\n<html>\n<head>
\n<meta http-equiv=\"Content-Type\" content=\"text/html;
charset=UTF-8\">\n<meta http-equiv=\"Content-Style-Type\"
 content=\"text/css\">\n<title></title>\n<meta name=\"Generator\"
content=\"Cocoa HTML Writer\">\n<style type=\"text/css\">\np.p1
{margin: 0.0px 0.0px 0.0px 0.0px; font: 12.0px \'Times New Roman\';
 color: #000000; -webkit-text-stroke: #000000}\nspan.s1
{font-family: \'TimesNewRomanPS-BoldMT\'; font-weight: bold;
 font-style: normal; font-size: 12.00px; font-kerning: none}\nspan.s2
{font-family: \'.SFUI-Regular\'; font-weight: normal; font-style: normal;
 font-size: 14.00px; -webkit-text-stroke: 0px #000000}\nspan.s3
{font-family: \'.SFUI-Regular\'; font-weight: normal; font-style:
normal; font-size: 14.00px; color: #000000; -webkit-text-stroke:
 0px #000000}\n</style>\n</head>\n<body>\n<p class=\"p1\">
<span class=\"s1\">This text is bold</span><span class=\"s2\">
<a href=\"https://www.youtube.com/watch?v=o8KGtruDxPQ\">
<span class=\"s3\">YouTube</span></a>
<span class=\"Apple-converted-space\">&nbsp;</span></span></p>\n</body>\n</html>\n
"""

class ViewController: UIViewController {

    @IBOutlet weak var tagListView: TagListView!
    @IBOutlet weak var biggerTagListView: TagListView!
    @IBOutlet weak var biggestTagListView: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let title1 = NSMutableAttributedString(string: "体の特徴（困りごと） | ",
                                             attributes: [NSAttributedString.Key.font:
                                                            UIFont.systemFont(ofSize: 12, weight: .regular),
                                                          NSAttributedString.Key.foregroundColor:
                                                            UIColor.lightGray])
        let description1 = NSAttributedString(string: "高身長さん, 低身長さん, 肩幅広いさん, 大胸さん, 肩幅広め, 二の腕太め, おしり大きめ, ふともも太め, ふくらはぎ太め, 下腹ぽっこり, 足が甲高, 足が幅広",
                                      attributes:[NSAttributedString.Key.font:
                                                    UIFont.systemFont(ofSize: 12, weight: .bold),
                                                  NSAttributedString.Key.foregroundColor:
                                                    UIColor.darkGray])
        title1.append(description1)

        let attributedTag1 = TagView(title: title1)
        attributedTag1.titleLineBreakMode = .byTruncatingTail
        attributedTag1.paddingX = 12
        attributedTag1.paddingY = 8

        let title2 = NSMutableAttributedString(string: "Athul George | ",
                                             attributes: [NSAttributedString.Key.font:
                                                            UIFont.systemFont(ofSize: 12, weight: .regular),
                                                          NSAttributedString.Key.foregroundColor:
                                                            UIColor.lightGray as Any])
        guard let description2 = try? NSAttributedString(data: Data(html.utf8),
                                               options: [.documentType: NSAttributedString.DocumentType.html],
                                               documentAttributes: nil) else { return }
        title2.append(description2)

        let attributedTag2 = TagView(title: title2)
        attributedTag2.paddingX = 12
        attributedTag2.paddingY = 8

        biggestTagListView.addTagViews([attributedTag1])
        biggestTagListView.backgroundColor = UIColor.red
    }
}


// 体の特徴（困りごと） | 高身長さん, 低身長さん, 肩幅広いさん, 大胸さん, 肩幅広め, 二の腕太め, おしり大きめ, ふともも太め, ふくらはぎ太め, 下腹ぽっこり, 足が甲高, 足が幅広
