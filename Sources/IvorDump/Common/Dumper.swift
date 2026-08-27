// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import Foundation
internal import XestiText
internal import XestiTools

internal protocol Dumper {

    // MARK: Internal Instance Properties

    var stdio: StandardIO { get }
}

// MARK: -

extension Dumper {

    // MARK: Internal Instance Methods

    internal func emit(_ indent: Int,
                       _ line: String) {
        if indent > 0, !line.isEmpty {
            emit(" ".repeating(to: indent) + line)
        } else {
            emit(line)
        }
    }

    internal func emit(_ line: String = "") {
        stdio.writeOutput(line)
    }

    internal func emitError(_ message: String) {
        stdio.writeError(message)
    }

    internal func format(_ value: Int) -> String {
        intFormatStyle.format(value)
    }

    internal func format(_ value: String) -> String {
        var result = "\""

        for chr in value {
            result += _formatCharacter(chr)
        }

        result += "\""

        return result
    }

    internal func format(_ value: UInt) -> String {
        uintFormatStyle.format(value)
    }

    internal func format(_ value: Int,
                         _ units: String,
                         plural: String? = nil) -> String {
        var result = format(value)

        result += " "
        result += value != 1 ? (plural ?? units + "s") : units

        return result
    }

    internal func format(_ value: UInt,
                         _ units: String,
                         plural: String? = nil) -> String {
        var result = format(value)

        result += " "
        result += value != 1 ? (plural ?? units + "s") : units

        return result
    }

    internal func format(_ value: Double,
                         precision: some RangeExpression<Int> = 0...3) -> String {
        doubleFormatStyle.precision(.fractionLength(precision)).format(value)
    }

    internal func readFile(_ fileURL: URL) throws -> Data {
        let file = try FileWrapper(url: fileURL,
                                   options: .immediate)

        return try file.contentsOfRegularFile()
    }

    internal func spacer() -> String {
        " ∙ "
    }
}

// MARK: Private Constants

private let doubleFormatStyle = FloatingPointFormatStyle<Double>().grouping(.automatic)
private let intFormatStyle = IntegerFormatStyle<Int>().grouping(.automatic)
private let uintFormatStyle = IntegerFormatStyle<UInt>().grouping(.automatic)

// MARK: Private Functions

private func _formatCharacter(_ value: Character) -> String {
    switch value {
    case "\u{00}":
        "\\0"

    case "\u{09}":
        "\\t"

    case "\u{0a}":
        "\\n"

    case "\u{0d}":
        "\\r"

    case "\"":
        "\\\""

    case "\\":
        "\\\\"

    default:
        String(value)
    }
}
