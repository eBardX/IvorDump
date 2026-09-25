// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func format(_ clef: MXLClef) -> String {
        var result = "Clef"

        if let number = clef.number {
            result += spacer()
            result += "Staff "
            result += format(number.uintValue)
        }

        result += spacer()
        result += format(clef.content)

        if let size = clef.size,
           size != .full {
            result += spacer()
            result += format(size)
        }

        append(&result, clef.isAdditional, "Additional", "Not additional")

        append(&result, clef.isAfterBarline, "After barline", "Before barline")

        append(&result, clef.printsObject, "Printed", "Not printed")
        append(&result, format(clef.position))
        append(&result, format(clef.font))
        append(&result, clef.color.map { format($0) })

        return result
    }

    internal func format(_ content: MXLClef.Content) -> String {
        var result = _format(content.sign)

        if let clefLine = content.line {
            result += spacer()
            result += "Line "
            result += format(clefLine.intValue)
        }

        if let octaveChange = content.octaveChange {
            result += spacer()
            result += _format(octaveChange)
        }

        return result
    }

    internal func format(_ content: MXLTranspose.Content) -> String {
        var result = format(content.chromatic) + " semitone(s)"

        if let diatonic = content.diatonic {
            result += spacer()
            result += format(diatonic.intValue)
            result += " step(s)"
        }

        if let octaveChange = content.octaveChange {
            result += spacer()
            result += _format(octaveChange)
        }

        if let double = content.double {
            result += spacer()

            if let isAbove = double.isAbove {
                result += isAbove ? "Double above" : "Double below"
            } else {
                result += "Double"
            }
        }

        return result
    }

    internal func format(_ partSymbol: MXLPartSymbol) -> String {
        var result = "Part symbol "

        result += format(partSymbol.value)

        if let topStaff = partSymbol.topStaff {
            result += spacer()
            result += "Top "
            result += format(topStaff.uintValue)
        }

        if let bottomStaff = partSymbol.bottomStaff {
            result += spacer()
            result += "Bottom "
            result += format(bottomStaff.uintValue)
        }

        append(&result, format(partSymbol.position))
        append(&result, partSymbol.color.map { format($0) })

        return result
    }

    internal func format(_ value: MXLGroupSymbolValue) -> String {
        switch value {
        case .brace:
            "Brace"

        case .bracket:
            "Bracket"

        case .line:
            "Line"

        case .square:
            "Square"

        case .unmarked:
            "Unmarked"
        }
    }

    // MARK: Private Instance Methods

    private func _format(_ octaveChange: MXLOctaveChange) -> String {
        let value = octaveChange.intValue

        return (value > 0 ? "+" : "") + format(value) + " octave"
    }

    private func _format(_ sign: MXLClef.Sign) -> String {
        switch sign {
        case .c:
            "C"

        case .f:
            "F"

        case .g:
            "G"

        case .invisible:
            "Invisible"

        case .jianpu:
            "Jianpu"

        case .percussion:
            "Percussion"

        case .tAB:
            "TAB"
        }
    }
}
