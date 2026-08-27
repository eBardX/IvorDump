// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorGuido

extension GMNDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ chord: GMNChord) {
        let segments = chord.segments

        var line = "Chord"

        line += spacer()
        line += format(segments.count, "segment")

        emit(indent, line)

        for (index, segment) in segments.enumerated() {
            _dump(indent + 2, segment, index)
        }
    }

    internal func dump(_ indent: Int,
                       _ note: GMNNote) {
        var line = "Note"

        line += spacer()
        line += _format(note.pitch)

        if let duration = note.duration {
            line += spacer()
            line += _format(duration)
        }

        emit(indent, line)
    }

    internal func dump(_ indent: Int,
                       _ rest: GMNRest) {
        var line = "Rest"

        if let duration = rest.duration {
            line += spacer()
            line += _format(duration)
        }

        emit(indent, line)
    }

    internal func dump(_ indent: Int,
                       _ tablature: GMNTablature) {
        var line = "Tablature"

        line += spacer()
        line += _format(tablature)

        if let duration = tablature.duration {
            line += spacer()
            line += _format(duration)
        }

        emit(indent, line)
    }

    // MARK: Private Instance Methods

    private func _dump(_ indent: Int,
                       _ segment: GMNChord.Segment,
                       _ index: Int) {
        let symbols = segment.symbols

        var line = "Segment #"

        line += format(index + 1)
        line += spacer()
        line += format(symbols.count, "symbol")

        emit(indent, line)

        for symbol in symbols {
            dump(indent + 2, symbol)
        }
    }

    private func _format(_ accidental: GMNPitch.Accidental) -> String {
        switch accidental {
        case .doubleFlat:
            "𝄫"

        case .doubleSharp:
            "𝄪"

        case .flat:
            "♭"

        case .impliedSharp,
             .omitted:
            ""

        case .sharp:
            "♯"
        }
    }

    private func _format(_ duration: GMNDuration) -> String {
        var result = ""

        if let denom = duration.denominator,
           let numer = duration.numerator {
            result += format(numer)

            if denom > 1 {
                result += "/"
                result += format(denom)
            }

            if let dots = duration.dots {
                result += spacer()
                result += format(dots.uintValue, "dot")
            }
        } else if let msecs = duration.milliseconds {
            result += format(msecs)
            result += "ms"
        } else if let dots = duration.dots {
            result += format(dots.uintValue, "dot")
        }

        return result
    }

    private func _format(_ name: GMNPitch.Name) -> String {
        switch name {
        case .a:
            "A"

        case .ais:
            "Ais"

        case .b:
            "B"

        case .c:
            "C"

        case .cis:
            "Cis"

        case .d:
            "D"

        case .dis:
            "Dis"

        case .do:
            "Do"

        case .e:
            "E"

        case .empty:
            "Empty"

        case .f:
            "F"

        case .fa:
            "Fa"

        case .fis:
            "Fis"

        case .g:
            "G"

        case .gis:
            "Gis"

        case .h:
            "H"

        case .la:
            "La"

        case .mi:
            "Mi"

        case .re:
            "Re"

        case .si:
            "Si"

        case .sol:
            "Sol"

        case .ti:
            "Ti"
        }
    }

    private func _format(_ pitch: GMNPitch) -> String {
        var result = _format(pitch.name) + _format(pitch.accidental)

        if let octave = pitch.octave {
            result += format(octave.intValue)
        }

        return result
    }

    private func _format(_ tablature: GMNTablature) -> String {
        var result = format(tablature.tabString)

        result += spacer()
        result += tablature.fret

        return result
    }
}
