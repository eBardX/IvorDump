// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func format(_ kind: MXLHarmony.Chord.Kind) -> String {
        var result = _format(kind.value)

        if let text = kind.text {
            result += spacer()
            result += format(text)
        }

        append(&result, kind.usesSymbols, "Symbols", "No symbols")
        append(&result, kind.areDegreesStacked, "Degrees stacked", "Degrees not stacked")
        append(&result,
               kind.areDegreesInParentheses,
               "Degrees parenthesized",
               "Degrees not parenthesized")
        append(&result,
               kind.areDegreesBracketed,
               "Degrees bracketed",
               "Degrees not bracketed")

        return result
    }

    internal func format(_ symbol: MXLDegree.SymbolValue) -> String {
        switch symbol {
        case .augmented:
            "augmented"

        case .diminished:
            "diminished"

        case .halfDiminished:
            "half-diminished"

        case .major:
            "major"

        case .minor:
            "minor"
        }
    }

    internal func format(_ value: MXLDegree.Kind.Value) -> String {
        switch value {
        case .add:
            "Add"

        case .alter:
            "Alter"

        case .subtract:
            "Subtract"
        }
    }

    // MARK: Private Instance Methods

    private func _format(_ value: MXLHarmony.Chord.Kind.Value) -> String {
        switch value {
        case .augmented:
            "Augmented"

        case .augmentedSeventh:
            "Augmented seventh"

        case .diminished:
            "Diminished"

        case .diminishedSeventh:
            "Diminished seventh"

        case .dominant:
            "Dominant"

        case .dominant11th:
            "Dominant 11th"

        case .dominant13th:
            "Dominant 13th"

        case .dominantNinth:
            "Dominant ninth"

        case .french:
            "French"

        case .german:
            "German"

        case .halfDiminished:
            "Half-diminished"

        case .italian:
            "Italian"

        case .major:
            "Major"

        case .major11th:
            "Major 11th"

        case .major13th:
            "Major 13th"

        case .majorMinor:
            "Major-minor"

        case .majorNinth:
            "Major ninth"

        case .majorSeventh:
            "Major seventh"

        case .majorSixth:
            "Major sixth"

        case .minor:
            "Minor"

        case .minor11th:
            "Minor 11th"

        case .minor13th:
            "Minor 13th"

        case .minorNinth:
            "Minor ninth"

        case .minorSeventh:
            "Minor seventh"

        case .minorSixth:
            "Minor sixth"

        case .neapolitan:
            "Neapolitan"

        case .noChord:
            "No chord"

        case .other:
            "Other"

        case .pedal:
            "Pedal"

        case .power:
            "Power"

        case .suspendedFourth:
            "Suspended fourth"

        case .suspendedSecond:
            "Suspended second"

        case .tristan:
            "Tristan"
        }
    }
}
