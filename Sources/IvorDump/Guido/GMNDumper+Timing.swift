// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorGuido

extension GMNDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ payload: GMNAccidental) {
        dump(indent,
             fields: [("Style", payload.style.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNAlter) {
        dump(indent,
             fields: [("Detune", format(payload.detune)),
                      ("Text", payload.text.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNCluster) {
        dump(indent,
             fields: [("Hdx", payload.hdx.map { format($0) }),
                      ("Hdy", payload.hdy.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNDisplayDuration) {
        dump(indent,
             fields: [("Numerator", format(payload.numerator)),
                      ("Denominator", format(payload.denominator)),
                      ("Dot count", payload.dotCount.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNGrace) {
        dump(indent,
             fields: [("Index", payload.index.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNKey) {
        dump(indent,
             fields: [("Key", format(payload.key)),
                      ("Free", payload.free.map { format($0) }),
                      ("Hide naturals", payload.hideNaturals.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNMeter) {
        dump(indent,
             fields: [("Type", format(payload.type)),
                      ("Auto barlines", payload.autoBarlines.map { format($0) }),
                      ("Auto measures num", payload.autoMeasuresNum.map { format($0) }),
                      ("Group", payload.group.map { format($0) }),
                      ("Hidden", payload.hidden.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNMultiMeasureRest) {
        dump(indent,
             fields: [("Count", format(payload.count))])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNOctava) {
        dump(indent,
             fields: [("Offset", format(payload.offset)),
                      ("Hidden", payload.hidden.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNTuplet) {
        dump(indent,
             fields: [("Span", format(payload.span)),
                      ("Position", payload.position.map { format($0) }),
                      ("Bold", payload.bold.map { format($0) }),
                      ("Disp note", payload.dispNote.map { format($0) }),
                      ("Dy1", payload.dy1.map { format($0) }),
                      ("Dy2", payload.dy2.map { format($0) }),
                      ("Format", payload.format.map { format($0) }),
                      ("Line thickness", payload.lineThickness.map { format($0) }),
                      ("Text size", payload.textSize.map { format($0) })])
    }
}
