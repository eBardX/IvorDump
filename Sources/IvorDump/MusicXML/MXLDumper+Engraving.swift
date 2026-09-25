// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func append(_ result: inout String,
                         _ token: String?) {
        guard let token
        else { return }

        result += spacer()
        result += token
    }

    internal func append(_ result: inout String,
                         _ value: Bool?,
                         _ whenTrue: String,
                         _ whenFalse: String) {
        guard let value
        else { return }

        result += spacer()
        result += value ? whenTrue : whenFalse
    }

    internal func appendPlacement(_ line: inout String,
                                  placement: MXLAboveBelow?,
                                  position: MXLPosition,
                                  font: MXLFont,
                                  color: MXLColor?,
                                  smufl: MXLSmuflGlyphName? = nil) {
        append(&line, placement.map { format($0) })
        append(&line, smufl.map { format($0.stringValue) })
        append(&line, format(position))
        append(&line, format(font))
        append(&line, color.map { format($0) })
    }

    internal func appendStyle(_ line: inout String,
                              position: MXLPosition,
                              font: MXLFont,
                              color: MXLColor?,
                              halign: MXLLeftCenterRight? = nil,
                              valign: MXLValign? = nil,
                              enclosure: MXLEnclosureShape? = nil) {
        append(&line, halign.map { "H " + format($0) })
        append(&line, valign.map { "V " + format($0) })
        append(&line, enclosure.map { "Enclosure " + format($0) })
        append(&line, format(position))
        append(&line, format(font))
        append(&line, color.map { format($0) })
    }

    internal func format(_ color: MXLColor) -> String {
        "Color " + format(color.stringValue)
    }

    internal func format(_ end: MXLLineEnd) -> String {
        switch end {
        case .arrow:
            "arrow"

        case .both:
            "both"

        case .down:
            "down"

        case .plain:
            "plain"

        case .up:
            "up"
        }
    }

    internal func format(_ font: MXLFont) -> String? {
        var parts: [String] = []

        if let family = font.family,
           !family.isEmpty {
            parts.append(family.joined(separator: ","))
        }

        if let size = font.size {
            switch size {
            case let .css(cssSize):
                parts.append(String(describing: cssSize))

            case let .point(points):
                parts.append(format(points) + "pt")
            }
        }

        if font.style == .italic {
            parts.append("Italic")
        }

        if font.weight == .bold {
            parts.append("Bold")
        }

        guard !parts.isEmpty
        else { return nil }

        return "Font " + parts.joined(separator: " ")
    }

    internal func format(_ kind: MXLLineKind) -> String {
        switch kind {
        case .dashed:
            "dashed"

        case .dotted:
            "dotted"

        case .solid:
            "solid"

        case .wavy:
            "wavy"
        }
    }

    internal func format(_ label: String,
                         _ position: MXLPosition,
                         _ font: MXLFont,
                         _ color: MXLColor?,
                         _ placement: MXLAboveBelow?,
                         smufl: MXLSmuflGlyphName? = nil) -> String {
        var result = label

        append(&result, placement.map { format($0) })
        append(&result, format(position))
        append(&result, format(font))
        append(&result, color.map { format($0) })
        append(&result, smufl.map { format($0.stringValue) })

        return result
    }

    internal func format(_ position: MXLYPosition) -> String? {
        var parts: [String] = []

        if let defaultX = position.defaultX {
            parts.append("dx " + format(defaultX))
        }

        if let defaultY = position.defaultY {
            parts.append("dy " + format(defaultY))
        }

        if let relativeX = position.relativeX {
            parts.append("rx " + format(relativeX))
        }

        if let relativeY = position.relativeY {
            parts.append("ry " + format(relativeY))
        }

        return parts.isEmpty ? nil : parts.joined(separator: " ")
    }

    internal func format(_ position: MXLPosition) -> String? {
        var parts: [String] = []

        if let defaultX = position.defaultX {
            parts.append("dx " + format(defaultX))
        }

        if let defaultY = position.defaultY {
            parts.append("dy " + format(defaultY))
        }

        if let relativeX = position.relativeX {
            parts.append("rx " + format(relativeX))
        }

        if let relativeY = position.relativeY {
            parts.append("ry " + format(relativeY))
        }

        return parts.isEmpty ? nil : parts.joined(separator: " ")
    }

    internal func format(_ position: MXLXPosition) -> String? {
        var parts: [String] = []

        if let defaultX = position.defaultX {
            parts.append("dx " + format(defaultX))
        }

        if let defaultY = position.defaultY {
            parts.append("dy " + format(defaultY))
        }

        if let relativeX = position.relativeX {
            parts.append("rx " + format(relativeX))
        }

        if let relativeY = position.relativeY {
            parts.append("ry " + format(relativeY))
        }

        guard !parts.isEmpty
        else { return nil }

        return parts.joined(separator: " ")
    }

    internal func format(_ printStyle: MXLPrintStyle) -> String? {
        var parts: [String] = []

        if let position = format(printStyle.position) {
            parts.append(position)
        }

        if let font = format(printStyle.font) {
            parts.append(font)
        }

        if let color = printStyle.color {
            parts.append(format(color))
        }

        return parts.isEmpty ? nil : parts.joined(separator: spacer())
    }

    internal func format(_ printStyleAlign: MXLPrintStyleAlign) -> String? {
        var parts: [String] = []

        if let printStyle = format(printStyleAlign.printStyle) {
            parts.append(printStyle)
        }

        if let halign = printStyleAlign.halign {
            parts.append("H " + format(halign))
        }

        if let valign = printStyleAlign.valign {
            parts.append("V " + format(valign))
        }

        return parts.isEmpty ? nil : parts.joined(separator: spacer())
    }

    internal func format(_ shape: MXLLineShape) -> String {
        switch shape {
        case .curved:
            "Curved"

        case .straight:
            "Straight"
        }
    }

    internal func format(_ show: MXLShowTuplet) -> String {
        switch show {
        case .actual:
            "actual"

        case .both:
            "both"

        case .neither:
            "neither"
        }
    }

    internal func format(bezierOf slur: MXLSlur) -> String? {
        _format(bezierX: slur.bezierX,
                bezierY: slur.bezierY,
                bezierX2: slur.bezierX2,
                bezierY2: slur.bezierY2,
                bezierOffset: slur.bezierOffset,
                bezierOffset2: slur.bezierOffset2)
    }

    internal func format(bezierOf tied: MXLTied) -> String? {
        _format(bezierX: tied.bezierX,
                bezierY: tied.bezierY,
                bezierX2: tied.bezierX2,
                bezierY2: tied.bezierY2,
                bezierOffset: tied.bezierOffset,
                bezierOffset2: tied.bezierOffset2)
    }

    internal func format(dashLength: MXLTenths?,
                         spaceLength: MXLTenths?) -> String? {
        var parts: [String] = []

        if let dashLength {
            parts.append("dash " + format(dashLength))
        }

        if let spaceLength {
            parts.append("space " + format(spaceLength))
        }

        return parts.isEmpty ? nil : parts.joined(separator: " ")
    }

    internal func format(lineLength: MXLLineLength) -> String {
        switch lineLength {
        case .long:
            "long"

        case .medium:
            "medium"

        case .short:
            "short"
        }
    }

    // MARK: Private Instance Methods

    private func _format(bezierX: MXLTenths?,
                         bezierY: MXLTenths?,
                         bezierX2: MXLTenths?,
                         bezierY2: MXLTenths?,
                         bezierOffset: MXLDivisions?,
                         bezierOffset2: MXLDivisions?) -> String? {
        var parts: [String] = []

        if let bezierX {
            parts.append("bx " + format(bezierX))
        }

        if let bezierY {
            parts.append("by " + format(bezierY))
        }

        if let bezierX2 {
            parts.append("bx2 " + format(bezierX2))
        }

        if let bezierY2 {
            parts.append("by2 " + format(bezierY2))
        }

        if let bezierOffset {
            parts.append("bo " + format(bezierOffset.intValue))
        }

        if let bezierOffset2 {
            parts.append("bo2 " + format(bezierOffset2.intValue))
        }

        return parts.isEmpty ? nil : "Bezier " + parts.joined(separator: " ")
    }
}
