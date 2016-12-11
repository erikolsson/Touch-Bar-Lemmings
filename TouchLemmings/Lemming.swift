//
//  Lemming.swift
//  TouchLemmings
//
//  Created by Erik Olsson on 2016-12-11.
//  Copyright © 2016 Erik Olsson. All rights reserved.
//

import SpriteKit

enum Direction {
  case left
  case right

  func theOtherDirection () -> Direction {
    switch self {
    case .left:
      return .right
    case .right:
      return .left
    }
  }
}

enum State {
  case walking(direction: Direction)
  case blocking

  var size: CGSize {
    get {
      switch self {
      case .walking(_):
        return CGSize(width: 20, height: 30)
      case .blocking:
        return CGSize(width: 30, height: 30)
      }
    }
  }

}


class Lemming: SKSpriteNode {

  static let walkingCategory: UInt32 = 0x1 << 1;
  static let blockingCategory: UInt32 = 0x1 << 2;

  var state: State = .walking(direction: .left) {
    didSet {
      switch state {
      case .walking(let direction):
        walk(direction: direction)
      case .blocking:
        block()
      }

      size = state.size
    }
  }

  func toggleState() {
    switch state {
    case .walking:
      state = .blocking
    case .blocking:
      state = .walking(direction: .right)
    }
  }

  func walk(direction: Direction) {
    removeAllActions()
    let textures = SpriteLoader.loadWalkingTextures()
    let animate = SKAction.animate(with: textures, timePerFrame: 0.1)
    let walkAction = SKAction.repeatForever(animate)

    let reverse = direction == .right
    let moveAction = SKAction.moveBy(x: reverse ? 1000 : -1000, y: 0, duration: 60)
    xScale = reverse ? -1 : 1
    run(walkAction)
    run(moveAction)

    physicsBody?.categoryBitMask = Lemming.walkingCategory
    physicsBody?.contactTestBitMask = Lemming.blockingCategory
    physicsBody?.collisionBitMask = Lemming.blockingCategory
  }

  func block() {
    removeAllActions()

    let textures = SpriteLoader.loadBlockingTextures()
    let animate = SKAction.animate(with: textures, timePerFrame: 0.1)
    let blockAction = SKAction.repeatForever(SKAction.group([animate, animate.reversed()]))

    run(blockAction)

    physicsBody?.categoryBitMask = Lemming.blockingCategory
    physicsBody?.contactTestBitMask = Lemming.walkingCategory
    physicsBody?.collisionBitMask = Lemming.walkingCategory

  }

  init() {
    let texture = SpriteLoader.SpriteSheet
    super.init(texture: texture, color: NSColor.clear, size: State.blocking.size)
    physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 30))
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError()
  }
  
}
