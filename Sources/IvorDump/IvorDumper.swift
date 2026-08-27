// © 2025–2026 John Gary Pusey (see LICENSE.md)

public import Foundation

internal import XestiTools

/// A dumper of human-readable output for any recognized music notation file format.
public struct IvorDumper {

    // MARK: Public Initializers

    /// Creates a new dumper.
    public init() {
        self.stdio = StandardIO()
    }

    // MARK: Internal Instance Properties

    internal let stdio: StandardIO
}

// MARK: -

extension IvorDumper {

    // MARK: Public Instance Methods

    /// Dumps the contents of the specified file.
    ///
    /// - Parameter fileURL: The URL of the file to dump.
    ///
    /// - Returns: `true` if the file was dumped successfully; otherwise, `false`. Any error encountered is written to
    ///            standard error rather than thrown, so that a multi-file run can continue past a bad file.
    /// - Throws: ``IvorDumper/Error/dumpFailure(_:)``.
    @discardableResult
    public func dump(_ fileURL: URL) throws(Error) -> Bool {
        do {
            switch fileURL.pathExtension {
            case "abc":
                try ABCDumper(stdio).dump(fileURL)

            case "dkm",
                 "johnnysonic":
                try DKMDumper(stdio).dump(fileURL)

            case "gmn":
                try GMNDumper(stdio).dump(fileURL)

            case "mid",
                 "midi",
                 "smf":
                try SMFDumper(stdio).dump(fileURL)

            case "musicxml",
                 "mxl",
                 "xml":
                try MXLDumper(stdio).dump(fileURL)

            default:
                emitError("Unrecognized file format: “\(fileURL.path)”")

                return false
            }

            return true
        } catch let error as any EnhancedError {
            emitError(error.message)

            return false
        } catch {
            throw Error.dumpFailure(error as NSError)
        }
    }
}

// MARK: - Dumper

extension IvorDumper: Dumper {
}
