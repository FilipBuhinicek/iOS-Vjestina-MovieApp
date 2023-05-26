import Foundation
import PureLayout

class MyCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: MyCell.self)

    let titleLabel = UILabel()
    let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createViews()
        styleViews()
        defineLayoutForViwes()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with member: CrewMember) {
        titleLabel.text = member.name
        subtitleLabel.text = member.role
    }
    
    func createViews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    func styleViews() {
        titleLabel.textAlignment = .center
        titleLabel.textColor = .black
        titleLabel.font = .boldSystemFont(ofSize: 12)
        
        subtitleLabel.textAlignment = .center
        subtitleLabel.textColor = .black
        subtitleLabel.font = .systemFont(ofSize: 12)
    }
    
    func defineLayoutForViwes() {
        titleLabel.autoPinEdge(toSuperviewEdge: .top)
        titleLabel.autoPinEdge(toSuperviewEdge: .leading)
        titleLabel.autoPinEdge(toSuperviewEdge: .trailing)
        
        subtitleLabel.autoPinEdge(toSuperviewEdge: .leading)
        subtitleLabel.autoPinEdge(toSuperviewEdge: .trailing)
        subtitleLabel.autoPinEdge(.top, to: .bottom, of: titleLabel)
        subtitleLabel.autoPinEdge(toSuperviewEdge: .bottom)
    }
}
