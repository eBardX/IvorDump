// © 2025–2026 John Gary Pusey (see LICENSE.md)

public import Foundation
public import XestiTools

public struct IvorDumper {

    // MARK: Public Initializers

    public init(stdio: StandardIO) {
        self.stdio = stdio
    }

    // MARK: Public Methods

    public func dump(_ fileURL: URL) throws {
        do {
            switch fileURL.pathExtension {
            case "abc":
                try dumpABC(fileURL)

            case "dkm",
                 "johnnysonic":
                try dumpJohnnySonic(fileURL)

            case "gmn":
                try dumpGuido(fileURL)

            case "mid",
                 "midi",
                 "smf":
                try dumpMIDI(fileURL)

            case "musicxml",
                 "mxl",
                 "xml":
                try dumpMusicXML(fileURL)

            default:
                emitError("Unrecognized file format: “\(fileURL.path)”")
            }
        } catch let error as any EnhancedError {
            emitError(error.message)
        }
    }

    // MARK: Private Instance Properties

    private let stdio: StandardIO
}

// MARK: -

extension IvorDumper {

    // MARK: Internal Instance Methods

    internal func emit(_ line: String = "") {
        stdio.writeOutput(line)
    }

    internal func emitError(_ message: String) {
        stdio.writeError(message)
    }
}
