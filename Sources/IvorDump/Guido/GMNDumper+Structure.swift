// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorGuido

extension GMNDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ payload: GMNAccolade) {
        dump(indent,
             fields: [("Id", format(payload.id)),
                      ("Range", format(payload.range)),
                      ("Type", payload.type.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNAuto) {
        dump(indent,
             fields: [("Auto clef key meter order", payload.autoClefKeyMeterOrder.map { format($0) }),
                      ("Auto end bar", payload.autoEndBar.map { format($0) }),
                      ("Auto hide tied accidentals", payload.autoHideTiedAccidentals.map { format($0) }),
                      ("Auto instr pos", payload.autoInstrPos.map { format($0) }),
                      ("Auto intens pos", payload.autoIntensPos.map { format($0) }),
                      ("Auto lyrics pos", payload.autoLyricsPos.map { format($0) }),
                      ("Auto page break", payload.autoPageBreak.map { format($0) }),
                      ("Auto stretch first line", payload.autoStretchFirstLine.map { format($0) }),
                      ("Auto stretch last line", payload.autoStretchLastLine.map { format($0) }),
                      ("Auto system break", payload.autoSystemBreak.map { format($0) }),
                      ("Clef key meter order", payload.clefKeyMeterOrder.map { format($0) }),
                      ("End bar", payload.endBar.map { format($0) }),
                      ("Fingering pos", payload.fingeringPos.map { format($0) }),
                      ("Fingering size", payload.fingeringSize.map { format($0) }),
                      ("Harmony pos", payload.harmonyPos.map { format($0) }),
                      ("Instr auto pos", payload.instrAutoPos.map { format($0) }),
                      ("Intens auto pos", payload.intensAutoPos.map { format($0) }),
                      ("Lyrics auto pos", payload.lyricsAutoPos.map { format($0) }),
                      ("Page break", payload.pageBreak.map { format($0) }),
                      ("Resolve multi voice collisions", payload.resolveMultiVoiceCollisions.map { format($0) }),
                      ("Stretch first line", payload.stretchFirstLine.map { format($0) }),
                      ("Stretch last line", payload.stretchLastLine.map { format($0) }),
                      ("System break", payload.systemBreak.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNBarFormat) {
        dump(indent,
             fields: [("Range", payload.range.map { format($0) }),
                      ("Style", payload.style.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNBarLine) {
        dump(indent,
             fields: [("Kind", _format(payload.kind)),
                      ("Display meas num", payload.displayMeasNum.map { format($0) }),
                      ("Hidden", payload.hidden.map { format($0) }),
                      ("Meas num", payload.measNum.map { format($0) }),
                      ("Num dx", payload.numDx.map { format($0) }),
                      ("Num dy", payload.numDy.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNClef) {
        dump(indent,
             fields: [("Type", format(payload.type))])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNCue) {
        dump(indent,
             fields: [("Cue name", payload.cueName.map { format($0) })] + fields(payload.textStyle))
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNHarmony) {
        dump(indent,
             fields: [("Text", format(payload.text))] + fields(payload.textStyle))
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNInstrument) {
        dump(indent,
             fields: [("Instrument name", format(payload.instrumentName)),
                      ("Midi", payload.midi.map { format($0) }),
                      ("Autopos", payload.autopos.map { format($0) }),
                      ("Repeats", payload.repeats.map { format($0) }),
                      ("Transp", payload.transp.map { format($0) })] + fields(payload.textStyle))
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNJump) {
        dump(indent,
             fields: [("Kind", _format(payload.kind)),
                      ("Id", payload.id.map { format($0) }),
                      ("Mark", payload.mark.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNLayoutBreak) {
        dump(indent,
             fields: [("Kind", _format(payload.kind))])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNPageFormat) {
        dump(indent,
             fields: [("Type", payload.type.map { format($0) }),
                      ("Width", payload.width.map { format($0) }),
                      ("Height", payload.height.map { format($0) }),
                      ("Left margin", payload.leftMargin.map { format($0) }),
                      ("Right margin", payload.rightMargin.map { format($0) }),
                      ("Top margin", payload.topMargin.map { format($0) }),
                      ("Bottom margin", payload.bottomMargin.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNRepeat) {
        dump(indent,
             fields: [("Kind", _format(payload.kind)),
                      ("Display meas num", payload.displayMeasNum.map { format($0) }),
                      ("Hidden", payload.hidden.map { format($0) }),
                      ("Meas num", payload.measNum.map { format($0) }),
                      ("Num dx", payload.numDx.map { format($0) }),
                      ("Num dy", payload.numDy.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNSpace) {
        dump(indent,
             fields: [("Distance", format(payload.distance))])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNStaff) {
        dump(indent,
             fields: [("Id", format(payload.id))])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNStaffFormat) {
        dump(indent,
             fields: [("Distance", payload.distance.map { format($0) }),
                      ("Line thickness", payload.lineThickness.map { format($0) }),
                      ("Size", payload.size.map { format($0) }),
                      ("Style", payload.style.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNStaffVisibility) {
        dump(indent,
             fields: [("Kind", _format(payload.kind))])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNTempo) {
        dump(indent,
             fields: [("Tempo", format(payload.tempo)),
                      ("Metronome", payload.metronome.map { $0.stringValue })] + fields(payload.textStyle))
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNUnits) {
        dump(indent,
             fields: [("Type", format(payload.type))])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNVolta) {
        dump(indent,
             fields: [("Span", format(payload.span)),
                      ("Mark", format(payload.mark)),
                      ("Format", payload.format.map { format($0) })])
    }

    // MARK: Private Instance Methods

    private func _format(_ kind: GMNBarLine.Kind) -> String {
        switch kind {
        case .double:
            "Double"

        case .final:
            "Final"

        case .single:
            "Single"
        }
    }

    private func _format(_ kind: GMNJump.Kind) -> String {
        switch kind {
        case .coda:
            "Coda"

        case .daCapo:
            "Da capo"

        case .daCapoAlFine:
            "Da capo al fine"

        case .daCoda:
            "Da coda"

        case .dalSegno:
            "Dal segno"

        case .dalSegnoAlFine:
            "Dal segno al fine"

        case .fine:
            "Fine"

        case .segno:
            "Segno"
        }
    }

    private func _format(_ kind: GMNLayoutBreak.Kind) -> String {
        switch kind {
        case .newPage:
            "New page"

        case .newSystem:
            "New system"
        }
    }

    private func _format(_ kind: GMNRepeat.Kind) -> String {
        switch kind {
        case .begin:
            "Begin"

        case .end:
            "End"
        }
    }

    private func _format(_ kind: GMNStaffVisibility.Kind) -> String {
        switch kind {
        case .off:
            "Off"

        case .on:
            "On"
        }
    }
}
