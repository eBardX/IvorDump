// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ content: MXLOrnaments.Content) {
        switch content {
        case let .delayedInvertedTurn(turn):
            emit(indent, _format("Delayed inverted turn", turn))

        case let .delayedTurn(turn):
            emit(indent, _format("Delayed turn", turn))

        case let .haydn(empty):
            emit(indent, _format("Haydn", empty))

        case let .invertedMordent(mordent):
            emit(indent, _format("Inverted mordent", mordent))

        case let .invertedTurn(turn):
            emit(indent, _format("Inverted turn", turn))

        case let .invertedVerticalTurn(empty):
            emit(indent, _format("Inverted vertical turn", empty))

        case let .mordent(mordent):
            emit(indent, _format("Mordent", mordent))

        case let .otherOrnament(other):
            emit(indent,
                 "Other ornament" + spacer() + format(other.value))

        case let .schleifer(position, font, color, placement):
            emit(indent,
                 format("Schleifer", position, font, color, placement))

        case let .shake(empty):
            emit(indent, _format("Shake", empty))

        case let .tremolo(tremolo):
            var line = "Tremolo"

            line += spacer()
            line += _format(tremolo.kind)
            line += spacer()
            line += format(tremolo.value.uintValue, "mark")

            append(&line, tremolo.placement.map { format($0) })
            append(&line, tremolo.smufl.map { format($0.stringValue) })
            append(&line, format(tremolo.position))
            append(&line, format(tremolo.font))
            append(&line, tremolo.color.map { format($0) })

            emit(indent, line)

        case let .trillMark(empty):
            emit(indent, _format("Trill mark", empty))

        case let .turn(turn):
            emit(indent, _format("Turn", turn))

        case let .verticalTurn(empty):
            emit(indent, _format("Vertical turn", empty))

        case let .wavyLine(wavyLine):
            emit(indent, format(wavyLine))
        }
    }

    internal func format(_ line: MXLEmptyLine) -> String? {
        var out: [String] = []

        if let kind = line.kind {
            out.append("Line " + format(kind))
        }

        if let shape = line.shape {
            out.append(format(shape))
        }

        if let length = line.length {
            out.append("Length " + format(lineLength: length))
        }

        if let dash = format(dashLength: line.dashedFormatting.dashLength,
                             spaceLength: line.dashedFormatting.spaceLength) {
            out.append(dash)
        }

        if let placement = line.placement {
            out.append(format(placement))
        }

        if let position = format(line.printStyle.position) {
            out.append(position)
        }

        if let font = format(line.printStyle.font) {
            out.append(font)
        }

        if let color = line.printStyle.color {
            out.append(format(color))
        }

        return out.isEmpty ? nil : out.joined(separator: spacer())
    }

    internal func format(_ mark: MXLAccidentalMark) -> String {
        var result = "Accidental mark"

        result += spacer()
        result += format(mark.value)

        append(&result, format(mark.levelDisplay))
        append(&result, mark.placement.map { format($0) })
        append(&result, mark.smufl.map { format($0.stringValue) })
        append(&result, format(mark.position))
        append(&result, format(mark.font))
        append(&result, mark.color.map { format($0) })

        return result
    }

    internal func format(_ wavyLine: MXLWavyLine) -> String {
        var result = "Wavy line "

        result += format(wavyLine.kind)

        if let number = wavyLine.number {
            result += spacer()
            result += format(number.uintValue)
        }

        append(&result, wavyLine.placement.map { format($0) })
        append(&result, wavyLine.smufl.map { format($0.stringValue) })
        append(&result, format(wavyLine.position))
        append(&result, wavyLine.color.map { format($0) })

        return result
    }

    // MARK: Private Instance Methods

    private func _format(_ kind: MXLTremolo.Kind) -> String {
        switch kind {
        case .single:
            "Single"

        case .start:
            "Start"

        case .stop:
            "Stop"

        case .unmeasured:
            "Unmeasured"
        }
    }

    private func _format(_ label: String,
                         _ empty: MXLEmptyTrillSound) -> String {
        var result = label

        appendPlacement(&result,
                        placement: empty.placement,
                        position: empty.position,
                        font: empty.font,
                        color: empty.color)
        append(&result, _format(empty.trillSound))

        return result
    }

    private func _format(_ label: String,
                         _ mordent: MXLMordent) -> String {
        var result = label

        if mordent.isLong {
            result += spacer()
            result += "Long"
        }

        append(&result, mordent.approach.map { "Approach " + format($0) })
        append(&result, mordent.departure.map { "Departure " + format($0) })
        appendPlacement(&result,
                        placement: mordent.placement,
                        position: mordent.position,
                        font: mordent.font,
                        color: mordent.color)
        append(&result, _format(mordent.trillSound))

        return result
    }

    private func _format(_ label: String,
                         _ turn: MXLHorizontalTurn) -> String {
        var result = label

        append(&result, turn.isSlashed, "Slashed", "Not slashed")
        appendPlacement(&result,
                        placement: turn.placement,
                        position: turn.position,
                        font: turn.font,
                        color: turn.color)
        append(&result, _format(turn.trillSound))

        return result
    }

    private func _format(_ trillSound: MXLTrillSound) -> String? {
        var parts: [String] = []

        if let startNote = trillSound.startNote {
            switch startNote {
            case .below:
                parts.append("Start below")

            case .main:
                parts.append("Start main")

            case .upper:
                parts.append("Start upper")
            }
        }

        if let trillStep = trillSound.trillStep {
            switch trillStep {
            case .half:
                parts.append("Step half")

            case .unison:
                parts.append("Step unison")

            case .whole:
                parts.append("Step whole")
            }
        }

        if let twoNoteTurn = trillSound.twoNoteTurn {
            switch twoNoteTurn {
            case .half:
                parts.append("Turn half")

            case .omitted:
                parts.append("Turn omitted")

            case .whole:
                parts.append("Turn whole")
            }
        }

        if trillSound.accelerates == true {
            parts.append("Accelerates")
        }

        if let beats = trillSound.beats {
            parts.append(format(beats, precision: 0...2) + " beats")
        }

        if let secondBeat = trillSound.secondBeat {
            parts.append("2nd beat " + format(secondBeat) + "%")
        }

        if let lastBeat = trillSound.lastBeat {
            parts.append("Last beat " + format(lastBeat) + "%")
        }

        return parts.isEmpty ? nil : parts.joined(separator: spacer())
    }
}
