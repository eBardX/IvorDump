// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorGuido

extension GMNDumper {

    // MARK: Internal Instance Methods

    // swiftlint:disable:next function_body_length
    internal func dump(_ indent: Int,
                       _ tag: GMNTag) {
        let body = tag.body

        var header = "Tag"

        header += spacer()
        header += tag.name.stringValue

        if let ident = tag.ident {
            header += spacer()
            header += format(ident.uintValue)
        }

        if !body.isEmpty {
            header += spacer()
            header += format(body.count, "symbol")
        }

        emit(indent, header)

        _dump(indent + 2, tag.appearance)

        switch tag {
        case let .accidental(payload):
            dump(indent + 2, payload)

        case let .accolade(payload):
            dump(indent + 2, payload)

        case let .alter(payload):
            dump(indent + 2, payload)

        case let .arpeggio(payload):
            dump(indent + 2, payload)

        case let .articulation(payload):
            dump(indent + 2, payload)

        case let .auto(payload):
            dump(indent + 2, payload)

        case let .barFormat(payload):
            dump(indent + 2, payload)

        case let .barLine(payload):
            dump(indent + 2, payload)

        case let .beam(payload):
            dump(indent + 2, payload)

        case let .beamState(payload):
            dump(indent + 2, payload)

        case .breathMark:
            break

        case let .clef(payload):
            dump(indent + 2, payload)

        case let .cluster(payload):
            dump(indent + 2, payload)

        case let .color(payload):
            dump(indent + 2, payload)

        case let .cue(payload):
            dump(indent + 2, payload)

        case let .custom(payload):
            _dump(indent + 2, payload.parameters)

        case let .displayDuration(payload):
            dump(indent + 2, payload)

        case .dotFormat:
            break

        case let .dynamicRamp(payload):
            dump(indent + 2, payload)

        case let .fingering(payload):
            dump(indent + 2, payload)

        case let .glissando(payload):
            dump(indent + 2, payload)

        case let .grace(payload):
            dump(indent + 2, payload)

        case let .graphicSymbol(payload):
            dump(indent + 2, payload)

        case let .harmony(payload):
            dump(indent + 2, payload)

        case let .instrument(payload):
            dump(indent + 2, payload)

        case let .intensity(payload):
            dump(indent + 2, payload)

        case let .jump(payload):
            dump(indent + 2, payload)

        case let .key(payload):
            dump(indent + 2, payload)

        case let .layoutBreak(payload):
            dump(indent + 2, payload)

        case let .lyrics(payload):
            dump(indent + 2, payload)

        case let .mark(payload):
            dump(indent + 2, payload)

        case .merge:
            break

        case let .meter(payload):
            dump(indent + 2, payload)

        case let .multiMeasureRest(payload):
            dump(indent + 2, payload)

        case let .noteFormat(payload):
            dump(indent + 2, payload)

        case let .noteHeads(payload):
            dump(indent + 2, payload)

        case let .octava(payload):
            dump(indent + 2, payload)

        case let .ornament(payload):
            dump(indent + 2, payload)

        case let .pageFormat(payload):
            dump(indent + 2, payload)

        case let .pedal(payload):
            dump(indent + 2, payload)

        case let .repeatMark(payload):
            dump(indent + 2, payload)

        case let .reserved(payload):
            _dump(indent + 2, payload.parameters)

        case .restFormat:
            break

        case .shareLocation:
            break

        case let .slur(payload):
            dump(indent + 2, payload)

        case let .space(payload):
            dump(indent + 2, payload)

        case let .special(payload):
            dump(indent + 2, payload)

        case let .staff(payload):
            dump(indent + 2, payload)

        case let .staffFormat(payload):
            dump(indent + 2, payload)

        case let .staffVisibility(payload):
            dump(indent + 2, payload)

        case let .stemDirection(payload):
            dump(indent + 2, payload)

        case .systemFormat:
            break

        case let .tempo(payload):
            dump(indent + 2, payload)

        case let .tempoChange(payload):
            dump(indent + 2, payload)

        case let .text(payload):
            dump(indent + 2, payload)

        case let .tie(payload):
            dump(indent + 2, payload)

        case let .titleBlock(payload):
            dump(indent + 2, payload)

        case let .tremolo(payload):
            dump(indent + 2, payload)

        case let .tuplet(payload):
            dump(indent + 2, payload)

        case let .units(payload):
            dump(indent + 2, payload)

        case let .volta(payload):
            dump(indent + 2, payload)
        }

        for symbol in body {
            dump(indent + 2, symbol)
        }
    }

