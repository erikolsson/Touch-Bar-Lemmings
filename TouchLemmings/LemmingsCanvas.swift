//
//  LemmingsCanvas.swift
//  TouchLemmings
//
//  Created by Erik Olsson on 2016-12-10.
//  Copyright © 2016 Erik Olsson. All rights reserved.
//

import Cocoa
import SpriteKit

class LemmingsCanvas: SKView {

  override func awakeFromNib() {
    super.awakeFromNib()
    let scene = LemmmingsScene(size: frame.size)
    scene.isUserInteractionEnabled = true
    presentScene(scene)
    scene.scaleMode = .resizeFill
    scene.physicsWorld.gravity = CGVector.init(dx: 0, dy: 0)
    scene.physicsWorld.contactDelegate = scene
  }

  override func touchesBegan(with event: NSEvent) {
    scene?.touchesBegan(with: event)
  }


}

