// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorABC

extension ABCDumper {

    // MARK: Internal Instance Methods

    internal func format(_ annotation: ABCAnnotation) -> String {
        var result = annotation.text

        result += spacer()
        result += _format(annotation.placement)

        return result
    }

    internal func format(_ chordSymbol: ABCChordSymbol) -> String {
        var result = _format(chordSymbol.name)

        if let bass = chordSymbol.bass {
            result += "/"
            result += format(bass)
        }

        if let parenthesized = chordSymbol.parenthesized {
            result += " ("
            result += _format(parenthesized)
            result += ")"
        }

        return result
    }

    internal func format(_ decoration: ABCDecoration) -> String {
        var result = decoration.name.stringValue

        if decoration.dialect == .plus {
            result += spacer()
            result += "legacy"
        }

        return result
    }

    internal func format(_ shorthand: ABCShorthand) -> String {
        switch shorthand {
        case .dot:
            "."

        case .hLower:
            "h"

        case .hUpper:
            "H"

        case .iLower:
            "i"

        case .iUpper:
            "I"

        case .jLower:
            "j"

        case .jUpper:
            "J"

        case .kLower:
            "k"

        case .kUpper:
            "K"

        case .lLower:
            "l"

        case .lUpper:
            "L"

        case .mLower:
            "m"

        case .mUpper:
            "M"

        case .nLower:
            "n"

        case .nUpper:
            "N"

        case .oLower:
            "o"

        case .oUpper:
            "O"

        case .pLower:
            "p"

        case .pUpper:
            "P"

        case .qLower:
            "q"

        case .qUpper:
            "Q"

        case .rLower:
            "r"

        case .rUpper:
            "R"

        case .sLower:
            "s"

        case .sUpper:
            "S"

        case .tilde:
            "~"

        case .tLower:
            "t"

        case .tUpper:
            "T"

        case .uLower:
            "u"

        case .uUpper:
            "U"

        case .vLower:
            "v"

        case .vUpper:
            "V"

        case .wLower:
            "w"

        case .wUpper:
            "W"
        }
    }

    internal func format(_ userSymbol: ABCUserSymbol) -> String {
        var result = format(userSymbol.shorthand)

        result += spacer()

        switch userSymbol.definition {
        case nil:
            result += "nil"

        case let .annotation(annotation)?:
            result += format(annotation)

        case let .decoration(decoration)?:
            result += format(decoration)
        }

        return result
    }

    // MARK: Private Instance Methods

    private func _format(_ name: ABCChordSymbol.Name) -> String {
        var result = format(name.root)

        if let kind = name.kind {
            result += kind
        }

        return result
    }

    private func _format(_ placement: ABCAnnotation.Placement) -> String {
        switch placement {
        case .above:
            "Above"

        case .auto:
            "Auto"

        case .below:
            "Below"

        case .left:
            "Left"

        case .right:
            "Right"
        }
    }
}