    internal func dump(_ indent: Int,
                       fields: [(String, String?)],
                       label: String = "") {
        var line = ""

        for (fieldLabel, value) in fields {
            guard let value
            else { continue }

            if !line.isEmpty {
                line += spacer()
            }

            line += fieldLabel
            line += " "
            line += value
        }

        guard !line.isEmpty
        else { return }

        if !label.isEmpty {
            line = label + spacer() + line
        }

        emit(indent, line)
    }

    internal func fields(_ controlPoints: GMNTag.ControlPoints) -> [(String, String?)] {
        [("Dx1", controlPoints.dx1.map { format($0) }),
         ("Dy1", controlPoints.dy1.map { format($0) }),
         ("Dx2", controlPoints.dx2.map { format($0) }),
         ("Dy2", controlPoints.dy2.map { format($0) })]
    }

    internal func fields(_ textStyle: GMNTag.TextStyle) -> [(String, String?)] {
        [("Font", textStyle.font.map { format($0) }),
         ("Font size", textStyle.fontSize.map { format($0) }),
         ("Font attributes", textStyle.fontAttributes.map { format($0) }),
         ("Text format", textStyle.textFormat.map { format($0) })]
    }

    internal func format(_ curve: GMNTag.Curve) -> String {
        switch curve {
        case .down:
            "Down"

        case .up:
            "Up"
        }
    }

    internal func format(_ length: GMNLength) -> String {
        var result = format(length.value)

        if let unit = length.unit {
            result += unit.rawValue
        }

        return result
    }

    internal func format(_ numberOrName: GMNTag.NumberOrName) -> String {
        switch numberOrName {
        case let .name(name):
            format(name)

        case let .number(number):
            format(number)
        }
    }

    internal func format(_ placement: GMNTag.Placement) -> String {
        switch placement {
        case .above:
            "Above"

        case .below:
            "Below"
        }
    }

    internal func format(_ span: GMNTag.Span) -> String {
        switch span {
        case .begin:
            "Begin"

        case .end:
            "End"

        case .whole:
            "Whole"
        }
    }

    // MARK: Private Instance Methods

    private func _dump(_ indent: Int,
                       _ appearance: GMNTag.Appearance) {
        dump(indent,
             fields: [("Color", appearance.color.map { format($0) }),
                      ("Dx", appearance.dx.map { format($0) }),
                      ("Dy", appearance.dy.map { format($0) }),
                      ("Size", appearance.size.map { format($0) })],
             label: "Appearance")
    }

    private func _dump(_ indent: Int,
                       _ parameter: GMNTag.Parameter,
                       _ index: Int) {
        var line = "Parameter #"

        line += format(index + 1)

        if let name = parameter.name {
            line += spacer()
            line += name.stringValue
        }

        line += spacer()

        switch parameter.value {
        case let .floating(value, unit):
            line += format(value)

            if let unit {
                line += unit.rawValue
            }

        case let .integer(value, unit):
            line += format(value)

            if let unit {
                line += unit.rawValue
            }

        case let .parameter(value):
            line += value

        case let .string(value):
            line += format(value)

        case let .variable(value):
            line += value.stringValue
        }

        emit(indent, line)
    }

    private func _dump(_ indent: Int,
                       _ parameters: [GMNTag.Parameter]) {
        for (index, parameter) in parameters.enumerated() {
            _dump(indent, parameter, index)
        }
    }
}
