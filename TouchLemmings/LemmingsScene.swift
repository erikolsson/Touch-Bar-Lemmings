//
//  LemmingsScene.swift
//  TouchLemmings
//
//  Created by Erik Olsson on 2016-12-11.
//  Copyright © 2016 Erik Olsson. All rights reserved.
//

import SpriteKit

class LemmmingsScene: SKScene, SKPhysicsContactDelegate {

  var lemmings = [Lemming]()

  func didBegin(_ contact: SKPhysicsContact) {
    if let lemmingA = contact.bodyA.node as? Lemming,
      let lemmingB = contact.bodyB.node as? Lemming {

      if case State.walking(let direction) = lemmingA.state {
        lemmingA.state = .walking(direction: direction.theOtherDirection())
      }

      if case State.walking(let direction) = lemmingB.state {
        lemmingB.state = .walking(direction: direction.theOtherDirection())
      }
    }
  }

  func addLemming(at: CGPoint) {
    let l = Lemming()
    scene?.addChild(l)
    l.position = at
    l.state = .walking(direction: .left)
    lemmings.append(l)
  }

  func lemmingAt(point: CGPoint) -> Lemming? {
    return lemmings.filter { $0.contains(point) }.first
  }

  override func touchesBegan(with event: NSEvent) {
    if #available(OSX 10.12.1, *) {
      if let touch = event.allTouches().first {
        let location = CGPoint(x: touch.location(in: self.view).x, y: 14)

        if let lemming = lemmingAt(point: location) {
          lemming.toggleState()
        }
        else {
          addLemming(at: location)
        }

      }
    }
  }

}

