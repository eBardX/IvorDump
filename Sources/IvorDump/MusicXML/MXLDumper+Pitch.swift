// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func format(_ accidental: MXLAccidental) -> String {
        var result = format(accidental.value)

        append(&result, accidental.isCautionary, "Cautionary", "Not cautionary")
        append(&result, accidental.isEditorial, "Editorial", "Not editorial")
        append(&result, format(accidental.levelDisplay))
        append(&result, accidental.smufl.map { format($0.stringValue) })
        append(&result, format(accidental.position))
        append(&result, format(accidental.font))
        append(&result, accidental.color.map { format($0) })

        return result
    }

    internal func format(_ display: MXLLevel.Display) -> String? {
        var parts: [String] = []

        if display.hasParentheses == true {
            parts.append("Parenthesized")
        }

        if display.hasBracket == true {
            parts.append("Bracketed")
        }

        if let size = display.size {
            parts.append(format(size))
        }

        return parts.isEmpty ? nil : parts.joined(separator: spacer())
    }

    internal func format(_ kind: MXLNote.Kind) -> String {
        var result = format(kind.value)

        if let size = kind.size,
           size != .full {
            result += spacer()
            result += format(size)
        }

        return result
    }

    internal func format(_ level: MXLLevel) -> String {
        var result = "Level "

        result += format(level.value)

        append(&result, level.isReferenceOnly, "Reference only", "Not reference only")
        append(&result, format(level.display))

        return result
    }

    internal func format(_ pitch: MXLPitch) -> String {
        var result = format(pitch.step)

        if let alter = pitch.alter {
            result += formatAlter(alter)
        }

        result += format(pitch.octave.uintValue)

        return result
    }

    internal func format(_ size: MXLSymbolSize) -> String {
        switch size {
        case .cue:
            "Cue size"

        case .full:
            "Full size"

        case .graceCue:
            "Grace-cue size"

        case .large:
            "Large size"
        }
    }

    internal func format(_ step: MXLStep) -> String {
        switch step {
        case .a:
            "A"

        case .b:
            "B"

        case .c:
            "C"

        case .d:
            "D"

        case .e:
            "E"

        case .f:
            "F"

        case .g:
            "G"
        }
    }

    internal func format(_ value: MXLAccidentalValue) -> String {
        switch value {
        case .arrowDown:
            "Arrow-down"

        case .arrowUp:
            "Arrow-up"

        case .doubleSharp:
            "Double-sharp"

        case .doubleSharpDown:
            "Double-sharp-down"

        case .doubleSharpUp:
            "Double-sharp-up"

        case .doubleSlashFlat:
            "Double-slash-flat"

        case .flat:
            "Flat"

        case .flat1:
            "Flat-1"

        case .flat2:
            "Flat-2"

        case .flat3:
            "Flat-3"

        case .flat4:
            "Flat-4"

        case .flatDown:
            "Flat-down"

        case .flatFlat:
            "Flat-flat"

        case .flatFlatDown:
            "Flat-flat-down"

        case .flatFlatUp:
            "Flat-flat-up"

        case .flatUp:
            "Flat-up"

        case .koron:
            "Koron"

        case .natural:
            "Natural"

        case .naturalDown:
            "Natural-down"

        case .naturalFlat:
            "Natural-sharp"

        case .naturalSharp:
            "♮♯"

        case .naturalUp:
            "Natural-up"

        case .other:
            "Other"

        case .quarterFlat:
            "Quarter-flat"

        case .quarterSharp:
            "Quarter-sharp"

        case .sharp:
            "Sharp"

        case .sharp1:
            "Sharp-1"

        case .sharp2:
            "Sharp-2"

        case .sharp3:
            "Sharp-3"

        case .sharp5:
            "Sharp-5"

        case .sharpDown:
            "Sharp-down"

        case .sharpSharp:
            "Sharp-sharp"

        case .sharpUp:
            "Sharp-up"

        case .slashFlat:
            "Slash-flat"

        case .slashQuarterSharp:
            "Slash-quarter-sharp"

        case .slashSharp:
            "Slash-sharp"

        case .sori:
            "Sori"

        case .threeQuartersFlat:
            "Three-quarters-flat"

        case .threeQuartersSharp:
            "Three-quarters-sharp"

        case .tripleFlat:
            "Triple-flat"

        case .tripleSharp:
            "Triple-sharp"
        }
    }

    internal func format(_ value: MXLNoteKindValue) -> String {
        switch value {
        case .breve:
            "Breve"

        case .eighth:
            "Eighth"

        case .half:
            "Half"

        case .long:
            "Long"

        case .maxima:
            "Maxima"

        case .n1024th:
            "1024th"

        case .n128th:
            "128th"

        case .n16th:
            "16th"

        case .n256th:
            "256th"

        case .n32nd:
            "32nd"

        case .n512th:
            "512th"

        case .n64th:
            "64th"

        case .quarter:
            "Quarter"

        case .whole:
            "Whole"
        }
    }

    internal func formatAlter(_ alter: MXLSemitones) -> String {
        switch alter {
        case -2:
            "𝄫"

        case -1:
            "♭"

        case 0:
            "♮"

        case 1:
            "♯"

        case 2:
            "𝄪"

        default:
            " (" + format(alter) + ")"
        }
    }
}
