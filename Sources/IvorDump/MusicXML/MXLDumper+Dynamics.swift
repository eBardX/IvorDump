// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func format(_ dynamics: MXLDynamics) -> String {
        var result = "Dynamics"

        for item in dynamics.items {
            result += spacer()
            result += _format(item)
        }

        append(&result, dynamics.placement.map { format($0) })
        appendStyle(&result,
                    position: dynamics.position,
                    font: dynamics.font,
                    color: dynamics.color,
                    halign: dynamics.halign,
                    valign: dynamics.valign,
                    enclosure: dynamics.enclosure)
        append(&result,
               format(dir: .ltr,
                      letterSpacing: .normal,
                      lineHeight: nil,
                      lineThrough: dynamics.lineThrough,
                      overline: dynamics.overline,
                      rotation: nil,
                      underline: dynamics.underline,
                      xmlLang: nil))

        return result
    }

    internal func format(_ shape: MXLFermata.Shape) -> String {
        switch shape {
        case .angled:
            "Angled"

        case .curlew:
            "Curlew"

        case .doubleAngled:
            "Double angled"

        case .doubleDot:
            "Double dot"

        case .doubleSquare:
            "Double square"

        case .empty:
            "Empty"

        case .halfCurve:
            "Half curve"

        case .normal:
            "Normal"

        case .square:
            "Square"
        }
    }

    // MARK: Private Instance Methods

    private func _format(_ item: MXLDynamics.Item) -> String {
        if case let .otherDynamics(other) = item {
            var result = format(other.value)

            append(&result, other.smufl.map { format($0.stringValue) })

            return result
        }

        return _formatMarking(item)
    }

    private func _formatMarking(_ item: MXLDynamics.Item) -> String {
        switch item {
        case .f:
            "f"

        case .ff:
            "ff"

        case .fff:
            "fff"

        case .ffff:
            "ffff"

        case .fffff:
            "fffff"

        case .ffffff:
            "ffffff"

        case .fp:
            "fp"

        case .fz:
            "fz"

        case .mf:
            "mf"

        case .mp:
            "mp"

        case .n:
            "n"

        case .otherDynamics:
            ""

        case .p:
            "p"

        case .pf:
            "pf"

        case .pp:
            "pp"

        case .ppp:
            "ppp"

        case .pppp:
            "pppp"

        case .ppppp:
            "ppppp"

        case .pppppp:
            "pppppp"

        case .rf:
            "rf"

        case .rfz:
            "rfz"

        case .sf:
            "sf"

        case .sffz:
            "sffz"

        case .sfp:
            "sfp"

        case .sfpp:
            "sfpp"

        case .sfz:
            "sfz"

        case .sfzp:
            "sfzp"
        }
    }
}
