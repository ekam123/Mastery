// Made With Flow.
//
// DO NOT MODIFY, your changes will be lost when this file is regenerated.
//

import UIKit

public class ArtboardViewController: UIViewController {
    @IBOutlet public weak var artboard: ArtboardView!
    public var timeline: Timeline_1!

    public override func viewDidLoad() {
        super.viewDidLoad()
        artboard.clipsToBounds = true
        timeline = Timeline_1(view: artboard, duration: 1.5)

        timeline.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + timeline.duration) {
            self.showStartViewController()
        }
    }

    private func showStartViewController() {
        let storyboard = UIStoryboard(name: "HiFi", bundle: nil)
        let startViewController = storyboard.instantiateViewController(withIdentifier: "HiFiBegin")
        startViewController.modalPresentationStyle = .custom
        startViewController.modalTransitionStyle = .crossDissolve
        present(startViewController, animated: true, completion: nil)
    }
}
