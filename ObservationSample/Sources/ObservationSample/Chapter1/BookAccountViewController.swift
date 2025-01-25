//
//  BookAccountViewController.swift
//  ObservationSample
//
//  Created by Shunya Yamada on 2025/01/25.
//

import UIKit

final class BookAccountViewController: UIViewController {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "book"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private lazy var borrowedStateLabel: UILabel = {
        let label = UILabel()
        label.text = "貸出可能"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var borrowedCountLabel: UILabel = {
        let label = UILabel()
        label.text = "貸出回数: 0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(
            .init { [weak self] _ in
                self?.changeBorrowed()
            },
            for: .touchUpInside
        )

        var configuration = UIButton.Configuration.filled()
        configuration.title = "この本を借りる"
        button.configuration = configuration
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let bookAccount = BookAccount()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews()

        tracking()
    }
}

private extension BookAccountViewController {
    func configureSubviews() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(borrowedStateLabel)
        stackView.addArrangedSubview(borrowedCountLabel)
        stackView.addArrangedSubview(button)
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    func tracking() {
        withObservationTracking { [weak self] in
            guard let self else { return }
            // プロパティ変更時の挙動を `apply` 内で定義する.
            // ここでアクセスした `isBorrowed` と `borrowdCount` プロパティが監視対象になる.
            if self.bookAccount.isBorrowed {
                self.borrowedStateLabel.text = "貸出中"
                self.button.setTitle("この本を貸す", for: .normal)
            } else {
                self.borrowedStateLabel.text = "貸出可能"
                self.button.setTitle("この本を借りる", for: .normal)
            }

            self.borrowedCountLabel.text = "貸出回数: \(self.bookAccount.borrowedCount)"
        } onChange: { [weak self] in
            guard let self else { return }
            Task { @MainActor in
                // `onChange` はプロパティの変更に付き 1 度しか実行されないため再起的に呼び出す必要がある.
                self.tracking()
            }
        }
    }

    func changeBorrowed() {
        bookAccount.switchBorrow()
    }
}

#Preview {
    BookAccountViewController()
}
