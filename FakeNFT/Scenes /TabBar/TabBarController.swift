import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }

    private func setupTabBar() {
        tabBar.tintColor = .Universal.blue
        tabBar.unselectedItemTintColor = .Themed.black
        tabBar.backgroundColor = .Themed.white
        tabBar.isTranslucent = false

        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.Medium.size10], for: .normal
        )
        UITabBarItem.appearance().setTitleTextAttributes(
            [NSAttributedString.Key.font: UIFont.Medium.size10], for: .selected
        )
    }
}
