//
//  HomeBackgroundView.swift
//  Netflix Clone
//
//  Created by Mohanad Ramdan on 22/11/2023.
//

import UIKit

class HomeBackgroundUIView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backGroundPoster)
        
        blurEffect.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height )
        addSubview(blurEffect)
        
        
     
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backGroundPoster.frame = bounds
    }
    
    public func configureHeaderPoster(with model: MovieViewModel){
        DispatchQueue.main.async { [weak self] in
            guard let url = URL(string: "https://image.tmdb.org/t/p/w780\(model.posterPath)") else {return}
            self?.backGroundPoster.sd_setImage(with: url)
//            if let dominantCGColor = UIColor.dominantColor(from: backGroundPoster) {
//                print("Dominant CGColor: \(dominantCGColor)")
//            } else{
//                print("not found")
//            }
        }
        
    }
    
    
    private let blurEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        return visualEffectView
    }()
    
    
    private let backGroundPoster: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        return backgroundImage
    }()
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//extension UIColor {
//    static func dominantColor(from imageView: UIImageView) -> CGColor? {
//        guard let image = imageView.image else { return nil }
//
//        guard let inputImage = CIImage(image: image) else { return nil }
//        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
//
//        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]),
//              let outputImage = filter.outputImage else { return nil }
//
//        var bitmap = [UInt8](repeating: 0, count: 4)
//        let context = CIContext(options: nil)
//        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
//
//        let dominantColor = UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: CGFloat(bitmap[3]) / 255.0)
//
//        return dominantColor.cgColor
//    }
//}
