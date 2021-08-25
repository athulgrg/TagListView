//
//  TagView.swift
//  TagListViewDemo
//
//  Created by Dongyuan Liu on 2015-05-09.
//  Copyright (c) 2015 Ela. All rights reserved.
//

import UIKit

open class TagView: UILabel {

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
    
    public init(title: NSAttributedString) {
        super.init(frame: CGRect.zero)

        attributedText = title
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
