// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorABC

extension ABCDumper {

    // MARK: Internal Instance Methods

    internal func format(_ clef: ABCClef) -> String {
        var items: [String] = []

        if let name = clef.name {
            items.append(name.stringValue)
        }

        if clef.line != ABCClef.defaultLine(for: clef.name) {
            items.append("line " + format(clef.line))
        }

        if let ottava = clef.ottava {
            items.append(_format(ottava))
        }

        if let middle = clef.middle {
            items.append("middle " + _format(middle))
        }

        if clef.transpose != 0 {
            items.append("transpose " + formatSigned(clef.transpose))
        }

        if clef.octave != 0 {
            items.append("octave " + formatSigned(clef.octave))
        }

        if clef.stafflines != 5 {
            items.append(format(clef.stafflines, "staffline"))
        }

        return items.joined(separator: spacer())
    }

    internal func format(_ keySignature: ABCKeySignature) -> String {
        var result = ""

        switch keySignature {
        case let .clefOnly(clef):
            result += "Clef"

            let clefStr = format(clef)

            if !clefStr.isEmpty {
                result += spacer()
                result += clefStr
            }

        case .empty:
            result += "Empty"

        case .highlandPipes:
            result += "Highland pipes"

        case .highlandPipesPreset:
            result += "Highland pipes (preset)"

        case let .standard(standard):
            result += format(standard.tonic)
            result += " "
            result += _format(standard.mode)

            for accidental in standard.extraAccidentals {
                result += spacer()
                result += format(accidental)
            }

            if let clef = standard.clef {
                let clefStr = format(clef)

                if !clefStr.isEmpty {
                    result += spacer()
                    result += clefStr
                }
            }
        }

        return result
    }

    internal func format(_ pitch: ABCPitch) -> String {
        _format(pitch.letter) + _format(pitch.accidental) + String(pitch.octave.uintValue)
    }

    internal func format(_ tonic: ABCKeySignature.Tonic) -> String {
        switch tonic {
        case .a:
            "A"

        case .aFlat:
            "A♭"

        case .aSharp:
            "A♯"

        case .b:
            "B"

        case .bFlat:
            "B♭"

        case .bSharp:
            "B♯"

        case .c:
            "C"

        case .cFlat:
            "C♭"

        case .cSharp:
            "C♯"

        case .d:
            "D"

        case .dFlat:
            "D♭"

        case .dSharp:
            "D♯"

        case .e:
            "E"

        case .eFlat:
            "E♭"

        case .eSharp:
            "E♯"

        case .f:
            "F"

        case .fFlat:
            "F♭"

        case .fSharp:
            "F♯"

        case .g:
            "G"

        case .gFlat:
            "G♭"

        case .gSharp:
            "G♯"
        }
    }

    // MARK: Private Instance Methods

    private func _format(_ accidental: ABCPitch.Accidental) -> String {
        switch accidental {
        case .doubleFlat:
            "𝄫"

        case .doubleSharp:
            "𝄪"

        case .flat:
            "♭"

        case .natural:
            "♮"

        case .omitted:
            ""

        case .sharp:
            "♯"
        }
    }

    private func _format(_ letter: ABCPitch.Letter) -> String {
        switch letter {
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

    private func _format(_ middle: ABCClef.Middle) -> String {
        _format(middle.letter) + format(middle.octave.uintValue)
    }

    private func _format(_ mode: ABCKeySignature.Mode) -> String {
        switch mode {
        case .aeolian:
            "aeolian"

        case .dorian:
            "dorian"

        case .explicit:
            "explicit"

        case .ionian:
            "ionian"

        case .locrian:
            "locrian"

        case .lydian:
            "lydian"

        case .major:
            "major"

        case .minor:
            "minor"

        case .mixolydian:
            "mixolydian"

        case .phrygian:
            "phrygian"
        }
    }

    private func _format(_ ottava: ABCClef.Ottava) -> String {
        switch ottava {
        case .alta:
            "+8"

        case .bassa:
            "-8"
        }
    }
}
