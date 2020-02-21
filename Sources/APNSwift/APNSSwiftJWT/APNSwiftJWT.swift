//===----------------------------------------------------------------------===//
//
// This source file is part of the APNSwift open source project
//
// Copyright (c) 2019 the APNSwift project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of APNSwift project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//

import JWTKit
import Foundation
import NIO

public struct APNSwiftJWT: JWTPayload {
    enum CodingKeys: String, CodingKey {
        case teamID = "iss"
        case issueDate = "iat"
    }

    /// iss
    public let teamID: String

    /// iat
    public let issueDate: Date

    public init(teamID: String, issueDate: Date) {
        self.teamID = teamID
        self.issueDate = issueDate
    }
    
    public func verify(using signer: JWTSigner) throws {
        // do nothing
    }
}
