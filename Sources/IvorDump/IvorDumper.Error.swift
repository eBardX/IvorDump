// © 2026 John Gary Pusey (see LICENSE.md)

public import XestiTools

extension IvorDumper {

    /// An error that occurs when dumping the contents of a file.
    public enum Error {
        /// A failure to dump the file, with an optional underlying error.
        case dumpFailure((any EnhancedError)?)
    }
}

// MARK: - EnhancedError

extension IvorDumper.Error: EnhancedError {
    /// The error category identifying the source module.
    public var category: Category? {
        Category("IvorDump")
    }

    /// The underlying error that caused this error, if any.
    public var cause: (any EnhancedError)? {
        switch self {
        case let .dumpFailure(error):
            error
        }
    }

    /// A human-readable description of this error.
    public var message: String {
        switch self {
        case .dumpFailure:
            "Unable to dump file"
        }
    }
}

// MARK: - Sendable

extension IvorDumper.Error: Sendable {
}
