// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ item: MXLTechnical.Item) {
        switch item {
        case let .arrow(arrow):
            emit(indent, _format(arrow))

        case let .bend(bend):
            emit(indent, format(bend))

        case let .brassBend(position, font, color, placement):
            emit(indent,
                 format("Brass bend", position, font, color, placement))

        case let .doubleTongue(position, font, color, placement):
            emit(indent,
                 format("Double tongue", position, font, color, placement))

        case let .downBow(position, font, color, placement):
            emit(indent,
                 format("Down bow", position, font, color, placement))

        case let .fingering(fingering):
            emit(indent, _format(fingering))

        case let .fingernails(position, font, color, placement):
            emit(indent,
                 format("Fingernails", position, font, color, placement))

        case let .flip(position, font, color, placement):
            emit(indent,
                 format("Flip", position, font, color, placement))

        case let .fret(fret):
            emit(indent, _format(fret))

        case let .golpe(position, font, color, placement):
            emit(indent,
                 format("Golpe", position, font, color, placement))

        case let .halfMuted(position, font, color, placement, smufl):
            emit(indent,
                 format("Half muted", position, font, color, placement, smufl: smufl))

        case let .hammerOn(hammerOn):
            emit(indent, _format("Hammer on", hammerOn))

        case let .handbell(handbell):
            emit(indent, format(handbell))

        case let .harmonic(harmonic):
            emit(indent, format(harmonic))

        case let .harmonMute(harmonMute):
            emit(indent, format(harmonMute))

        case let .heel(heel):
            var line = "Heel"

            append(&line, heel.isSubstitute, "Substitute", "Not substitute")
            appendPlacement(&line,
                            placement: heel.placement,
                            position: heel.position,
                            font: heel.font,
                            color: heel.color)

            emit(indent, line)

        case let .hole(hole):
            emit(indent, format(hole))

        case let .open(position, font, color, placement, smufl):
            emit(indent,
                 format("Open", position, font, color, placement, smufl: smufl))

        case let .openString(position, font, color, placement):
            emit(indent,
                 format("Open string", position, font, color, placement))

        case let .otherTechnical(other):
            emit(indent, _format(other))

        case let .pluck(pluck):
            emit(indent, _format(pluck))

        case let .pullOff(pullOff):
            emit(indent, _format("Pull off", pullOff))

        case let .smear(position, font, color, placement):
            emit(indent,
                 format("Smear", position, font, color, placement))

        case let .snapPizzicato(position, font, color, placement):
            emit(indent,
                 format("Snap pizzicato", position, font, color, placement))

        case let .stopped(position, font, color, placement, smufl):
            emit(indent,
                 format("Stopped", position, font, color, placement, smufl: smufl))

        case let .string(string):
            emit(indent, _format(string))

        case let .tap(tap):
            emit(indent, _format(tap))

        case let .thumbPosition(position, font, color, placement):
            emit(indent,
                 format("Thumb position", position, font, color, placement))

        case let .toe(toe):
            var line = "Toe"

            append(&line, toe.isSubstitute, "Substitute", "Not substitute")
            appendPlacement(&line,
                            placement: toe.placement,
                            position: toe.position,
                            font: toe.font,
                            color: toe.color)

            emit(indent, line)

        case let .tripleTongue(position, font, color, placement):
            emit(indent,
                 format("Triple tongue", position, font, color, placement))

        case let .upBow(position, font, color, placement):
            emit(indent,
                 format("Up bow", position, font, color, placement))
        }
    }

    // MARK: Private Instance Methods

    private func _format(_ arrow: MXLArrow) -> String {
        var result = "Arrow"

        appendPlacement(&result,
                        placement: arrow.placement,
                        position: arrow.position,
                        font: arrow.font,
                        color: arrow.color,
                        smufl: arrow.smufl)

        return result
    }

    private func _format(_ fingering: MXLFingering) -> String {
        var result = "Fingering"

        result += spacer()
        result += format(fingering.value)

        append(&result, fingering.isSubstitute, "Substitute", "Not substitute")
        append(&result, fingering.isAlternate, "Alternate", "Not alternate")
        appendPlacement(&result,
                        placement: fingering.placement,
                        position: fingering.position,
                        font: fingering.font,
                        color: fingering.color)

        return result
    }

    private func _format(_ fret: MXLFret) -> String {
        var result = "Fret"

        result += spacer()
        result += format(fret.value)

        append(&result, format(fret.font))
        append(&result, fret.color.map { format($0) })

        return result
    }

    private func _format(_ label: String,
                         _ hop: MXLHammerOnPullOff) -> String {
        var result = label

        result += spacer()
        result += format(hop.kind)
        result += spacer()
        result += format(hop.number.uintValue)

        if !hop.value.isEmpty {
            result += spacer()
            result += format(hop.value)
        }

        appendPlacement(&result,
                        placement: hop.placement,
                        position: hop.position,
                        font: hop.font,
                        color: hop.color)

        return result
    }

    private func _format(_ other: MXLOtherPlacementText) -> String {
        var result = "Other technical"

        result += spacer()
        result += format(other.value)

        appendPlacement(&result,
                        placement: other.placement,
                        position: other.printStyle.position,
                        font: other.printStyle.font,
                        color: other.printStyle.color,
                        smufl: other.smufl)

        return result
    }

    private func _format(_ pluck: MXLPlacementText) -> String {
        var result = "Pluck"

        result += spacer()
        result += format(pluck.value)

        appendPlacement(&result,
                        placement: pluck.placement,
                        position: pluck.printStyle.position,
                        font: pluck.printStyle.font,
                        color: pluck.printStyle.color)

        return result
    }

    private func _format(_ string: MXLString) -> String {
        var result = "String"

        result += spacer()
        result += format(string.value)

        appendPlacement(&result,
                        placement: string.placement,
                        position: string.position,
                        font: string.font,
                        color: string.color)

        return result
    }

    private func _format(_ tap: MXLTap) -> String {
        var result = "Tap"

        result += spacer()
        result += format(tap.value)

        appendPlacement(&result,
                        placement: tap.placement,
                        position: tap.position,
                        font: tap.font,
                        color: tap.color)

        return result
    }
}
