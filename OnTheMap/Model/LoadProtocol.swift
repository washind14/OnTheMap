//
//  Loadable.swift
//  OnTheMap
//
//  Created by Desha Washington on 6/14/21.
//

import UIKit

protocol Loadable {
    func startLoading()
    func stopLoading()
}

extension Loadable {
    
    func startLoading() {
        let loaderView = LoadingView()
        loaderView.setupLayout(targetView: UIApplication.shared.windows.first!)
    }
    
    func stopLoading() {
        let targetView = UIApplication.shared.windows.first!
        targetView.isUserInteractionEnabled = true
        for view in targetView.subviews where view is LoadingView {
            view.removeFromSuperview()
        }
    }
    
}
