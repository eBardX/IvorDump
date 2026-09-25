// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ staffDetails: MXLStaffDetails) {
        var line = "Staff details"

        if let number = staffDetails.number {
            line += spacer()
            line += "Staff "
            line += format(number.uintValue)
        }

        if let staffKind = staffDetails.staffKind {
            line += spacer()
            line += _format(staffKind)
        }

        if let group = staffDetails.group {
            line += spacer()
            line += format(group.staffLines, "line")

            for detail in group.lineDetail {
                line += spacer()
                line += "Line "
                line += format(detail.line.uintValue)

                if detail.printsObject == false {
                    line += " hidden"
                }

                if let width = detail.width {
                    line += " w"
                    line += format(width)
                }
            }
        }

        if let staffSize = staffDetails.staffSize {
            line += spacer()
            line += "Size "
            line += format(staffSize.value)
        }

        if let capo = staffDetails.capo {
            line += spacer()
            line += "Capo "
            line += format(capo)
        }

        if staffDetails.showFrets != .numbers {
            line += spacer()
            line += "Frets as "
            line += _format(staffDetails.showFrets)
        }

        append(&line, staffDetails.printsObject, "Printed", "Not printed")
        append(&line, staffDetails.printsSpacing, "Spacing printed", "Spacing not printed")

        emit(indent, line)

        for tuning in staffDetails.staffTuning {
            var tuningLine = "Staff tuning "

            tuningLine += format(tuning.line.uintValue)
            tuningLine += spacer()
            tuningLine += format(tuning.tuning)

            emit(indent + 2, tuningLine)
        }
    }

    internal func format(_ measureStyle: MXLMeasureStyle) -> String {
        var result = "Measure style"

        if let number = measureStyle.number {
            result += spacer()
            result += "Staff "
            result += format(number.uintValue)
        }

        result += spacer()
        result += _format(measureStyle.content)

        append(&result, format(measureStyle.font))
        append(&result, measureStyle.color.map { format($0) })

        return result
    }

    internal func format(_ tuning: MXLTuning) -> String {
        var result = format(tuning.step)

        if let alter = tuning.alter {
            result += formatAlter(alter)
        }

        result += format(tuning.octave.uintValue)

        return result
    }

    // MARK: Private Instance Methods

    private func _format(_ content: MXLMeasureStyle.Content) -> String {
        switch content {
        case let .beatRepeat(beatRepeat):
            var result = "Beat repeat "

            result += format(beatRepeat.kind)

            if let slashes = beatRepeat.slashes {
                result += spacer()
                result += format(slashes, "slash", plural: "slashes")
            }

            append(&result, beatRepeat.usesDots, "Dots", "No dots")
            append(&result, beatRepeat.slashContent.flatMap { _format(slashContent: $0) })

            return result

        case let .measureRepeat(measureRepeat):
            var result = "Measure repeat "

            result += format(measureRepeat.kind)

            if let value = measureRepeat.value {
                result += spacer()
                result += format(value, "measure")
            }

            return result

        case let .multipleRest(multipleRest):
            var result = "Multiple rest "

            result += format(multipleRest.value, "measure")

            if multipleRest.usesSymbols {
                result += spacer()
                result += "Symbols"
            }

            return result

        case let .slash(slash):
            var result = "Slash "

            result += format(slash.kind)

            if !slash.usesStems {
                result += spacer()
                result += "No stems"
            }

            append(&result, slash.usesDots, "Dots", "No dots")
            append(&result, slash.content.flatMap { _format(slashContent: $0) })

            return result
        }
    }

    private func _format(_ kind: MXLStaffDetails.Kind) -> String {
        switch kind {
        case .alternate:
            "Alternate"

        case .cue:
            "Cue"

        case .editorial:
            "Editorial"

        case .ossia:
            "Ossia"

        case .regular:
            "Regular"
        }
    }

    private func _format(_ showFrets: MXLShowFrets) -> String {
        switch showFrets {
        case .letters:
            "letters"

        case .numbers:
            "numbers"
        }
    }

    private func _format(slashContent: MXLSlashContent) -> String? {
        var result = ""

        if let group = slashContent.group {
            result += format(group.slashKind)

            if group.slashDot > 0 {
                result += " "
                result += format(group.slashDot, "dot")
            }
        }

        if !slashContent.exceptVoice.isEmpty {
            if !result.isEmpty {
                result += " "
            }

            result += "except voice "
            result += slashContent.exceptVoice.map { format($0) }.joined(separator: ",")
        }

        return result.isEmpty ? nil : result
    }
}
