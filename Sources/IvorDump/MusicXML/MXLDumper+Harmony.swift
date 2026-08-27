// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ harmony: MXLHarmony) {
        emit(indent, _format(harmony))

        for chord in harmony.chord {
            _dump(indent + 2, chord)
        }

        if let frame = harmony.frame {
            _dump(indent + 2, frame)
        }
    }

    // MARK: Private Instance Methods

    private func _dump(_ indent: Int,
                       _ chord: MXLHarmony.Chord) {
        var line = _format(chord.content)

        line += spacer()
        line += format(chord.kind)

        if let inversion = chord.inversion {
            line += spacer()
            line += "Inversion "
            line += format(inversion.value)

            if let text = inversion.text {
                line += " "
                line += format(text)
            }

            append(&line, format(inversion.position))
            append(&line, format(inversion.font))
            append(&line, inversion.color.map { format($0) })
        }

        if let bass = chord.bass {
            line += spacer()
            line += _format(bass)
        }

        emit(indent, line)

        for degree in chord.degree {
            emit(indent + 2, _format(degree))
        }
    }

    private func _dump(_ indent: Int,
                       _ frame: MXLFrame) {
        var line = "Frame "

        line += format(frame.strings, "string")
        line += spacer()
        line += format(frame.frets, "fret")

        if let firstFret = frame.firstFret {
            line += spacer()
            line += "First fret "
            line += format(firstFret.value)

            if let text = firstFret.text {
                line += " "
                line += format(text)
            }

            if let location = firstFret.location {
                line += " "
                line += _format(location)
            }
        }

        if let unplayed = frame.unplayed {
            line += spacer()
            line += "Unplayed "
            line += format(unplayed)
        }

        if let width = frame.width {
            line += spacer()
            line += "Width "
            line += format(width)
        }

        if let height = frame.height {
            line += spacer()
            line += "Height "
            line += format(height)
        }

        append(&line, frame.halign.map { "H " + format($0) })
        append(&line, frame.valign.map { "V " + format($0) })
        append(&line, format(frame.position))
        append(&line, frame.color.map { format($0) })

        emit(indent, line)

        for note in frame.note {
            var noteLine = "String "

            noteLine += format(note.string.value)
            noteLine += spacer()
            noteLine += "Fret "
            noteLine += format(note.fret.value)

            if let fingering = note.fingering {
                noteLine += spacer()
                noteLine += "Fingering "
                noteLine += format(fingering.value)
            }

            if let barre = note.barre {
                noteLine += spacer()
                noteLine += "Barre "
                noteLine += format(barre.kind)

                append(&noteLine, barre.color.map { format($0) })
            }

            emit(indent + 2, noteLine)
        }
    }

    private func _format(_ alter: MXLHarmonyAlter) -> String {
        var result = formatAlter(MXLSemitones(alter.value))

        if let location = alter.location {
            result += " ("
            result += _format(location)
            result += ")"
        }

        append(&result, alter.printsObject, "Printed", "Not printed")
        append(&result, format(alter.position))
        append(&result, format(alter.font))
        append(&result, alter.color.map { format($0) })

        return result
    }

    private func _format(_ arrangement: MXLHarmonyArrangement) -> String {
        switch arrangement {
        case .diagonal:
            "Diagonal"

        case .horizontal:
            "Horizontal"

        case .vertical:
            "Vertical"
        }
    }

    private func _format(_ bass: MXLBass) -> String {
        var result = "Bass "

        result += format(bass.step.value)

        if let text = bass.step.text {
            result += " "
            result += format(text)
        }

        if let alter = bass.alter {
            result += _format(alter)
        }

        if let separator = bass.separator {
            result += spacer()
            result += "Separator "
            result += format(separator.value)
        }

        if let arrangement = bass.arrangement {
            result += spacer()
            result += _format(arrangement)
        }

        return result
    }

    private func _format(_ content: MXLHarmony.Chord.Content) -> String {
        switch content {
        case let .function(function):
            return "Function " + format(function.value)

        case let .numeral(numeral):
            var result = "Numeral "

            result += format(numeral.root.value.uintValue)

            if let text = numeral.root.text {
                result += " "
                result += format(text)
            }

            if let alter = numeral.alter {
                result += _format(alter)
            }

            if let key = numeral.key {
                result += spacer()
                result += format(key.fifths)
                result += spacer()
                result += _format(key.mode)
            }

            append(&result, format(numeral.root.position))
            append(&result, format(numeral.root.font))
            append(&result, numeral.root.color.map { format($0) })

            return result

        case let .root(root):
            var result = "Root "

            result += format(root.step.value)

            if let text = root.step.text {
                result += " "
                result += format(text)
            }

            if let alter = root.alter {
                result += _format(alter)
            }

            return result
        }
    }

    private func _format(_ degree: MXLDegree) -> String {
        var result = "Degree "

        result += format(degree.value.value)

        if let symbol = degree.value.symbol {
            result += " "
            result += format(symbol)
        }

        if let text = degree.value.text {
            result += " "
            result += format(text)
        }

        result += spacer()
        result += formatAlter(MXLSemitones(degree.alter.value))

        append(&result, degree.alter.usesPlusMinus, "Plus/minus", "No plus/minus")

        result += spacer()
        result += format(degree.kind.value)

        if let text = degree.kind.text {
            result += " "
            result += format(text)
        }

        append(&result, degree.printsObject, "Printed", "Not printed")

        return result
    }

    private func _format(_ harmony: MXLHarmony) -> String {
        var result = "Harmony"

        if let kind = harmony.kind {
            result += spacer()
            result += _format(kind)
        }

        if let arrangement = harmony.arrangement {
            result += spacer()
            result += _format(arrangement)
        }

        if let staff = harmony.staff {
            result += spacer()
            result += "Staff "
            result += format(staff.uintValue)
        }

        if let offset = harmony.offset {
            result += spacer()
            result += "Offset "
            result += format(offset.value)
        }

        if let placement = harmony.placement {
            result += spacer()
            result += format(placement)
        }

        if let system = harmony.system {
            result += spacer()
            result += format(system)
        }

        append(&result, harmony.printsFrame, "Frame printed", "Frame not printed")
        append(&result, harmony.printsObject, "Printed", "Not printed")

        if let id = harmony.id {
            result += spacer()
            result += "ID "
            result += format(id)
        }

        if let footnote = harmony.footnote {
            result += spacer()
            result += "Footnote "
            result += format(footnote)
        }

        if let level = harmony.level {
            result += spacer()
            result += format(level)
        }

        append(&result, format(harmony.position))
        append(&result, format(harmony.font))
        append(&result, harmony.color.map { format($0) })

        return result
    }

    private func _format(_ kind: MXLHarmony.Kind) -> String {
        switch kind {
        case .alternate:
            "Alternate"

        case .explicit:
            "Explicit"

        case .implied:
            "Implied"
        }
    }

    private func _format(_ location: MXLLeftRight) -> String {
        switch location {
        case .left:
            "left"

        case .right:
            "right"
        }
    }

    private func _format(_ mode: MXLNumeral.Mode) -> String {
        switch mode {
        case .harmonicMinor:
            "Harmonic minor"

        case .major:
            "Major"

        case .melodicMinor:
            "Melodic minor"

        case .minor:
            "Minor"

        case .naturalMinor:
            "Natural minor"
        }
    }
}
