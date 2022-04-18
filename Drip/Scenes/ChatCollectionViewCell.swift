import UIKit
import Kingfisher

final class ChatCollectionViewCell: UICollectionViewCell {
    private let blurredView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private let image = UIImageView()
    private let name = UILabel()
    private let message = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        blurredView.layer.cornerRadius = 12
        blurredView.clipsToBounds = true
        
        name.font = .boldSystemFont(ofSize: 20)
        name.text = "Лёша"
        
        message.font = .systemFont(ofSize: 13)
        message.text = "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text"
        
        image.layer.cornerRadius = contentView.bounds.height / 2.0 * 0.7
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        
        
        contentView.addSubview(blurredView)
        contentView.addSubview(image)
        contentView.addSubview(name)
        contentView.addSubview(message)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        blurredView.pin
            .all()
        image.pin
            .left(to: contentView.edge.left)
            .vCenter()
            .height(contentView.bounds.height * 0.7)
            .width(contentView.bounds.height * 0.7)
            .marginLeft(contentView.bounds.height * 0.15)
        name.pin
            .top(to:contentView.edge.top)
            .left(to: image.edge.right)
            .marginLeft(contentView.bounds.height * 0.15)
            .marginTop(contentView.bounds.height * 0.2)
            .sizeToFit()
        message.pin
            .below(of: name)
            .left(to: image.edge.right)
            .right(to: contentView.edge.right)
            .bottom(to: contentView.edge.bottom)
            .marginLeft(contentView.bounds.height * 0.15)
            .marginRight(contentView.bounds.height * 0.2)
            .marginBottom(contentView.bounds.height * 0.25)
    }
    
    func configure(with urlString: String) {
        image.kf.setImage(with: URL(string: urlString))
    }
}
