////
////  CustomLoaderController.swift
////  SdkSkelton
////
////  Created by MOBILE on 26/06/24.
////
//
//import Foundation
//import UIKit
//
//class LoadingView: UIView {
//    
//    private let activityIndicator: UIActivityIndicatorView = {
//        let indicator = UIActivityIndicatorView(style: .large)
//        indicator.translatesAutoresizingMaskIntoConstraints = false
//        indicator.color = .white
//        return indicator
//    }()
//    
//    private let bgView: UIView = {
//       let bgView = UIView()
//        bgView.translatesAutoresizingMaskIntoConstraints = false
//        bgView.backgroundColor = UIColor.red
//        return bgView
//    }()
//    
// 
//    
//    private let progressLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .white
//        label.font = Fonts().getFont400(size: 13)
//        label.textAlignment = .center
//        return label
//    }()
//    
//
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupView()
//    }
//    
//    private func setupView() {
//        
//        backgroundColor = UIColor.black.withAlphaComponent(0.7)
//        layer.cornerRadius = 10
//        translatesAutoresizingMaskIntoConstraints = false
//        
//        addSubview(bgView)
//        addSubview(activityIndicator)
//        addSubview(progressLabel)
//        
//        setupConstraints()
//    }
//    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            
//          
//            
//            bgView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            bgView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            bgView.topAnchor.constraint(equalTo: self.topAnchor),
//            bgView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            
//            
//            
//            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
//            activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 20),
//            
//           
//            
//            progressLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
//            progressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            progressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//            
//         
//        ])
//    }
//    
//    func updateProgress(_ progress: String ) {
//        if(progress == "") {
//            progressLabel.text = "Loading..."
//        }
//        else {
//            progressLabel.text = "Downloading \(progress.replacingOccurrences(of: "Downloading database: ", with: ""))"
//        }
//        
//    }
//    
//    func show(in view: UIView) {
//        view.addSubview(self)
//        
//        // Set fixed size for the loader
//        NSLayoutConstraint.activate([
//            widthAnchor.constraint(equalToConstant: 160),
//            heightAnchor.constraint(equalToConstant: 100),
//            centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//        
//          
//        
//        activityIndicator.startAnimating()
//    }
//    
//    func hide() {
//        activityIndicator.stopAnimating()
//        removeFromSuperview()
//    }
//}
//
//


//import UIKit
//
//class LoadingView: UIView {
//    
//    private let activityIndicator: UIActivityIndicatorView = {
//        let indicator = UIActivityIndicatorView(style: .large)
//        indicator.translatesAutoresizingMaskIntoConstraints = false
//        indicator.color = .white
//        return indicator
//    }()
//    
//    private let backgroundView: UIView = {
//        let view = UIView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
//        return view
//    }()
//    
//    private let progressLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textColor = .white
//        label.font = UIFont.systemFont(ofSize: 13) // Use your custom font if needed
//        label.textAlignment = .center
//        return label
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupView()
//    }
//    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        setupView()
//    }
//    
//    private func setupView() {
//        translatesAutoresizingMaskIntoConstraints = false
//        
//        // Add backgroundView first to make sure it is at the back
//        addSubview(backgroundView)
//        addSubview(activityIndicator)
//        addSubview(progressLabel)
//        
//        setupConstraints()
//    }
//    
//    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            // Background view constraints
//            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
//            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
//            
//            // Activity indicator constraints
//            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
//            activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 20),
//            
//            // Progress label constraints
//            progressLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
//            progressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
//            progressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
//        ])
//    }
//    
//    func updateProgress(_ progress: String) {
//        if progress.isEmpty {
//            progressLabel.text = "Loading..."
//        } else {
//            progressLabel.text = "Downloading \(progress.replacingOccurrences(of: "Downloading database: ", with: ""))"
//        }
//    }
//    
//    func show(in view: UIView) {
//        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
//            window.addSubview(self)
//            
//            // Set constraints to cover the entire screen
//            NSLayoutConstraint.activate([
//                leadingAnchor.constraint(equalTo: window.leadingAnchor),
//                trailingAnchor.constraint(equalTo: window.trailingAnchor),
//                topAnchor.constraint(equalTo: window.topAnchor),
//                bottomAnchor.constraint(equalTo: window.bottomAnchor)
//            ])
//            
//            activityIndicator.startAnimating()
//        }
//    }
//    
//    func hide() {
//        activityIndicator.stopAnimating()
//        removeFromSuperview()
//    }
//}


import UIKit

class LoadingView: UIView {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .white
        return indicator
    }()
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        return view
    }()
    
    private let progressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13) // Use your custom font if needed
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        // Add backgroundView first to make sure it is at the back
        addSubview(backgroundView)
        addSubview(activityIndicator)
        addSubview(progressLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Background view constraints
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            // Activity indicator constraints
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            // Progress label constraints
            progressLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
            progressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            progressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
    func updateProgress(_ progress: String) {
        if progress.isEmpty {
            progressLabel.text = "Loading..."
        } else {
            progressLabel.text = "Downloading \(progress.replacingOccurrences(of: "Downloading database: ", with: ""))"
        }
    }
    
    func show(in view: UIView) {
        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            window.addSubview(self)
            
            // Set constraints to cover the entire screen
            NSLayoutConstraint.activate([
                leadingAnchor.constraint(equalTo: window.leadingAnchor),
                trailingAnchor.constraint(equalTo: window.trailingAnchor),
                topAnchor.constraint(equalTo: window.topAnchor),
                bottomAnchor.constraint(equalTo: window.bottomAnchor)
            ])
            
            activityIndicator.startAnimating()
        }
    }
    
    func hide() {
        activityIndicator.stopAnimating()
        removeFromSuperview()
    }
}
