// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ barline: MXLBarline) {
        emit(indent, _format(barline))

        if let ending = barline.ending {
            emit(indent + 2, _format(ending))
        }

        if let repeatMark = barline.repeat {
            emit(indent + 2, _format(repeatMark))
        }

        if let wavyLine = barline.wavyLine {
            emit(indent + 2, format(wavyLine))
        }

        for fermata in barline.fermata {
            var line = "Fermata"

            line += spacer()
            line += format(fermata.value)
            line += spacer()
            line += format(fermata.kind)

            emit(indent + 2, line)
        }
    }

    // MARK: Private Instance Methods

    private func _format(_ barline: MXLBarline) -> String {
        var result = "Barline"

        result += spacer()
        result += _format(barline.location)

        if let barStyle = barline.barStyle {
            result += spacer()
            result += _format(barStyle.value)

            append(&result, barStyle.color.map { format($0) })
        }

        if let segno = barline.segno {
            result += spacer()
            result += format(segno)
        }

        if let segnoAttribute = barline.segnoAttribute {
            result += spacer()
            result += "Segno "
            result += format(segnoAttribute)
        }

        if let coda = barline.coda {
            result += spacer()
            result += format(coda)
        }

        if let codaAttribute = barline.codaAttribute {
            result += spacer()
            result += "Coda "
            result += format(codaAttribute)
        }

        if let divisions = barline.divisions {
            result += spacer()
            result += "Divisions "
            result += format(divisions.intValue)
        }

        if let id = barline.id {
            result += spacer()
            result += "ID "
            result += format(id)
        }

        if let footnote = barline.footnote {
            result += spacer()
            result += "Footnote "
            result += format(footnote)
        }

        if let level = barline.level {
            result += spacer()
            result += format(level)
        }

        return result
    }

    private func _format(_ direction: MXLRepeat.Direction) -> String {
        switch direction {
        case .backward:
            "Backward"

        case .forward:
            "Forward"
        }
    }

    private func _format(_ ending: MXLEnding) -> String {
        var result = "Ending "

        result += format(ending.kind)

        if !ending.number.isEmpty {
            result += spacer()
            result += ending.number.map { format($0) }.joined(separator: ",")
        }

        if !ending.value.isEmpty {
            result += spacer()
            result += format(ending.value)
        }

        if let system = ending.system {
            result += spacer()
            result += format(system)
        }

        append(&result, ending.printsObject, "Printed", "Not printed")

        if let endLength = ending.endLength {
            result += spacer()
            result += "End length "
            result += format(endLength)
        }

        if let textX = ending.textX {
            result += spacer()
            result += "Text x "
            result += format(textX)
        }

        if let textY = ending.textY {
            result += spacer()
            result += "Text y "
            result += format(textY)
        }

        append(&result, format(ending.position))
        append(&result, format(ending.font))
        append(&result, ending.color.map { format($0) })

        return result
    }

    private func _format(_ location: MXLRightLeftMiddle) -> String {
        switch location {
        case .left:
            "Left"

        case .middle:
            "Middle"

        case .right:
            "Right"
        }
    }

    private func _format(_ repeatMark: MXLRepeat) -> String {
        var result = "Repeat "

        result += _format(repeatMark.direction)

        if let times = repeatMark.times {
            result += spacer()
            result += format(times, "time")
        }

        if repeatMark.winged != .wingless {
            result += spacer()
            result += _format(repeatMark.winged)
        }

        append(&result, repeatMark.isAfterJump, "After jump", "Not after jump")

        return result
    }

    private func _format(_ style: MXLBarline.StyleColor.Style) -> String {
        switch style {
        case .dashed:
            "Dashed"

        case .dotted:
            "Dotted"

        case .heavy:
            "Heavy"

        case .heavyHeavy:
            "Heavy-heavy"

        case .heavyLight:
            "Heavy-light"

        case .invisible:
            "Invisible"

        case .lightHeavy:
            "Light-heavy"

        case .lightLight:
            "Light-light"

        case .regular:
            "Regular"

        case .short:
            "Short"

        case .tick:
            "Tick"
        }
    }

    private func _format(_ winged: MXLWinged) -> String {
        switch winged {
        case .curved:
            "Curved"

        case .doubleCurved:
            "Double curved"

        case .doubleStraight:
            "Double straight"

        case .straight:
            "Straight"

        case .wingless:
            "Wingless"
        }
    }
}
