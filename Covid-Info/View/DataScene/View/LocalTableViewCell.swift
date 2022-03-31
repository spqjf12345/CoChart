//
//  LocalTableViewCell.swift
//  Covid-Info
//
//  Created by JoSoJeong on 2022/04/01.
//

import Foundation
import Combine
import SnapKit

class LocalTableViewCell: UITableViewCell {
    private var cancellables: Set<AnyCancellable> = []
    
    static let identifier = "LocalTableViewCell"
    
    @Published var title: String?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func congigure(){
        self.configureUI()
        self.bindUI()
    }
    
    func configureUI(){
        self.contentView.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func bindUI(){
        self.$title.receive(on: DispatchQueue.main)
            .sink { [weak self] title in
                self?.titleLabel.text = title
            }
            .store(in: &self.cancellables)
    }
}
