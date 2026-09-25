// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorABC

extension ABCDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ symbol: ABCSymbol) {
        var line = ""

        switch symbol {
        case let .annotation(annotation):
            line += "Annotation"
            line += spacer()
            line += format(annotation)

        case let .barLine(barLine):
            line += "Bar line"
            line += spacer()
            line += _format(barLine)

        case .beamBreak:
            line += "Beam break"

        case let .brokenRhythm(brokenRhythm):
            line += "Broken rhythm"
            line += spacer()
            line += _format(brokenRhythm)

        case let .chord(chord):
            _dump(indent, chord)
            return

        case let .chordSymbol(chordSymbol):
            line += "Chord symbol"
            line += spacer()
            line += format(chordSymbol)

        case let .decoration(decoration):
            line += "Decoration"
            line += spacer()
            line += format(decoration)

        case let .graceNotes(graceNotes):
            _dump(indent, graceNotes)
            return

        case let .inlineField(field):
            line += "Inline"
            line += spacer()
            line += format(field)

        case let .note(note):
            line += "Note"
            line += spacer()
            line += _format(note)

        case .overlay:
            line += "Overlay"

        case let .rest(rest):
            line += "Rest"
            line += spacer()
            line += _format(rest)

        case let .shorthand(shorthand):
            line += "Shorthand"
            line += spacer()
            line += format(shorthand)

        case let .slur(slur):
            line += "Slur"
            line += spacer()
            line += _format(slur)

        case let .spacer(length):
            line += "Spacer"
            line += spacer()
            line += format(length)

        case let .tuplet(tuplet):
            line += "Tuplet"
            line += spacer()
            line += _format(tuplet)

        case let .variantEnding(variantEnding):
            line += "Variant ending"
            line += spacer()
            line += _format(variantEnding)
        }

        emit(indent, line)
    }

    internal func format(_ length: ABCLength) -> String {
        var result = format(length.numerator)

        if length.denominator != 1 {
            result += "/"
            result += format(length.denominator)
        }

        return result
    }

    internal func formatSigned(_ value: Int) -> String {
        value > 0 ? "+" + format(value) : format(value)
    }

    // MARK: Private Instance Methods

    private func _dump(_ indent: Int,
                       _ chord: ABCChord) {
        var line = "Chord"

        line += spacer()
        line += format(chord.notes.count, "note")
        line += spacer()
        line += format(chord.length)

        if let tie = chord.tie {
            line += spacer()
            line += _format(tie)
        }

        emit(indent, line)

        for note in chord.notes {
            emit(indent + 2, _format(note))
        }
    }

    private func _dump(_ indent: Int,
                       _ graceNotes: ABCGraceNotes) {
        var line = "Grace notes"

        line += spacer()
        line += format(graceNotes.notes.count, "note")

        if graceNotes.isSlashed {
            line += spacer()
            line += "Slashed"
        }

        emit(indent, line)

        for note in graceNotes.notes {
            emit(indent + 2, _format(note))
        }
    }

    private func _format(_ barLine: ABCBarLine) -> String {
        var result = _format(barLine.kind)

        if barLine.kind == .repeat {
            result += spacer()
            result += format(barLine.precedingPlayCount.uintValue)
            result += " → "
            result += format(barLine.followingPlayCount.uintValue)
        }

        if barLine.isDotted {
            result += spacer()
            result += "Dotted"
        }

        return result
    }

    private func _format(_ brokenRhythm: ABCBrokenRhythm) -> String {
        switch brokenRhythm {
        case .dotted:
            ">"

        case .doubleDotted:
            ">>"

        case .reverseDotted:
            "<"

        case .reverseDoubleDotted:
            "<<"

        case .reverseTripleDotted:
            "<<<"

        case .tripleDotted:
            ">>>"
        }
    }

    private func _format(_ kind: ABCBarLine.Kind) -> String {
        switch kind {
        case .double:
            "Double"

        case .end:
            "End"

        case .invisible:
            "Invisible"

        case .repeat:
            "Repeat"

        case .standard:
            "Standard"
        }
    }

    private func _format(_ note: ABCNote) -> String {
        var result = format(note.pitch)

        result += spacer()
        result += format(note.length)

        if let tie = note.tie {
            result += spacer()
            result += _format(tie)
        }

        return result
    }

    private func _format(_ rest: ABCRest) -> String {
        var result = ""

        switch rest {
        case let .multiMeasure(_, count):
            result += format(count.uintValue, "measure")

        case let .regular(_, length):
            result += format(length)
        }

        if rest.isInvisible {
            result += spacer()
            result += "Invisible"
        }

        return result
    }

    private func _format(_ slur: ABCSlur) -> String {
        switch slur {
        case .endDotted:
            "End (dotted)"

        case .endRegular:
            "End"

        case .startDotted:
            "Start (dotted)"

        case .startRegular:
            "Start"
        }
    }

    private func _format(_ tie: ABCTie) -> String {
        switch tie {
        case .dotted:
            "Tied (dotted)"

        case .regular:
            "Tied"
        }
    }

    private func _format(_ tuplet: ABCTuplet) -> String {
        var result = format(tuplet.noteCount)

        if let beatCount = tuplet.beatCount {
            result += spacer()
            result += format(beatCount)

            if let affectedCount = tuplet.affectedCount {
                result += spacer()
                result += format(affectedCount)
            }
        }

        return result
    }

    private func _format(_ variantEnding: ABCVariantEnding) -> String {
        variantEnding.endings.map {
            $0.lowerBound == $0.upperBound
            ? "\($0.lowerBound)"
            : "\($0.lowerBound)-\($0.upperBound)"
        }.joined(separator: ",")
    }
}
