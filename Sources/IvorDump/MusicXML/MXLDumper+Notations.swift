// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ notations: MXLNotations) {
        var line = "Notations"

        append(&line, notations.printsObject, "Printed", "Not printed")

        emit(indent, line)

        for item in notations.items {
            _dump(indent + 2, item)
        }
    }

    internal func format(_ label: String,
                         _ kind: MXLStartStop,
                         _ number: MXLNumberLevel,
                         _ value: String,
                         lineKind: MXLLineKind? = nil,
                         dashLength: MXLTenths? = nil,
                         spaceLength: MXLTenths? = nil,
                         position: MXLPosition? = nil,
                         font: MXLFont? = nil,
                         color: MXLColor? = nil) -> String {
        var result = label

        result += spacer()
        result += format(kind)
        result += spacer()
        result += format(number.uintValue)

        if !value.isEmpty {
            result += spacer()
            result += format(value)
        }

        append(&result, lineKind.map { "Line " + format($0) })
        append(&result, format(dashLength: dashLength, spaceLength: spaceLength))
        append(&result, position.flatMap { format($0) })
        append(&result, font.flatMap { format($0) })
        append(&result, color.map { format($0) })

        return result
    }

    // MARK: Private Instance Methods

    private func _dump(_ indent: Int,
                       _ item: MXLNotations.Item) {
        switch item {
        case let .accidentalMark(mark):
            emit(indent, format(mark))

        case let .arpeggiate(arpeggiate):
            emit(indent, _format(arpeggiate))

        case let .articulations(articulations):
            emit(indent, "Articulations")

            for item in articulations.items {
                dump(indent + 2, item)
            }

        case let .dynamics(dynamics):
            emit(indent, format(dynamics))

        case let .fermata(fermata):
            var line = "Fermata"

            line += spacer()
            line += format(fermata.value)
            line += spacer()
            line += format(fermata.kind)

            append(&line, format(fermata.position))
            append(&line, format(fermata.font))
            append(&line, fermata.color.map { format($0) })

            emit(indent, line)

        case let .glissando(glissando):
            emit(indent,
                 format("Glissando",
                        glissando.kind,
                        glissando.number,
                        glissando.value,
                        lineKind: glissando.lineKind,
                        dashLength: glissando.dashLength,
                        spaceLength: glissando.spaceLength,
                        position: glissando.position,
                        font: glissando.font,
                        color: glissando.color))

        case let .nonArpeggiate(nonArpeggiate):
            emit(indent, _format(nonArpeggiate))

        case let .ornaments(ornaments):
            emit(indent, "Ornaments")

            dump(indent + 2, ornaments.content)

            for mark in ornaments.accidentalMark {
                emit(indent + 2, format(mark))
            }

        case let .otherNotation(other):
            var line = "Other notation"

            line += spacer()
            line += format(other.kind)
            line += spacer()
            line += format(other.value)

            append(&line, other.printsObject, "Printed", "Not printed")
            append(&line, other.placement.map { format($0) })
            append(&line, other.smufl.map { format($0.stringValue) })
            append(&line, format(other.position))
            append(&line, format(other.font))
            append(&line, other.color.map { format($0) })

            emit(indent, line)

        case let .slide(slide):
            var line = format("Slide",
                              slide.kind,
                              slide.number,
                              slide.value,
                              lineKind: slide.lineKind,
                              dashLength: slide.dashLength,
                              spaceLength: slide.spaceLength,
                              position: slide.position,
                              font: slide.font,
                              color: slide.color)

            append(&line, format(slide.bendSound))

            emit(indent, line)

        case let .slur(slur):
            emit(indent, _format(slur))

        case let .technical(technical):
            emit(indent, "Technical")

            for item in technical.items {
                dump(indent + 2, item)
            }

        case let .tied(tied):
            emit(indent, _format(tied))

        case let .tuplet(tuplet):
            emit(indent, _format(tuplet))
        }
    }

    private func _format(_ arpeggiate: MXLArpeggiate) -> String {
        var result = "Arpeggiate"

        if let direction = arpeggiate.direction {
            result += spacer()
            result += format(direction)
        }

        if let number = arpeggiate.number {
            result += spacer()
            result += format(number.uintValue)
        }

        append(&result, arpeggiate.isUnbroken, "Unbroken", "Broken")
        append(&result, arpeggiate.placement.map { format($0) })
        append(&result, format(arpeggiate.position))
        append(&result, arpeggiate.color.map { format($0) })

        return result
    }

    private func _format(_ nonArpeggiate: MXLNonArpeggiate) -> String {
        var result = "Non-arpeggiate"

        result += spacer()
        result += format(nonArpeggiate.kind)

        if let number = nonArpeggiate.number {
            result += spacer()
            result += format(number.uintValue)
        }

        append(&result, nonArpeggiate.placement.map { format($0) })
        append(&result, format(nonArpeggiate.position))
        append(&result, nonArpeggiate.color.map { format($0) })

        return result
    }

    private func _format(_ slur: MXLSlur) -> String {
        var result = "Slur"

        result += spacer()
        result += format(slur.kind)
        result += spacer()
        result += format(slur.number.uintValue)

        append(&result, slur.orientation.map { format($0) })
        append(&result, slur.placement.map { format($0) })
        append(&result, slur.lineKind.map { "Line " + format($0) })
        append(&result, format(dashLength: slur.dashLength, spaceLength: slur.spaceLength))
        append(&result, format(bezierOf: slur))
        append(&result, format(slur.position))
        append(&result, slur.color.map { format($0) })

        return result
    }

    private func _format(_ tied: MXLTied) -> String {
        var result = "Tied"

        result += spacer()
        result += format(tied.kind)

        if let number = tied.number {
            result += spacer()
            result += format(number.uintValue)
        }

        append(&result, tied.orientation.map { format($0) })
        append(&result, tied.placement.map { format($0) })
        append(&result, tied.lineKind.map { "Line " + format($0) })
        append(&result, format(dashLength: tied.dashLength, spaceLength: tied.spaceLength))
        append(&result, format(bezierOf: tied))
        append(&result, format(tied.position))
        append(&result, tied.color.map { format($0) })

        return result
    }

    private func _format(_ tuplet: MXLTuplet) -> String {
        var result = "Tuplet"

        result += spacer()
        result += format(tuplet.kind)

        if let number = tuplet.number {
            result += spacer()
            result += format(number.uintValue)
        }

        if let actual = _format(portion: tuplet.actual) {
            result += spacer()
            result += "Actual "
            result += actual
        }

        if let normal = _format(portion: tuplet.normal) {
            result += spacer()
            result += "Normal "
            result += normal
        }

        append(&result, tuplet.hasBracket, "Bracket", "No bracket")
        append(&result, tuplet.showNumber.map { "Number " + format($0) })
        append(&result, tuplet.showType.map { "Type " + format($0) })
        append(&result, tuplet.lineShape.map { format($0) })
        append(&result, tuplet.placement.map { format($0) })
        append(&result, format(tuplet.position))

        return result
    }

    private func _format(portion: MXLTuplet.Portion?) -> String? {
        guard let portion
        else { return nil }

        var parts: [String] = []

        if let number = portion.number {
            var numberText = format(number.value)

            append(&numberText, format(number.font))
            append(&numberText, number.color.map { format($0) })
            parts.append(numberText)
        }

        if let kind = portion.kind {
            parts.append(format(kind.value))
        }

        if !portion.dot.isEmpty {
            parts.append(format(portion.dot.count, "dot"))
        }

        return parts.isEmpty ? nil : parts.joined(separator: " ")
    }
}
