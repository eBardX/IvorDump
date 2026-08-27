// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorGuido

extension GMNDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ payload: GMNArpeggio) {
        dump(indent,
             fields: [("Direction", payload.direction.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNArticulation) {
        dump(indent,
             fields: [("Kind", _format(payload.kind)),
                      ("Position", payload.position.map { format($0) }),
                      ("Span", format(payload.span)),
                      ("Type", payload.type.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNDynamicRamp) {
        dump(indent,
             fields: [("Direction", _format(payload.direction)),
                      ("Span", format(payload.span)),
                      ("Autopos", payload.autopos.map { format($0) }),
                      ("Delta y", payload.deltaY.map { format($0) }),
                      ("Dx1", payload.dx1.map { format($0) }),
                      ("Dx2", payload.dx2.map { format($0) }),
                      ("Thickness", payload.thickness.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNFingering) {
        dump(indent,
             fields: [("Text", format(payload.text)),
                      ("Position", payload.position.map { format($0) })] + fields(payload.textStyle))
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNGlissando) {
        dump(indent,
             fields: [("Span", format(payload.span)),
                      ("Fill", payload.fill.map { format($0) }),
                      ("Thickness", payload.thickness.map { format($0) })] + fields(payload.controlPoints))
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNIntensity) {
        dump(indent,
             fields: [("Type", format(payload.type)),
                      ("Before", payload.before.map { format($0) }),
                      ("After", payload.after.map { format($0) }),
                      ("Autopos", payload.autopos.map { format($0) })] + fields(payload.textStyle))
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNOrnament) {
        dump(indent,
             fields: [("Kind", _format(payload.kind)),
                      ("Span", format(payload.span)),
                      ("Position", payload.position.map { format($0) }),
                      ("Accidental", payload.accidental.map { format($0) }),
                      ("Adx", payload.adx.map { format($0) }),
                      ("Ady", payload.ady.map { format($0) }),
                      ("Begin", payload.begin.map { format($0) }),
                      ("Detune", payload.detune.map { format($0) }),
                      ("Dur", payload.dur.map { format($0) }),
                      ("Note", payload.note.map { format($0) }),
                      ("Repeats", payload.repeats.map { format($0) }),
                      ("Tr", payload.tr.map { format($0) }),
                      ("Type", payload.type.map { format($0) }),
                      ("Wavy", payload.wavy.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNPedal) {
        dump(indent,
             fields: [("Kind", _format(payload.kind))])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNSlur) {
        dump(indent,
             fields: [("Span", format(payload.span)),
                      ("Curve", payload.curve.map { format($0) }),
                      ("H", payload.h.map { format($0) }),
                      ("R3", payload.r3.map { format($0) })] + fields(payload.controlPoints))
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNTempoChange) {
        dump(indent,
             fields: [("Direction", _format(payload.direction)),
                      ("Span", format(payload.span)),
                      ("Before", payload.before.map { format($0) }),
                      ("After", payload.after.map { format($0) }),
                      ("Dx2", payload.dx2.map { format($0) })] + fields(payload.textStyle))
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNTie) {
        dump(indent,
             fields: [("Span", format(payload.span)),
                      ("Curve", payload.curve.map { format($0) }),
                      ("H", payload.h.map { format($0) }),
                      ("R3", payload.r3.map { format($0) })] + fields(payload.controlPoints))
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNTremolo) {
        dump(indent,
             fields: [("Span", format(payload.span)),
                      ("Pitch", payload.pitch.map { format($0) }),
                      ("Speed", payload.speed.map { format($0) }),
                      ("Style", payload.style.map { format($0) }),
                      ("Text", payload.text.map { format($0) }),
                      ("Thickness", payload.thickness.map { format($0) })])
    }

    // MARK: Private Instance Methods

    private func _format(_ direction: GMNDynamicRamp.Direction) -> String {
        switch direction {
        case .crescendo:
            "Crescendo"

        case .diminuendo:
            "Diminuendo"
        }
    }

    private func _format(_ direction: GMNTempoChange.Direction) -> String {
        switch direction {
        case .accelerando:
            "Accelerando"

        case .ritardando:
            "Ritardando"
        }
    }

    private func _format(_ kind: GMNArticulation.Kind) -> String {
        switch kind {
        case .accent:
            "Accent"

        case .bow:
            "Bow"

        case .fermata:
            "Fermata"

        case .harmonic:
            "Harmonic"

        case .marcato:
            "Marcato"

        case .pizzicato:
            "Pizzicato"

        case .staccato:
            "Staccato"

        case .tenuto:
            "Tenuto"
        }
    }

    private func _format(_ kind: GMNOrnament.Kind) -> String {
        switch kind {
        case .mordent:
            "Mordent"

        case .trill:
            "Trill"

        case .turn:
            "Turn"
        }
    }

    private func _format(_ kind: GMNPedal.Kind) -> String {
        switch kind {
        case .off:
            "Off"

        case .on:
            "On"
        }
    }
}
