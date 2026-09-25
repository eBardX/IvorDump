// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func format(_ beam: MXLBeam) -> String {
        var result = "Beam "

        result += format(beam.number.uintValue)
        result += spacer()
        result += _format(beam.value)

        if let fan = beam.fan {
            result += spacer()
            result += _format(fan)
        }

        append(&result, beam.repeater, "Repeater", "Not repeater")
        append(&result, beam.color.map { format($0) })

        return result
    }

    internal func format(_ dots: [MXLEmptyPlacement]) -> String? {
        dots.isEmpty ? nil : format(dots.count, "dot")
    }

    internal func format(_ notehead: MXLNote.Notehead) -> String {
        var result = "Notehead "

        result += _format(notehead.value)

        append(&result, notehead.isFilled, "Filled", "Hollow")

        if notehead.hasParentheses {
            result += spacer()
            result += "Parenthesized"
        }

        if let smufl = notehead.smufl {
            result += spacer()
            result += format(smufl.stringValue)
        }

        append(&result, format(notehead.font))
        append(&result, notehead.color.map { format($0) })

        return result
    }

    internal func format(_ noteheadText: MXLNote.NoteheadText) -> String {
        var result = "Notehead text"

        for item in noteheadText.items {
            result += spacer()
            result += _format(item)
        }

        return result
    }

    internal func format(_ printout: MXLPrintout) -> String? {
        var shown: [String] = []
        var hidden: [String] = []

        if let printsObject = printout.printsObject {
            if printsObject {
                shown.append("object")
            } else {
                hidden.append("object")
            }
        }

        // `printsDot` and `printsLyric` are resolved to non-optional by the
        // AST, so an explicit "yes" is indistinguishable from the default.

        if !printout.printsDot {
            hidden.append("dot")
        }

        if !printout.printsLyric {
            hidden.append("lyric")
        }

        if let printsSpacing = printout.printsSpacing {
            if printsSpacing {
                shown.append("spacing")
            } else {
                hidden.append("spacing")
            }
        }

        var parts: [String] = []

        if !hidden.isEmpty {
            parts.append("No " + hidden.joined(separator: "/"))
        }

        if !shown.isEmpty {
            parts.append("Prints " + shown.joined(separator: "/"))
        }

        return parts.isEmpty ? nil : parts.joined(separator: spacer())
    }

    internal func format(_ stem: MXLStem) -> String {
        var result = "Stem " + _format(stem.value)

        append(&result, format(stem.yPosition))
        append(&result, stem.color.map { format($0) })

        return result
    }

    internal func format(_ ties: [MXLTie]) -> String? {
        let kinds = Set(ties.map { $0.kind })
        let hasStart = kinds.contains(.start)
        let hasStop = kinds.contains(.stop)

        if hasStart, hasStop {
            return "Stop/start tie"
        }

        if hasStart {
            return "Start tie"
        }

        if hasStop {
            return "Stop tie"
        }

        return nil
    }

    internal func format(_ timeModification: MXLTimeModification) -> String {
        var result = format(timeModification.actualNotes)

        result += ":"
        result += format(timeModification.normalNotes)

        if let group = timeModification.group {
            result += " "
            result += format(group.normalKind)

            if group.normalDot > 0 {
                result += " "
                result += format(group.normalDot, "dot")
            }
        }

        return result
    }

    // MARK: Private Instance Methods

    private func _format(_ fan: MXLFan) -> String {
        switch fan {
        case .accel:
            "Accel"

        case .rit:
            "Rit"

        case .steady:
            "Steady"
        }
    }

    private func _format(_ item: MXLNote.NoteheadText.Item) -> String {
        switch item {
        case let .accidentalText(text):
            format(text)

        case let .displayText(text):
            format(text)
        }
    }

    private func _format(_ value: MXLBeamValue) -> String {
        switch value {
        case .backwardHook:
            "Backward hook"

        case .begin:
            "Begin"

        case .continue:
            "Continue"

        case .end:
            "End"

        case .forwardHook:
            "Forward hook"
        }
    }

    private func _format(_ value: MXLNote.Notehead.Value) -> String {
        switch value {
        case .arrowDown:
            "Arrow down"

        case .arrowUp:
            "Arrow up"

        case .backSlashed:
            "Back slashed"

        case .circled:
            "Circled"

        case .circleDot:
            "Circle dot"

        case .circleX:
            "Circle X"

        case .cluster:
            "Cluster"

        case .cross:
            "Cross"

        case .diamond:
            "Diamond"

        case .do:
            "Do"

        case .fa:
            "Fa"

        case .faUp:
            "Fa up"

        case .hidden:
            "Hidden"

        case .invertedTriangle:
            "Inverted triangle"

        case .la:
            "La"

        case .leftTriangle:
            "Left triangle"

        case .mi:
            "Mi"

        case .normal:
            "Normal"

        case .other:
            "Other"

        case .re:
            "Re"

        case .rectangle:
            "Rectangle"

        case .slash:
            "Slash"

        case .slashed:
            "Slashed"

        case .so:
            "So"

        case .square:
            "Square"

        case .ti:
            "Ti"

        case .triangle:
            "Triangle"

        case .x:
            "X"
        }
    }

    private func _format(_ value: MXLStem.Value) -> String {
        switch value {
        case .absent:
            "none"

        case .double:
            "double"

        case .down:
            "down"

        case .up:
            "up"
        }
    }
}
