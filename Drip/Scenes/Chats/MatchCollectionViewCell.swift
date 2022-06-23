import UIKit
import Kingfisher

final class MatchCollectionViewCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let matchName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        matchName.font = .boldSystemFont(ofSize: 13)
        
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        contentView.addSubview(imageView)
        contentView.addSubview(matchName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        matchName.pin
            .bottom(to: contentView.edge.bottom)
            .hCenter()
            .sizeToFit()
        imageView.pin
            .top(to: contentView.edge.top)
            .left(to: contentView.edge.left)
            .right(to: contentView.edge.right)
            .bottom(to: matchName.edge.top)
            .marginBottom(5)
    }
    
    func configure(with urlString: String, name: String) {
        imageView.kf.setImage(with: URL(string: urlString))
        matchName.text = name
    }
}
