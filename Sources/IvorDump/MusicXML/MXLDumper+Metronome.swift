// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func format(_ metronome: MXLMetronome) -> String {
        var result = "Metronome"

        result += spacer()
        result += _format(metronome.content)

        if metronome.hasParentheses {
            result += spacer()
            result += "Parenthesized"
        }

        append(&result, metronome.printsObject, "Printed", "Not printed")
        append(&result, metronome.halign.map { "H " + format($0) })
        append(&result, metronome.valign.map { "V " + format($0) })
        append(&result, metronome.justify.map { "Justify " + format($0) })
        append(&result, format(metronome.position))
        append(&result, format(metronome.font))
        append(&result, metronome.color.map { format($0) })

        return result
    }

    internal func format(_ registration: MXLAccordionRegistration) -> String {
        var result = "Accordion registration"

        if registration.hasHighDot {
            result += spacer()
            result += "High"
        }

        if let middle = registration.accordionMiddle {
            result += spacer()
            result += "Middle "
            result += format(middle.uintValue)
        }

        if registration.hasLowDot {
            result += spacer()
            result += "Low"
        }

        appendStyle(&result,
                    position: registration.position,
                    font: registration.font,
                    color: registration.color,
                    halign: registration.halign,
                    valign: registration.valign)

        return result
    }

    internal func format(_ value: MXLNoteKindValue,
                         _ dots: Int) -> String {
        var result = format(value)

        if dots > 0 {
            result += " "
            result += format(dots, "dot")
        }

        return result
    }

    // MARK: Private Instance Methods

    private func _format(_ beatUnit: MXLBeatUnit) -> String {
        format(beatUnit.beatUnit, beatUnit.dot)
    }

    private func _format(_ content: MXLMetronome.Content) -> String {
        switch content {
        case let .beatUnit(beatUnit, tied, beatContent):
            var result = _format(beatUnit)

            for entry in tied {
                result += " + "
                result += format(entry.beatUnit, entry.beatUnitDot)
            }

            result += " = "
            result += _format(beatContent)

            return result

        case let .metronomeArrows(hasArrows, note, relation, secondNote):
            var result = format(note.count, "note")

            if let relation {
                result += spacer()
                result += relation
            }

            if !secondNote.isEmpty {
                result += spacer()
                result += format(secondNote.count, "note")
            }

            if hasArrows {
                result += spacer()
                result += "Arrows"
            }

            return result
        }
    }

    private func _format(_ content: MXLMetronome.Content.BeatUnitContent) -> String {
        switch content {
        case let .beatUnit(beatUnit, tied):
            var result = _format(beatUnit)

            for entry in tied {
                result += " + "
                result += format(entry.beatUnit, entry.beatUnitDot)
            }

            return result

        case let .perMinute(perMinute):
            var result = perMinute.value

            append(&result, format(perMinute.font))

            return result
        }
    }
}
