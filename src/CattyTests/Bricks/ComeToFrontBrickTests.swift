/**
 *  Copyright (C) 2010-2020 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

import XCTest

@testable import Pocket_Code

final class ComeToFrontBrickTests: AbstractBrickTest {

    func testComeToFrontBrick() {
        let project = Project()
        let background = SpriteObject()
        let spriteNodeBG = CBSpriteNode(spriteObject: background)
        background.spriteNode = spriteNodeBG
        background.project = project

        let object1 = SpriteObject()
        let spriteNode1 = CBSpriteNode(spriteObject: object1)
        object1.spriteNode = spriteNode1
        object1.project = project
        spriteNode1.zPosition = 1

        let object2 = SpriteObject()
        let spriteNode2 = CBSpriteNode(spriteObject: object2)
        object2.spriteNode = spriteNode2
        spriteNode2.zPosition = 2

        project.objectList.add(background)
        project.objectList.add(object1)
        project.objectList.add(object2)

        let script = WhenScript()
        script.object = object1
        let brick = ComeToFrontBrick()
        brick.script = script
        let action = brick.actionBlock()
        action()

        XCTAssertEqual(spriteNode1.zPosition, CGFloat(2.0), "ComeToFront is not correctly calculated")
        XCTAssertEqual(spriteNode2.zPosition, CGFloat(1.0), "ComeToFront is not correctly calculated")
    }

    func testMutableCopy() {
        let brick = ComeToFrontBrick()

        let copiedBrick: ComeToFrontBrick = brick.mutableCopy(with: CBMutableCopyContext()) as! ComeToFrontBrick

        XCTAssertTrue(brick.isEqual(to: copiedBrick))
        XCTAssertFalse(brick === copiedBrick)
    }
}
