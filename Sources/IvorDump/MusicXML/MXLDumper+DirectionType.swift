// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func format(_ bracket: MXLBracket) -> String {
        var result = format("Bracket", bracket.kind, bracket.number)

        result += spacer()
        result += "End "
        result += format(bracket.lineEnd)

        if let endLength = bracket.endLength {
            result += spacer()
            result += "End length "
            result += format(endLength)
        }

        append(&result, bracket.lineKind.map { "Line " + format($0) })
        append(&result, format(dashLength: bracket.dashLength, spaceLength: bracket.spaceLength))
        append(&result, format(bracket.position))
        append(&result, bracket.color.map { format($0) })

        return result
    }

    internal func format(_ coda: MXLCoda) -> String {
        var result = "Coda"

        append(&result, coda.smufl.map { format($0.stringValue) })
        appendStyle(&result,
                    position: coda.position,
                    font: coda.font,
                    color: coda.color,
                    halign: coda.halign,
                    valign: coda.valign)

        return result
    }

    internal func format(_ divide: MXLStaffDivide) -> String {
        var result = "Staff divide"

        result += spacer()
        result += _format(divide.kind)

        appendStyle(&result,
                    position: divide.position,
                    font: divide.font,
                    color: divide.color,
                    halign: divide.halign,
                    valign: divide.valign)

        return result
    }

    internal func format(_ harpPedals: MXLHarpPedals) -> String {
        var result = "Harp pedals"

        for tuning in harpPedals.pedalTuning {
            result += spacer()
            result += format(tuning.pedalStep)
            result += formatAlter(tuning.pedalAlter)
        }

        appendStyle(&result,
                    position: harpPedals.position,
                    font: harpPedals.font,
                    color: harpPedals.color,
                    halign: harpPedals.halign,
                    valign: harpPedals.valign)

        return result
    }

    internal func format(_ mute: MXLStringMute) -> String {
        var result = "String mute"

        result += spacer()
        result += mute.isOn ? "On" : "Off"

        appendStyle(&result,
                    position: mute.position,
                    font: mute.font,
                    color: mute.color,
                    halign: mute.halign,
                    valign: mute.valign)

        return result
    }

    internal func format(_ pedal: MXLPedal) -> String {
        var result = "Pedal "

        result += _format(pedal.kind)

        if let number = pedal.number {
            result += spacer()
            result += format(number.uintValue)
        }

        append(&result, pedal.usesLines, "Lines", "No lines")

        append(&result, pedal.usesSigns, "Signs", "No signs")

        append(&result, pedal.isAbbreviated, "Abbreviated", "Not abbreviated")
        append(&result, pedal.halign.map { "H " + format($0) })
        append(&result, pedal.valign.map { "V " + format($0) })
        append(&result, format(pedal.position))
        append(&result, format(pedal.font))
        append(&result, pedal.color.map { format($0) })

        return result
    }

    internal func format(_ segno: MXLSegno) -> String {
        var result = "Segno"

        append(&result, segno.smufl.map { format($0.stringValue) })
        appendStyle(&result,
                    position: segno.position,
                    font: segno.font,
                    color: segno.color,
                    halign: segno.halign,
                    valign: segno.valign)

        return result
    }

    internal func format(_ shift: MXLOctaveShift) -> String {
        var result = "Octave shift "

        result += _format(shift.kind)
        result += spacer()
        result += format(shift.size)

        if let number = shift.number {
            result += spacer()
            result += format(number.uintValue)
        }

        append(&result, format(dashLength: shift.dashLength, spaceLength: shift.spaceLength))
        append(&result, format(shift.position))
        append(&result, format(shift.font))
        append(&result, shift.color.map { format($0) })

        return result
    }

    internal func format(_ voice: MXLPrincipalVoice) -> String {
        var result = "Principal voice "

        result += format(voice.kind)
        result += spacer()
        result += _format(voice.symbol)

        if !voice.value.isEmpty {
            result += spacer()
            result += format(voice.value)
        }

        appendStyle(&result,
                    position: voice.position,
                    font: voice.font,
                    color: voice.color,
                    halign: voice.halign,
                    valign: voice.valign)

        return result
    }

    internal func format(_ wedge: MXLWedge) -> String {
        var result = "Wedge "

        result += _format(wedge.kind)

        if let number = wedge.number {
            result += spacer()
            result += format(number.uintValue)
        }

        if let spread = wedge.spread {
            result += spacer()
            result += "Spread "
            result += format(spread)
        }

        append(&result, wedge.isNiente, "Niente", "Not niente")
        append(&result, wedge.lineKind.map { "Line " + format($0) })
        append(&result, format(dashLength: wedge.dashLength, spaceLength: wedge.spaceLength))
        append(&result, format(wedge.position))
        append(&result, wedge.color.map { format($0) })

        return result
    }

    // MARK: Private Instance Methods

    private func _format(_ kind: MXLWedge.Kind) -> String {
        switch kind {
        case .continue:
            "Continue"

        case .crescendo:
            "Crescendo"

        case .diminuendo:
            "Diminuendo"

        case .stop:
            "Stop"
        }
    }

    private func _format(_ kind: MXLPedal.Kind) -> String {
        switch kind {
        case .change:
            "Change"

        case .continue:
            "Continue"

        case .discontinue:
            "Discontinue"

        case .resume:
            "Resume"

        case .sostenuto:
            "Sostenuto"

        case .start:
            "Start"

        case .stop:
            "Stop"
        }
    }

    private func _format(_ kind: MXLUpDownStopContinue) -> String {
        switch kind {
        case .continue:
            "Continue"

        case .down:
            "Down"

        case .stop:
            "Stop"

        case .up:
            "Up"
        }
    }

    private func _format(_ symbol: MXLPrincipalVoice.Symbol) -> String {
        switch symbol {
        case .hauptstimme:
            "Hauptstimme"

        case .invisible:
            "Invisible"

        case .nebenstimme:
            "Nebenstimme"

        case .plain:
            "Plain"
        }
    }

    private func _format(_ symbol: MXLStaffDivide.Symbol) -> String {
        switch symbol {
        case .down:
            "Down"

        case .up:
            "Up"

        case .upDown:
            "Up-down"
        }
    }
}
