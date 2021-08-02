//
//  TagView.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

open class TagView: LinkedLabel {

    open var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    open var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    open var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    open var tagTextColor: UIColor = UIColor.white {
        didSet {
            textColor = tagTextColor
        }
    }

    open var titleLineBreakMode: NSLineBreakMode = .byTruncatingMiddle {
        didSet {
            lineBreakMode = titleLineBreakMode
        }
    }

    open var paddingY: CGFloat = 2 {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }

    open var paddingX: CGFloat = 5 {
        didSet {
            setNeedsLayout()
            layoutIfNeeded()
        }
    }

    open var tagBackgroundColor: UIColor = UIColor.gray {
        didSet {
            backgroundColor = tagBackgroundColor
        }
    }
    
    open var textFont: UIFont = .systemFont(ofSize: 12) {
        didSet {
            font = textFont
        }
    }

    // MARK: - init
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    public init(title: String) {
        super.init(frame: CGRect.zero)

        if (title.isHTML) {
            attributedText = title.htmlToAttributedString
        } else {
            text = title
        }
        setupView()
    }
    
    private func setupView() {
        lineBreakMode = titleLineBreakMode
        textAlignment = .center
        numberOfLines = 0
        frame.size = intrinsicContentSize
        isUserInteractionEnabled = true
    }
    
    // MARK: - layout

    override open var intrinsicContentSize: CGSize {
        var size = text?.size(withAttributes: [NSAttributedString.Key.font: textFont]) ?? CGSize.zero
        size.height = textFont.pointSize + paddingY * 2
        size.width += paddingX * 2
        if size.width < size.height {
            size.width = size.height
        }
        return size
    }
}

/// Swift < 4.2 support
#if !(swift(>=4.2))
private extension NSAttributedString {
    typealias Key = NSAttributedStringKey
}
private extension UIControl {
    typealias State = UIControlState
}
#endif


extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }

    var isHTML: Bool {
        if isEmpty {
            return false
        }
        return (range(of: "<(\"[^\"]*\"|'[^']*'|[^'\">])*>", options: .regularExpression) != nil)
    }
}


open class LinkedLabel: UILabel {

    fileprivate let layoutManager = NSLayoutManager()
    fileprivate let textContainer = NSTextContainer(size: CGSize.zero)
    fileprivate var textStorage: NSTextStorage?


    override init(frame aRect:CGRect){
        super.init(frame: aRect)
        self.initialize()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    func initialize(){

        let tap = UITapGestureRecognizer(target: self, action: #selector(LinkedLabel.handleTapOnLabel))
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(tap)
    }

    open override var attributedText: NSAttributedString?{
        didSet{
            if let _attributedText = attributedText{
                self.textStorage = NSTextStorage(attributedString: _attributedText)

                self.layoutManager.addTextContainer(self.textContainer)
                self.textStorage?.addLayoutManager(self.layoutManager)

                self.textContainer.lineFragmentPadding = 0.0;
                self.textContainer.lineBreakMode = self.lineBreakMode;
                self.textContainer.maximumNumberOfLines = self.numberOfLines;
            }

        }
    }

    @objc func handleTapOnLabel(tapGesture:UITapGestureRecognizer){

        let locationOfTouchInLabel = tapGesture.location(in: tapGesture.view)
        let labelSize = tapGesture.view?.bounds.size
        let textBoundingBox = self.layoutManager.usedRect(for: self.textContainer)
        let textContainerOffset = CGPoint(x: ((labelSize?.width)! - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: ((labelSize?.height)! - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = self.layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: self.textContainer, fractionOfDistanceBetweenInsertionPoints: nil)


        let rangeX = NSMakeRange(0, self.attributedText?.length ?? 0)
        let options = NSAttributedString.EnumerationOptions(rawValue: UInt(0))
        self.attributedText?.enumerateAttribute(.link, in: rangeX, options: options, using: { attributes, range, stop in
            if NSLocationInRange(indexOfCharacter, range){
                if let attr = attributes as? URL {
                    UIApplication.shared.open(attr, options: [:], completionHandler: nil)
                }
            }
        })
    }
}
