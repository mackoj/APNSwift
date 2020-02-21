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

public struct APNSwiftSigner {
    let signers: JWTSigners

    public init(keyIdentifier: String, key: ECDSAKey) {
        let signers = JWTSigners()
        signers.use(.es256(key: key), kid: .init(string: keyIdentifier), isDefault: true)
        self.signers = signers
    }

    public func sign(_ jwt: APNSwiftJWT) throws -> String {
        try self.signers.sign(jwt)
    }
}

extension ECDSAKey {
    public static func `private`(buffer: ByteBuffer) throws -> ECDSAKey {
        try .private(pem: buffer.readableBytesView)
    }

    public static func `private`(filePath: String) throws -> ECDSAKey {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
            throw APNSwiftError.SigningError.certificateFileDoesNotExist
        }
        var mutableByteBuffer = ByteBufferAllocator().buffer(capacity: data.count)
        mutableByteBuffer.writeBytes(data)
        return try self.private(pem: mutableByteBuffer.readableBytesView)
    }
}
