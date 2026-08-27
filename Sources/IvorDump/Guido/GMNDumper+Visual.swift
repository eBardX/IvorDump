// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorGuido

extension GMNDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ payload: GMNBeam) {
        dump(indent,
             fields: [("Kind", _format(payload.kind)),
                      ("Span", format(payload.span)),
                      ("Draw duration", payload.drawDuration.map { format($0) }),
                      ("Durations", payload.durations.map { format($0) }),
                      ("Dx1", payload.controlPoints.dx1.map { format($0) }),
                      ("Dy1", payload.controlPoints.dy1.map { format($0) }),
                      ("Dx2", payload.controlPoints.dx2.map { format($0) }),
                      ("Dy2", payload.controlPoints.dy2.map { format($0) }),
                      ("Dx3", payload.controlPoints.dx3.map { format($0) }),
                      ("Dy3", payload.controlPoints.dy3.map { format($0) }),
                      ("Dx4", payload.controlPoints.dx4.map { format($0) }),
                      ("Dy4", payload.controlPoints.dy4.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNBeamState) {
        dump(indent,
             fields: [("Kind", _format(payload.kind))])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNColor) {
        dump(indent,
             fields: [("Color", format(payload.color))])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNGraphicSymbol) {
        dump(indent,
             fields: [("File", format(payload.file)),
                      ("Height", payload.height.map { format($0) }),
                      ("Width", payload.width.map { format($0) }),
                      ("Position", payload.position.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNLyrics) {
        dump(indent,
             fields: [("Text", format(payload.text)),
                      ("Autopos", payload.autopos.map { format($0) })] + fields(payload.textStyle))
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNMark) {
        dump(indent,
             fields: [("Text", format(payload.text)),
                      ("Enclosure", payload.enclosure.map { _format($0) })] + fields(payload.textStyle))
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNNoteFormat) {
        dump(indent,
             fields: [("Style", payload.style.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNNoteHeads) {
        dump(indent,
             fields: [("Kind", _format(payload.kind))])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNSpecial) {
        dump(indent,
             fields: [("Character", format(payload.character))])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNStemDirection) {
        dump(indent,
             fields: [("Kind", _format(payload.kind)),
                      ("Length", payload.length.map { format($0) })])
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNText) {
        dump(indent,
             fields: [("Kind", _format(payload.kind)),
                      ("Text", format(payload.text))] + fields(payload.textStyle))
    }

    internal func dump(_ indent: Int,
                       _ payload: GMNTitleBlock) {
        dump(indent,
             fields: [("Kind", _format(payload.kind)),
                      ("Text", format(payload.text)),
                      ("Page format", payload.pageFormat.map { format($0) })] + fields(payload.textStyle))
    }

    // MARK: Private Instance Methods

    private func _format(_ enclosure: GMNMark.Enclosure) -> String {
        switch enclosure {
        case .bracket:
            "Bracket"

        case .circle:
            "Circle"

        case .diamond:
            "Diamond"

        case .none:
            "None"

        case .oval:
            "Oval"

        case .rectangle:
            "Rectangle"

        case .square:
            "Square"

        case .triangle:
            "Triangle"
        }
    }

    private func _format(_ kind: GMNBeam.Kind) -> String {
        switch kind {
        case .feathered:
            "Feathered"

        case .normal:
            "Normal"
        }
    }

    private func _format(_ kind: GMNBeamState.Kind) -> String {
        switch kind {
        case .auto:
            "Auto"

        case .full:
            "Full"

        case .off:
            "Off"
        }
    }

    private func _format(_ kind: GMNNoteHeads.Kind) -> String {
        switch kind {
        case .center:
            "Center"

        case .left:
            "Left"

        case .normal:
            "Normal"

        case .reverse:
            "Reverse"

        case .right:
            "Right"
        }
    }

    private func _format(_ kind: GMNStemDirection.Kind) -> String {
        switch kind {
        case .auto:
            "Auto"

        case .down:
            "Down"

        case .off:
            "Off"

        case .up:
            "Up"
        }
    }

    private func _format(_ kind: GMNText.Kind) -> String {
        switch kind {
        case .label:
            "Label"

        case .text:
            "Text"
        }
    }

    private func _format(_ kind: GMNTitleBlock.Kind) -> String {
        switch kind {
        case .composer:
            "Composer"

        case .footer:
            "Footer"

        case .title:
            "Title"
        }
    }
}
