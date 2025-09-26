import UIKit

// Варианты сумм поддержки
enum PayVariant: Int, CaseIterable {
	case small = 100
	case middle = 300
	case big = 500
}

class ViewController: UIViewController {
	
	private lazy var textStack: UIStackView = {
		let stack = UIStackView()
		stack.axis = .vertical
		stack.spacing = 10
		stack.translatesAutoresizingMaskIntoConstraints = false
		return stack
	}()
	
	private lazy var image: UIImageView = {
		let image = UIImageView(image: UIImage(systemName: "person.circle.fill"))
		image.translatesAutoresizingMaskIntoConstraints = false
		image.contentMode = .scaleToFill
		image.heightAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
		image.widthAnchor.constraint(equalToConstant: view.frame.height / 3).isActive = true
		image.tintColor = .white
		return image
	}()
	
	private lazy var btnPay: UIButton = {
		let btn = UIButton(primaryAction: payBtnAction)
		btn.setTitle("Поддержать", for: .normal)
		btn.setTitleColor(.white, for: .normal)
		btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
		btn.layer.cornerRadius = 20
		btn.backgroundColor = UIColor(named: "DarkGreen")
		btn.titleLabel?.textAlignment = .center
		btn.translatesAutoresizingMaskIntoConstraints = false
		return btn
	}()
	
	private lazy var payBtnAction = UIAction { _ in
		print(self.selectedPrice)
	}
	
	private var selectedPrice = 100
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = UIColor(named: "Main")
		setCircles()
		setImage()
		setText()
		setVariants()
		setBtn()
	}
	
	private func setBtn() {
		view.addSubview(btnPay)
		btnPay.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
		btnPay.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		btnPay.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85).isActive = true
		btnPay.heightAnchor.constraint(equalToConstant: 50).isActive = true
	}
	
	private func setVariants() {
		let variantsStack = UIStackView()
		variantsStack.axis = .horizontal
		variantsStack.spacing = 0
		variantsStack.distribution = .equalSpacing
		variantsStack.alignment = .center
		variantsStack.translatesAutoresizingMaskIntoConstraints = false
		
		view.addSubview(variantsStack)
		
		PayVariant.allCases.forEach { variant in
			variantsStack.addArrangedSubview(createPayVariants(variant: variant))
		}
		
		NSLayoutConstraint.activate([
			variantsStack.topAnchor.constraint(equalTo: textStack.bottomAnchor, constant: 50),
			variantsStack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			variantsStack.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85)
		])
	}
	
	private func setText() {
		view.addSubview(textStack)
		
		let pageTitle = createLabel(size: 30, weight: .bold, text: "Приложение и все его функции бесплатные")
		let pageSubTitle = createLabel(size: 16, weight: .regular, text: "Все средства идут на улучшение и поддержку проекта")
		
		textStack.addArrangedSubview(pageTitle)
		textStack.addArrangedSubview(pageSubTitle)
		
		textStack.widthAnchor.constraint(equalToConstant: view.frame.width * 0.85).isActive = true
		textStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
		textStack.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 20).isActive = true
	}
	
	private func setImage () {
		view.addSubview(image)
		image.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
		image.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
	}
	
	private func setCircles () {
		let circle1 = getCircle(frame: CGRect(x: view.frame.width - 74, y: -28, width: 100, height: 100))
		let circle2 = getCircle(frame: CGRect(x: view.frame.maxX / 2 - 200, y: 200, width: 200, height: 200))
		let circle3 = getCircle(frame: CGRect(x: view.frame.maxX / 2 - 50, y: 500, width: 150, height: 150))
		for circle in [circle1, circle2, circle3] {
			view.addSubview(circle)
		}
	}
	
	private func getCircle (frame: CGRect) -> UIView {
		let circleView = UIView()
		circleView.frame = frame
		circleView.layer.cornerRadius = frame.width / 2
		circleView.backgroundColor = UIColor(named: "Circle")
		return circleView
	}
	
	private func createLabel (size: CGFloat, weight: UIFont.Weight, text: String) -> UILabel {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		label.font = UIFont.systemFont(ofSize: size, weight: weight)
		label.textColor = .white
		label.numberOfLines = 0
		label.text = text
		return label
	}
	
	@objc func selectVariant (sender: UITapGestureRecognizer) {
		
		PayVariant.allCases.forEach { variant in
			if let sView = self.view.viewWithTag(variant.rawValue) {
				sView.layer.borderColor = .none
				sView.layer.borderWidth = 0
			}
		}
		
		if let selectedTag = sender.view?.tag {
			if let selectedView = self.view.viewWithTag(selectedTag) {
				selectedView.layer.borderColor = UIColor.white.cgColor
				selectedView.layer.borderWidth = 2
				selectedPrice = selectedTag
			}
		}
	}
	
	private func createPayVariants (variant: PayVariant) -> UIView {
		
		let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectVariant))
		
		let payView = UIView()
		payView.translatesAutoresizingMaskIntoConstraints = false
		payView.widthAnchor.constraint(equalToConstant: 100).isActive = true
		payView.heightAnchor.constraint(equalToConstant: 100).isActive = true
		payView.layer.cornerRadius = 20
		payView.tag = variant.rawValue
		payView.addGestureRecognizer(tapGesture)
		
		switch variant {
		case .small:
			payView.backgroundColor = .orange
			payView.layer.borderWidth = 2
			payView.layer.borderColor = UIColor.white.cgColor
		case .middle:
			payView.backgroundColor = UIColor(named: "MyGreen")
		case .big:
			payView.backgroundColor = UIColor(named: "DarkGreen")
		}
		
		let vStack = UIStackView()
		vStack.axis = .vertical
		vStack.spacing = 0
		vStack.translatesAutoresizingMaskIntoConstraints = false
		
		let summLabel = createLabel(size: 31, weight: .bold, text: String(variant.rawValue))
		summLabel.textAlignment = .center
		let summDescr = createLabel(size: 16, weight: .light, text: "рублей")
		summDescr.textAlignment = .center
		
		vStack.addArrangedSubview(summLabel)
		vStack.addArrangedSubview(summDescr)
		
		payView.addSubview(vStack)
		
		NSLayoutConstraint.activate([
			vStack.topAnchor.constraint(equalTo: payView.topAnchor, constant: 23),
			vStack.bottomAnchor.constraint(equalTo: payView.bottomAnchor, constant: -23),
			vStack.centerXAnchor.constraint(equalTo: payView.centerXAnchor)
		])
		
		return payView
	}
}

