// Made With Flow.
//
// DO NOT MODIFY, your changes will be lost when this file is regenerated.
//

import UIKit

public class Timeline_1: Timeline {
    public convenience init(view: ArtboardView, duration: TimeInterval, autoreverses: Bool = false, repeatCount: Float = 0) {
        let animationsByLayer = Timeline_1.animationsByLayer(view: view, duration: duration)
        self.init(view: view, animationsByLayer: animationsByLayer, sounds: [], duration: duration, autoreverses: autoreverses, repeatCount: repeatCount)
    }
    private static func animationsByLayer(view: ArtboardView, duration: TimeInterval) -> [CALayer: [CAKeyframeAnimation]] {
        // Keyframe Animations for masteryIcon
        let position_y_masteryIcon: CAKeyframeAnimation = {
            let keyframeAnimation = CAKeyframeAnimation()
            keyframeAnimation.keyPath = "position.y"
            keyframeAnimation.values = [373.66, 309.66]
            keyframeAnimation.keyTimes = [0, 1] 
            keyframeAnimation.timingFunctions = [.easeInEaseOut]
            keyframeAnimation.duration = duration
            
            return keyframeAnimation
        }()
         
        // Keyframe Animations for leftFoot
        let position_x_leftFoot: CAKeyframeAnimation = {
            let keyframeAnimation = CAKeyframeAnimation()
            keyframeAnimation.keyPath = "position.x"
            keyframeAnimation.values = [22.7, 22.7, 96.93, 96.93]
            keyframeAnimation.keyTimes = [0, 0.36, 0.706667, 1] 
            keyframeAnimation.timingFunctions = [.linear, .easeInEaseOut, .easeInEaseOut]
            keyframeAnimation.duration = duration
            
            return keyframeAnimation
        }()
        let position_y_leftFoot: CAKeyframeAnimation = {
            let keyframeAnimation = CAKeyframeAnimation()
            keyframeAnimation.keyPath = "position.y"
            keyframeAnimation.values = [119.32, 119.32, 152.84, 152.84]
            keyframeAnimation.keyTimes = [0, 0.36, 0.706667, 1] 
            keyframeAnimation.timingFunctions = [.linear, .easeInEaseOut, .easeInEaseOut]
            keyframeAnimation.duration = duration
            
            return keyframeAnimation
        }()
        let transform_rotation_z_leftFoot: CAKeyframeAnimation = {
            let keyframeAnimation = CAKeyframeAnimation()
            keyframeAnimation.keyPath = "transform.rotation.z"
            keyframeAnimation.values = [-0.436332, -0.436332, 0, 0]
            keyframeAnimation.keyTimes = [0, 0.36, 0.706667, 1] 
            keyframeAnimation.timingFunctions = [.linear, .easeInEaseOut, .easeInEaseOut]
            keyframeAnimation.duration = duration
            
            return keyframeAnimation
        }()
        let opacity_leftFoot: CAKeyframeAnimation = {
            let keyframeAnimation = CAKeyframeAnimation()
            keyframeAnimation.keyPath = "opacity"
            keyframeAnimation.values = [0, 0, 1]
            keyframeAnimation.keyTimes = [0, 0.36, 1] 
            keyframeAnimation.timingFunctions = [.linear, CAMediaTimingFunction(controlPoints: 0.86, 0, 0.07, 1)]
            keyframeAnimation.duration = duration
            
            return keyframeAnimation
        }()
         
        // Keyframe Animations for rightFoot
        let position_x_rightFoot: CAKeyframeAnimation = {
            let keyframeAnimation = CAKeyframeAnimation()
            keyframeAnimation.keyPath = "position.x"
            keyframeAnimation.values = [244.31, 244.31, 162.9, 162.9]
            keyframeAnimation.keyTimes = [0, 0.36, 0.706667, 1] 
            keyframeAnimation.timingFunctions = [.linear, .easeInEaseOut, .easeInEaseOut]
            keyframeAnimation.duration = duration
            
            return keyframeAnimation
        }()
        let position_y_rightFoot: CAKeyframeAnimation = {
            let keyframeAnimation = CAKeyframeAnimation()
            keyframeAnimation.keyPath = "position.y"
            keyframeAnimation.values = [119.32, 119.32, 152.84, 152.84]
            keyframeAnimation.keyTimes = [0, 0.36, 0.706667, 1] 
            keyframeAnimation.timingFunctions = [.linear, .easeInEaseOut, .easeInEaseOut]
            keyframeAnimation.duration = duration
            
            return keyframeAnimation
        }()
        let transform_rotation_z_rightFoot: CAKeyframeAnimation = {
            let keyframeAnimation = CAKeyframeAnimation()
            keyframeAnimation.keyPath = "transform.rotation.z"
            keyframeAnimation.values = [-0.436332, -0.436332, 0, 0]
            keyframeAnimation.keyTimes = [0, 0.36, 0.706667, 1] 
            keyframeAnimation.timingFunctions = [.linear, .easeInEaseOut, .easeInEaseOut]
            keyframeAnimation.duration = duration
            
            return keyframeAnimation
        }()
        let opacity_rightFoot: CAKeyframeAnimation = {
            let keyframeAnimation = CAKeyframeAnimation()
            keyframeAnimation.keyPath = "opacity"
            keyframeAnimation.values = [0, 0, 1]
            keyframeAnimation.keyTimes = [0, 0.36, 1] 
            keyframeAnimation.timingFunctions = [.linear, CAMediaTimingFunction(controlPoints: 0.86, 0, 0.07, 1)]
            keyframeAnimation.duration = duration
            
            return keyframeAnimation
        }()
         
        // Keyframe Animations for leftArm
        let transform_rotation_z_leftArm: CAKeyframeAnimation = {
            let keyframeAnimation = CAKeyframeAnimation()
            keyframeAnimation.keyPath = "transform.rotation.z"
            keyframeAnimation.values = [0.785398, 0.785398, 0, 0]
            keyframeAnimation.keyTimes = [0, 0.18, 0.36, 1] 
            keyframeAnimation.timingFunctions = [.linear, .easeInEaseOut, .easeInEaseOut]
            keyframeAnimation.duration = duration
            
            return keyframeAnimation
        }()
        let opacity_leftArm: CAKeyframeAnimation = {
            let keyframeAnimation = CAKeyframeAnimation()
            keyframeAnimation.keyPath = "opacity"
            keyframeAnimation.values = [0, 0, 1, 1]
            keyframeAnimation.keyTimes = [0, 0.18, 0.54, 1] 
            keyframeAnimation.timingFunctions = [.linear, .easeInEaseOut, .easeInEaseOut]
            keyframeAnimation.duration = duration
            
            return keyframeAnimation
        }()
         
        // Keyframe Animations for rightArm
        let transform_rotation_z_rightArm: CAKeyframeAnimation = {
            let keyframeAnimation = CAKeyframeAnimation()
            keyframeAnimation.keyPath = "transform.rotation.z"
            keyframeAnimation.values = [-0.785398, -0.785398, 0, 0]
            keyframeAnimation.keyTimes = [0, 0.18, 0.36, 1] 
            keyframeAnimation.timingFunctions = [.linear, .easeInEaseOut, .easeInEaseOut]
            keyframeAnimation.duration = duration
            
            return keyframeAnimation
        }()
        let opacity_rightArm: CAKeyframeAnimation = {
            let keyframeAnimation = CAKeyframeAnimation()
            keyframeAnimation.keyPath = "opacity"
            keyframeAnimation.values = [0, 0, 1, 1]
            keyframeAnimation.keyTimes = [0, 0.18, 0.54, 1] 
            keyframeAnimation.timingFunctions = [.linear, .easeInEaseOut, .easeInEaseOut]
            keyframeAnimation.duration = duration
            
            return keyframeAnimation
        }()
         
        // Keyframe Animations for head
        let opacity_head: CAKeyframeAnimation = {
            let keyframeAnimation = CAKeyframeAnimation()
            keyframeAnimation.keyPath = "opacity"
            keyframeAnimation.values = [0, 1, 1]
            keyframeAnimation.keyTimes = [0, 0.54, 1] 
            keyframeAnimation.timingFunctions = [CAMediaTimingFunction(controlPoints: 0.86, 0, 0.07, 1), .easeInEaseOut]
            keyframeAnimation.duration = duration
            
            return keyframeAnimation
        }()
         
        // Keyframe Animations for shadowRight
        let opacity_shadowRight: CAKeyframeAnimation = {
            let keyframeAnimation = CAKeyframeAnimation()
            keyframeAnimation.keyPath = "opacity"
            keyframeAnimation.values = [0, 0, 1, 1]
            keyframeAnimation.keyTimes = [0, 0.36, 0.54, 1] 
            keyframeAnimation.timingFunctions = [.linear, .easeIn, .easeInEaseOut]
            keyframeAnimation.duration = duration
            
            return keyframeAnimation
        }()
         
        // Keyframe Animations for shadowLeft
        let opacity_shadowLeft: CAKeyframeAnimation = {
            let keyframeAnimation = CAKeyframeAnimation()
            keyframeAnimation.keyPath = "opacity"
            keyframeAnimation.values = [0, 0, 1, 1]
            keyframeAnimation.keyTimes = [0, 0.36, 0.54, 1] 
            keyframeAnimation.timingFunctions = [.linear, .easeIn, .easeInEaseOut]
            keyframeAnimation.duration = duration
            
            return keyframeAnimation
        }()
         
        // Organize CAKeyframeAnimations by CALayer
        var animationsByLayer = [CALayer: [CAKeyframeAnimation]]()
        animationsByLayer[view.leftFoot.layer] = [position_x_leftFoot, transform_rotation_z_leftFoot, position_y_leftFoot, opacity_leftFoot]
        animationsByLayer[view.shadowLeft.layer] = [opacity_shadowLeft]
        animationsByLayer[view.head.layer] = [opacity_head]
        animationsByLayer[view.leftArm.layer] = [transform_rotation_z_leftArm, opacity_leftArm]
        animationsByLayer[view.rightArm.layer] = [transform_rotation_z_rightArm, opacity_rightArm]
        animationsByLayer[view.rightFoot.layer] = [position_x_rightFoot, transform_rotation_z_rightFoot, position_y_rightFoot, opacity_rightFoot]
        animationsByLayer[view.masteryIcon.layer] = [position_y_masteryIcon]
        animationsByLayer[view.shadowRight.layer] = [opacity_shadowRight]

        return animationsByLayer 
    }
}