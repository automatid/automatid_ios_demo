//
//  OTMLLottieViewWrapper.swift
//  OTML
//
//  Created by Silvio D'Angelo on 30/01/24.
//

import UIKit
import Lottie

@objcMembers
public class HostingappLottieViewWrapper: UIView
{

    private let lottieView = LottieAnimationView()
    private var playing = false

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder: NSCoder) {
        super.init(coder: coder)   // ✅ fondamentale con Interface Builder
        commonInit()
    }

    private func commonInit() {
        lottieView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lottieView)

        NSLayoutConstraint.activate([
            lottieView.topAnchor.constraint(equalTo: topAnchor),
            lottieView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lottieView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lottieView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        // opzionale ma spesso utile
        lottieView.contentMode = .scaleAspectFit
        lottieView.clipsToBounds = true
    }

    public func stop() {
        if lottieView.isAnimationPlaying {
            lottieView.stop()
        }
    }

    public func reset() {
        stop()
        lottieView.currentProgress = 0
    }

    public func setAnimationLoop(_ shouldLoop: Bool) {
        lottieView.loopMode = shouldLoop ? .loop : .playOnce
    }

    public func setAnimation(json: String) {
        guard let data = json.data(using: .utf8) else {
            print("animationData error")
            return
        }
        setAnimation(jsonData: data)
    }

    private func setAnimation(jsonData: Data) {
        do {
            // puoi continuare col JSONDecoder, ma Lottie espone anche helper (vedi sotto)
            let animation = try JSONDecoder().decode(LottieAnimation.self, from: jsonData)
            lottieView.animation = animation
        } catch {
            print("animation error: \(error)")
        }

        // se la tua altezza dipende dall'intrinsic size (vedi sezione sotto)
        invalidateIntrinsicContentSize()
        setNeedsLayout()
    }


    public func play(completion: @escaping (Bool) -> Void) -> Void {
        if !playing {
            playing = true
            lottieView.play { animationEnded in
                print("lottie.play")
                self.playing = false
                completion(animationEnded)
            }
        } 

    }

    public func setAnimation(fileName: String){
        let filePath = Bundle.main.path(forResource: fileName, ofType: "json")!
        let url = URL(fileURLWithPath: filePath)
        do {
            let jsonData = try Data(contentsOf: url, options: .alwaysMapped)
            self.setAnimation(jsonData: jsonData)
        } catch let error {
            print("setAnimation error:\(error)")
        }


    }
    public func play() -> Void {
        self.play { _ in

        }
    }
}
