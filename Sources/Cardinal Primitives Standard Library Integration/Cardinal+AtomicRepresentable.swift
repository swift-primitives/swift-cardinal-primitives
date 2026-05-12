// ===----------------------------------------------------------------------===//
//
// This source file is part of the swift-primitives open source project
//
// Copyright (c) 2024-2026 Coen ten Thije Boonkkamp and the swift-primitives
// project authors. Licensed under Apache License v2.0
//
// See LICENSE for license information
//
// ===----------------------------------------------------------------------===//

#if SYNCHRONIZATION_AVAILABLE
    public import Synchronization

    // MARK: - Cardinal + AtomicRepresentable

    extension Cardinal: AtomicRepresentable {
        /// The atomic storage representation used to back ``Cardinal`` in ``Synchronization/Atomic``.
        ///
        /// Mirrors `UInt`'s atomic representation since `Cardinal` is a single-`UInt` value type.
        public typealias AtomicRepresentation = UInt.AtomicRepresentation

        /// Encodes a cardinal quantity into its atomic storage representation.
        @inlinable
        public static func encodeAtomicRepresentation(
            _ value: consuming Cardinal
        ) -> AtomicRepresentation {
            UInt.encodeAtomicRepresentation(value.rawValue)
        }

        /// Decodes an atomic storage representation back into a cardinal quantity.
        @inlinable
        public static func decodeAtomicRepresentation(
            _ representation: consuming AtomicRepresentation
        ) -> Cardinal {
            Cardinal(UInt.decodeAtomicRepresentation(representation))
        }
    }
#endif
