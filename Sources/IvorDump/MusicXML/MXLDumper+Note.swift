// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ note: MXLNote) {
        var line = switch note.content {
        case .graceNote,
             .graceNoteCue:
            "Grace note"

        case .regularNote,
             .regularNoteCue:
            "Note"
        }

        line += spacer()
        line += _format(note)

        emit(indent, line)

        for instrument in note.instrument {
            emit(indent + 2,
                 "Instrument" + spacer() + format(instrument.id))
        }

        for beam in note.beam {
            emit(indent + 2, format(beam))
        }

        for lyric in note.lyric {
            emit(indent + 2, format(lyric))
        }

        for notations in note.notations {
            dump(indent + 2, notations)
        }

        if let play = note.play {
            emit(indent + 2, format(play))
        }

        if let listen = note.listen {
            emit(indent + 2, format(listen))
        }
    }

    // MARK: Private Instance Methods

    private func _format(_ content: MXLFullNote.Content) -> String {
        switch content {
        case let .pitch(pitch):
            return format(pitch)

        case let .rest(rest):
            var result = "Rest"

            if rest.measure == true {
                result += spacer()
                result += "Whole measure"
            }

            if let dso = rest.displayStepOctave {
                result += spacer()
                result += "Display "
                result += _format(dso)
            }

            return result

        case let .unpitched(unpitched):
            var result = "Unpitched"

            if let dso = unpitched.displayStepOctave {
                result += spacer()
                result += "Display "
                result += _format(dso)
            }

            return result
        }
    }

    private func _format(_ dso: MXLDisplayStepOctave) -> String {
        format(dso.displayStep) + format(dso.displayOctave.uintValue)
    }

    private func _format(_ grace: MXLGrace) -> String {
        var result = "Grace"

        if let makeTime = grace.makeTime {
            result += spacer()
            result += format(makeTime.intValue)
            result += " (make)"
        }

        if let percent = grace.stealTimeFollowing {
            result += spacer()
            result += format(percent)
            result += "% (following)"
        }

        if let percent = grace.stealTimePrevious {
            result += spacer()
            result += format(percent)
            result += "% (previous)"
        }

        append(&result, grace.isSlashed, "Slashed", "Not slashed")

        return result
    }

    private func _format(_ note: MXLNote) -> String {
        var line: String

        switch note.content {
        case let .graceNote(fullNote, grace, tie):
            line = _format(fullNote.content)
            line += spacer()
            line += _format(grace)

            if fullNote.isChord {
                line += spacer()
                line += "Chord"
            }

            if let result = format(tie) {
                line += spacer()
                line += result
            }

        case let .graceNoteCue(fullNote, grace):
            line = _format(fullNote.content)
            line += spacer()
            line += _format(grace)
            line += spacer()
            line += "Cue"

            if fullNote.isChord {
                line += spacer()
                line += "Chord"
            }

        case let .regularNote(fullNote, duration, tie):
            line = _format(fullNote.content)
            line += spacer()
            line += format(duration.intValue)

            if fullNote.isChord {
                line += spacer()
                line += "Chord"
            }

            if let result = format(tie) {
                line += spacer()
                line += result
            }

        case let .regularNoteCue(fullNote, duration):
            line = _format(fullNote.content)
            line += spacer()
            line += format(duration.intValue)
            line += spacer()
            line += "Cue"

            if fullNote.isChord {
                line += spacer()
                line += "Chord"
            }
        }

        if let accidental = note.accidental {
            line += spacer()
            line += format(accidental)
        }

        line += _format(notationOf: note)
        line += _format(playbackOf: note)
        line += _format(appearanceOf: note)
        line += _format(editorialOf: note)

        return line
    }

    private func _format(appearanceOf note: MXLNote) -> String {
        var result = ""

        if !note.printsLeger {
            result += spacer()
            result += "No leger"
        }

        if let printout = format(note.printout) {
            result += spacer()
            result += printout
        }

        if let color = note.color {
            result += spacer()
            result += "Color "
            result += format(color.stringValue)
        }

        if let font = format(note.font) {
            result += spacer()
            result += font
        }

        if let position = format(note.xPosition) {
            result += spacer()
            result += position
        }

        return result
    }

    private func _format(editorialOf note: MXLNote) -> String {
        var result = ""

        if let id = note.id {
            result += spacer()
            result += "ID "
            result += format(id)
        }

        if let footnote = note.footnote {
            result += spacer()
            result += "Footnote "
            result += format(footnote)
        }

        if let level = note.level {
            result += spacer()
            result += format(level)
        }

        return result
    }

    private func _format(notationOf note: MXLNote) -> String {
        var result = ""

        if let kind = note.kind {
            result += spacer()
            result += format(kind)
        }

        if let dots = format(note.dot) {
            result += spacer()
            result += dots
        }

        if let timeModification = note.timeModification {
            result += spacer()
            result += format(timeModification)
        }

        if let stem = note.stem {
            result += spacer()
            result += format(stem)
        }

        if let notehead = note.notehead {
            result += spacer()
            result += format(notehead)
        }

        if let noteheadText = note.noteheadText {
            result += spacer()
            result += format(noteheadText)
        }

        if let voice = note.voice {
            result += spacer()
            result += "Voice "
            result += format(voice.voice)
        }

        if let staff = note.staff {
            result += spacer()
            result += "Staff "
            result += format(staff.uintValue)
        }

        return result
    }

    private func _format(playbackOf note: MXLNote) -> String {
        var result = ""

        if let dynamics = note.dynamics {
            result += spacer()
            result += "Attack velocity "
            result += format(dynamics)
            result += "%"
        }

        if let endDynamics = note.endDynamics {
            result += spacer()
            result += "Release velocity "
            result += format(endDynamics)
            result += "%"
        }

        if let attack = note.attack {
            result += spacer()
            result += "Attack "
            result += format(attack.intValue)
        }

        if let release = note.release {
            result += spacer()
            result += "Release "
            result += format(release.intValue)
        }

        if let timeOnly = note.timeOnly,
           !timeOnly.isEmpty {
            result += spacer()
            result += "Times "
            result += timeOnly.map { format($0) }.joined(separator: ",")
        }

        append(&result, note.isPizzicato, "Pizzicato", "Arco")

        return result
    }
}
