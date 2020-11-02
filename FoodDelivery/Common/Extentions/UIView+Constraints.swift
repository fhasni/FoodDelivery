//
//  Extentions.swift
//  FireChat
//
//  Created by fhasni on 9/27/20.
//  Copyright © 2020 fhasni. All rights reserved.
//


import UIKit

struct ViewConConstraints {
    var top: NSLayoutConstraint?
    var left: NSLayoutConstraint?
    var bottom: NSLayoutConstraint?
    var right: NSLayoutConstraint?
    var height: NSLayoutConstraint?
    var width: NSLayoutConstraint?
    var centerX: NSLayoutConstraint?
    var centerY: NSLayoutConstraint?
    
    func activate() {
        top?.isActive = true
        left?.isActive = true
        bottom?.isActive = true
        right?.isActive = true
        height?.isActive = true
        width?.isActive = true
        centerX?.isActive = true
        centerY?.isActive = true
    }
    
    func desactivate() {
        top?.isActive = false
        left?.isActive = false
        bottom?.isActive = false
        right?.isActive = false
        height?.isActive = false
        width?.isActive = false
        centerX?.isActive = false
        centerY?.isActive = false
    }
}

extension UIView {

    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil) -> ViewConConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var viewConstraints = ViewConConstraints()
        
        if let top = top {
            viewConstraints.top = topAnchor.constraint(equalTo: top, constant: paddingTop)
        }
        
        if let left = left {
            viewConstraints.left = leftAnchor.constraint(equalTo: left, constant: paddingLeft)
        }
        
        if let bottom = bottom {
            viewConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom)
        }
        
        if let right = right {
            viewConstraints.right = rightAnchor.constraint(equalTo: right, constant: -paddingRight)
        }
        
        if let width = width {
            viewConstraints.width = widthAnchor.constraint(equalToConstant: width)
        }
        
        if let height = height {
            viewConstraints.height = heightAnchor.constraint(equalToConstant: height)
        }
        
        viewConstraints.activate()
        
        return viewConstraints
    }
    
    @discardableResult
    func setDimensions(height: CGFloat? = nil, width: CGFloat? = nil) -> ViewConConstraints {
        var viewConstraints = ViewConConstraints()

        translatesAutoresizingMaskIntoConstraints = false

        if let height = height {
            viewConstraints.height = heightAnchor.constraint(equalToConstant: height)
        }
        
        if let width = width {
            viewConstraints.width = widthAnchor.constraint(equalToConstant: width)
        }
                
        viewConstraints.activate()
        return viewConstraints
    }
    
    @discardableResult
    func setHeight(height: CGFloat) -> ViewConConstraints {
        var viewConstraints = ViewConConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        viewConstraints.height = heightAnchor.constraint(equalToConstant: height)
        viewConstraints.activate()
        return viewConstraints
    }
    
    @discardableResult
    func setWidth(width: CGFloat) -> ViewConConstraints {
        var viewConstraints = ViewConConstraints()
        translatesAutoresizingMaskIntoConstraints = false
        viewConstraints.width = widthAnchor.constraint(equalToConstant: width)
        viewConstraints.activate()
        return viewConstraints
    }
    
    func centerX(inView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeft: CGFloat = 0, constant: CGFloat = 0) {

        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let left = leftAnchor {
            anchor(left: left, paddingLeft: paddingLeft)
        }

    }
}
