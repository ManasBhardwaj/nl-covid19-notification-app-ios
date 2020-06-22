/*
 * Copyright (c) 2020 De Staat der Nederlanden, Ministerie van Volksgezondheid, Welzijn en Sport.
 *  Licensed under the EUROPEAN UNION PUBLIC LICENCE v. 1.2
 *
 *  SPDX-License-Identifier: EUPL-1.2
 */

@testable import ENCore
import Foundation
import SnapshotTesting
import XCTest

final class MessageViewControllerTests: XCTestCase {
    private var viewController: MessageViewController!
    private let listern = MessageListenerMock()

    override func setUp() {
        super.setUp()

        let theme = ENTheme()
        SnapshotTesting.record = false

        viewController = MessageViewController(listener: listern, theme: theme)
    }

    // MARK: - Tests

    func testSnapshotMessageViewController() {
        assertSnapshot(matching: viewController, as: .image(size: CGSize(width: 414, height: 1250)))
    }

    func testPresentationControllerDidDismissCallsListener() {
        listern.messageWantsDismissalHandler = { value in
            XCTAssertFalse(value)
        }

        viewController.presentationControllerDidDismiss(UIPresentationController(presentedViewController: viewController, presenting: nil))

        XCTAssertEqual(listern.messageWantsDismissalCallCount, 1)
    }
}
