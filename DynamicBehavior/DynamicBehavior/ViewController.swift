//
//  ViewController.swift
//  DynamicBehavior
//
//  Created by kooapps on 4/17/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var dynItem: UIView!
    @IBOutlet weak var anchor: UILabel!
    
    var ani: UIDynamicAnimator!
    var snapBe: UISnapBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        ani = UIDynamicAnimator(referenceView: view)
        
        //Attachment
        let be = UIAttachmentBehavior(item: dynItem, offsetFromCenter: UIOffset(horizontal: 25, vertical: 25), attachedToAnchor: anchor.center)

        ani.addBehavior(be)
        
        //Gravity
        let gravity = UIGravityBehavior(items: [dynItem])
        gravity.gravityDirection = CGVector(dx: 0.0, dy: 1.0)
        ani.addBehavior(gravity)
        
        //Collision
        let collision = UICollisionBehavior(items: [dynItem])
        collision.translatesReferenceBoundsIntoBoundary = true
        ani.addBehavior(collision)
        
        //push
        let push = UIPushBehavior(items: [dynItem], mode: .continuous)
        push.magnitude = 1.0
        push.angle = 45.0 / 180.0 * CGFloat.pi
        
        //or use
//        push.pushDirection = CGVector(dx: 0.1, dy: 0.8)
        
        ani.addBehavior(push)
        
    }

    @IBAction func panHandler(_ sender: UIPanGestureRecognizer) {
        let point = sender.location(in: view)
        
        anchor.center = point
        
        let be = ani.behaviors.first as! UIAttachmentBehavior
        be.anchorPoint = point
    }
    
    @IBAction func tapHandler(_ sender: UITapGestureRecognizer) {
        let point = sender.location(in: view)
        
        let snap = UISnapBehavior(item: dynItem, snapTo: point)
        snap.damping = 0.5
        
        if (snapBe != nil) {
            ani.removeBehavior(snapBe)
        }
        
        snapBe = snap
        ani.addBehavior(snap)
    }
    
}

