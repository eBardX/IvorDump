// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ attributes: MXLAttributes) {
        emit(indent, _format(attributes))

        for key in attributes.key {
            _dump(indent + 2, key)
        }

        for time in attributes.time {
            emit(indent + 2, _format(time))
        }

        for clef in attributes.clef {
            emit(indent + 2, format(clef))
        }

        if let partSymbol = attributes.partSymbol {
            emit(indent + 2, format(partSymbol))
        }

        for staffDetails in attributes.staffDetails {
            dump(indent + 2, staffDetails)
        }

        _dump(indent + 2, attributes.content)

        for measureStyle in attributes.measureStyle {
            emit(indent + 2, format(measureStyle))
        }

        for directive in attributes.directive {
            var line = "Directive"

            line += spacer()
            line += format(directive.value)

            append(&line, format(directive.position))
            append(&line, format(directive.font))
            append(&line, directive.color.map { format($0) })

            emit(indent + 2, line)
        }
    }

    internal func format(_ fifths: MXLFifths) -> String {
        let value = fifths.intValue

        if value == 0 {
            return "No accidentals"
        }

        return format(abs(value), value < 0 ? "flat" : "sharp")
    }

    // MARK: Private Instance Methods

    private func _dump(_ indent: Int,
                       _ content: MXLAttributes.Content) {
        switch content {
        case let .forPart(forParts):
            for forPart in forParts {
                var line = "For part"

                if let number = forPart.number {
                    line += spacer()
                    line += "Staff "
                    line += format(number.uintValue)
                }

                if let clef = forPart.clef {
                    line += spacer()
                    line += format(clef)
                }

                line += spacer()
                line += format(forPart.transpose)

                emit(indent, line)
            }

        case let .transpose(transposes):
            for transpose in transposes {
                var line = "Transpose"

                if let number = transpose.number {
                    line += spacer()
                    line += "Staff "
                    line += format(number.uintValue)
                }

                line += spacer()
                line += format(transpose.content)

                emit(indent, line)
            }
        }
    }

    private func _dump(_ indent: Int,
                       _ key: MXLKey) {
        var line = "Key"

        if let number = key.number {
            line += spacer()
            line += "Staff "
            line += format(number.uintValue)
        }

        line += spacer()
        line += _format(key.content)

        append(&line, key.printsObject, "Printed", "Not printed")
        append(&line, format(key.position))
        append(&line, format(key.font))
        append(&line, key.color.map { format($0) })

        emit(indent, line)

        for octave in key.octave {
            var octaveLine = "Key octave "

            octaveLine += format(octave.number)
            octaveLine += spacer()
            octaveLine += format(octave.value)

            append(&octaveLine, octave.isCancelling, "Cancelling", "Not cancelling")

            emit(indent + 2, octaveLine)
        }
    }

    private func _format(_ attributes: MXLAttributes) -> String {
        var result = "Attributes"

        if let divisions = attributes.divisions {
            result += spacer()
            result += format(divisions.intValue)
            result += " division(s)/quarter"
        }

        if let staves = attributes.staves {
            result += spacer()
            result += format(staves, "stave")
        }

        if let instruments = attributes.instruments {
            result += spacer()
            result += format(instruments, "instrument")
        }

        if let footnote = attributes.footnote {
            result += spacer()
            result += "Footnote "
            result += format(footnote)
        }

        if let level = attributes.level {
            result += spacer()
            result += format(level)
        }

        return result
    }

    private func _format(_ content: MXLKey.Content) -> String {
        switch content {
        case let .nonTraditionalKey(key):
            var result = format(key.step)

            result += formatAlter(key.alter)

            if let accidental = key.accidental {
                result += format(accidental.value)

                if let smufl = accidental.smufl {
                    result += spacer()
                    result += format(smufl.stringValue)
                }
            }

            return result

        case let .traditionalKey(key):
            var result = format(key.fifths)

            if let mode = key.mode {
                result += spacer()
                result += mode
            }

            if let cancel = key.cancel {
                result += spacer()
                result += "Cancel "
                result += format(cancel.value)

                if let location = cancel.location {
                    result += " "
                    result += _format(location)
                }
            }

            return result
        }
    }

    private func _format(_ content: MXLTime.Content) -> String {
        switch content {
        case let .senzaMisura(text):
            return text.isEmpty ? "Senza misura" : "Senza misura " + format(text)

        case let .timeSignature(signatures, interchangeable):
            var result = _format(signatures)

            if let interchangeable {
                result += spacer()
                result += "Interchangeable "
                result += _format(interchangeable.timeSignature)

                if let symbol = interchangeable.symbol {
                    result += spacer()
                    result += _format(symbol)
                }

                if interchangeable.separator != .stacked {
                    result += spacer()
                    result += "Separator "
                    result += _format(interchangeable.separator)
                }

                if let timeRelation = interchangeable.timeRelation {
                    result += spacer()
                    result += _format(timeRelation)
                }
            }

            return result
        }
    }

    private func _format(_ location: MXLCancel.Location) -> String {
        switch location {
        case .beforeBarline:
            "before barline"

        case .left:
            "left"

        case .right:
            "right"
        }
    }

    private func _format(_ relation: MXLTimeRelation) -> String {
        switch relation {
        case .bracket:
            "Bracket"

        case .equals:
            "Equals"

        case .hyphen:
            "Hyphen"

        case .parentheses:
            "Parentheses"

        case .slash:
            "Slash"

        case .space:
            "Space"
        }
    }

    private func _format(_ separator: MXLTimeSeparator) -> String {
        switch separator {
        case .adjacent:
            "adjacent"

        case .diagonal:
            "diagonal"

        case .horizontal:
            "horizontal"

        case .stacked:
            "stacked"

        case .vertical:
            "vertical"
        }
    }

    private func _format(_ signatures: [MXLTimeSignature]) -> String {
        signatures.map { $0.beats + "/" + $0.beatType }.joined(separator: "+")
    }

    private func _format(_ symbol: MXLTimeSymbol) -> String {
        switch symbol {
        case .common:
            "Common"

        case .cut:
            "Cut"

        case .dottedNote:
            "Dotted note"

        case .normal:
            "Normal"

        case .note:
            "Note"

        case .singleNumber:
            "Single number"
        }
    }

    private func _format(_ time: MXLTime) -> String {
        var result = "Time"

        if let number = time.number {
            result += spacer()
            result += "Staff "
            result += format(number.uintValue)
        }

        result += spacer()
        result += _format(time.content)

        append(&result, time.symbol.map { _format($0) })
        append(&result, time.printsObject, "Printed", "Not printed")

        if time.separator != .stacked {
            result += spacer()
            result += "Separator "
            result += _format(time.separator)
        }
        append(&result, time.halign.map { "H " + format($0) })
        append(&result, time.valign.map { "V " + format($0) })
        append(&result, format(time.position))
        append(&result, format(time.font))
        append(&result, time.color.map { format($0) })

        return result
    }
}
