// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func format(_ align: MXLValignImage) -> String {
        switch align {
        case .bottom:
            "bottom"

        case .middle:
            "middle"

        case .top:
            "top"
        }
    }

    internal func format(_ align: MXLLeftCenterRight) -> String {
        switch align {
        case .center:
            "center"

        case .left:
            "left"

        case .right:
            "right"
        }
    }

    internal func format(_ align: MXLValign) -> String {
        switch align {
        case .baseline:
            "baseline"

        case .bottom:
            "bottom"

        case .middle:
            "middle"

        case .top:
            "top"
        }
    }

    internal func format(_ image: MXLImage) -> String {
        var result = "Image "

        result += format(image.attributes.source)
        result += spacer()
        result += "Type "
        result += format(image.attributes.kind)

        if let width = image.attributes.width {
            result += spacer()
            result += "Width "
            result += format(width)
        }

        if let height = image.attributes.height {
            result += spacer()
            result += "Height "
            result += format(height)
        }

        append(&result, image.attributes.halign.map { "H " + format($0) })
        append(&result, image.attributes.valign.map { "V " + format($0) })
        append(&result, format(image.attributes.position))

        if let id = image.id {
            result += spacer()
            result += "ID "
            result += format(id)
        }

        return result
    }

    internal func format(_ shape: MXLEnclosureShape) -> String {
        switch shape {
        case .bracket:
            "Bracket"

        case .circle:
            "Circle"

        case .decagon:
            "Decagon"

        case .diamond:
            "Diamond"

        case .heptagon:
            "Heptagon"

        case .hexagon:
            "Hexagon"

        case .invertedBracket:
            "Inverted bracket"

        case .nonagon:
            "Nonagon"

        case .octagon:
            "Octagon"

        case .oval:
            "Oval"

        case .pentagon:
            "Pentagon"

        case .rectangle:
            "Rectangle"

        case .square:
            "Square"

        case .triangle:
            "Triangle"

        case .unenclosed:
            "Unenclosed"
        }
    }

    internal func format(_ styleText: MXLStyleText) -> String {
        var result = format(styleText.value)

        append(&result, format(styleText.printStyle))

        return result
    }

    internal func format(_ symbol: MXLFormattedSymbolID) -> String {
        var result = format(symbol.value)

        append(&result, symbol.id.map { "ID " + format($0) })
        append(&result, symbol.halign.map { "H " + format($0) })
        append(&result, symbol.valign.map { "V " + format($0) })
        append(&result, symbol.justify.map { "Justify " + format($0) })
        append(&result, format(symbol.position))
        append(&result, format(symbol.font))
        append(&result, symbol.color.map { format($0) })
        append(&result, symbol.enclosure.map { "Enclosure " + format($0) })
        append(&result,
               format(dir: symbol.dir,
                      letterSpacing: symbol.letterSpacing,
                      lineHeight: symbol.lineHeight,
                      lineThrough: symbol.lineThrough,
                      overline: symbol.overline,
                      rotation: symbol.rotation,
                      underline: symbol.underline,
                      xmlLang: nil))

        return result
    }

    internal func format(_ text: MXLAccidentalText) -> String {
        var result = format(text.value)

        append(&result, text.smufl.map { format($0.stringValue) })
        append(&result, text.halign.map { "H " + format($0) })
        append(&result, text.valign.map { "V " + format($0) })
        append(&result, text.justify.map { "Justify " + format($0) })
        append(&result, text.enclosure.map { "Enclosure " + format($0) })
        append(&result, format(text.position))
        append(&result, format(text.font))
        append(&result, text.color.map { format($0) })
        append(&result,
               format(dir: text.dir,
                      letterSpacing: text.letterSpacing,
                      lineHeight: text.lineHeight,
                      lineThrough: text.lineThrough,
                      overline: text.overline,
                      rotation: text.rotation,
                      underline: text.underline,
                      xmlLang: text.xmlLang))
        append(&result, text.xmlSpace.map { "Space " + format($0) })

        return result
    }

    internal func format(_ text: MXLFormattedText) -> String {
        var result = format(text.value)

        append(&result, text.halign.map { "H " + format($0) })
        append(&result, text.valign.map { "V " + format($0) })
        append(&result, text.justify.map { "Justify " + format($0) })
        append(&result, format(text.position))
        append(&result, format(text.font))
        append(&result, text.color.map { format($0) })
        append(&result, text.enclosure.map { "Enclosure " + format($0) })
        append(&result,
               format(dir: text.dir,
                      letterSpacing: text.letterSpacing,
                      lineHeight: text.lineHeight,
                      lineThrough: text.lineThrough,
                      overline: text.overline,
                      rotation: text.rotation,
                      underline: text.underline,
                      xmlLang: text.xmlLang))
        append(&result, text.xmlSpace.map { "Space " + format($0) })

        return result
    }

    internal func format(_ text: MXLFormattedTextID) -> String {
        var result = format(text.value)

        append(&result, text.id.map { "ID " + format($0) })
        append(&result, text.halign.map { "H " + format($0) })
        append(&result, text.valign.map { "V " + format($0) })
        append(&result, text.justify.map { "Justify " + format($0) })
        append(&result, format(text.position))
        append(&result, format(text.font))
        append(&result, text.color.map { format($0) })
        append(&result, text.enclosure.map { "Enclosure " + format($0) })
        append(&result,
               format(dir: text.dir,
                      letterSpacing: text.letterSpacing,
                      lineHeight: text.lineHeight,
                      lineThrough: text.lineThrough,
                      overline: text.overline,
                      rotation: text.rotation,
                      underline: text.underline,
                      xmlLang: text.xmlLang))
        append(&result, text.xmlSpace.map { "Space " + format($0) })

        return result
    }

    internal func format(_ text: MXLTextElementData) -> String {
        var result = format(text.value)

        append(&result, format(text.font))
        append(&result, text.color.map { format($0) })
        append(&result,
               format(dir: text.dir,
                      letterSpacing: text.letterSpacing,
                      lineHeight: nil,
                      lineThrough: text.lineThrough,
                      overline: text.overline,
                      rotation: text.rotation,
                      underline: text.underline,
                      xmlLang: text.xmlLang))

        return result
    }

    internal func format(dir: MXLTextDirection,
                         letterSpacing: MXLNumberOrNormal,
                         lineHeight: MXLNumberOrNormal?,
                         lineThrough: MXLNumberOfLines?,
                         overline: MXLNumberOfLines?,
                         rotation: MXLRotationDegrees?,
                         underline: MXLNumberOfLines?,
                         xmlLang: String?) -> String? {
        var parts: [String] = []

        if dir != .ltr {
            parts.append("Dir " + _format(dir))
        }

        if case let .number(spacing) = letterSpacing {
            parts.append("Letter spacing " + format(spacing))
        }

        if let lineHeight,
           case let .number(height) = lineHeight {
            parts.append("Line height " + format(height))
        }

        if let lineThrough {
            parts.append("Line-through " + format(lineThrough.uintValue))
        }

        if let overline {
            parts.append("Overline " + format(overline.uintValue))
        }

        if let underline {
            parts.append("Underline " + format(underline.uintValue))
        }

        if let rotation {
            parts.append("Rotation " + format(rotation))
        }

        if let xmlLang {
            parts.append("Lang " + format(xmlLang))
        }

        return parts.isEmpty ? nil : parts.joined(separator: spacer())
    }

    // MARK: Private Instance Methods

    private func _format(_ direction: MXLTextDirection) -> String {
        switch direction {
        case .lro:
            "LRO"

        case .ltr:
            "LTR"

        case .rlo:
            "RLO"

        case .rtl:
            "RTL"
        }
    }
}
