// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ item: MXLArticulations.Item) {
        switch item {
        case let .accent(position, font, color, placement):
            emit(indent,
                 format("Accent", position, font, color, placement))

        case let .breathMark(mark):
            var line = "Breath mark"

            line += spacer()
            line += _format(mark.value)

            appendPlacement(&line,
                            placement: mark.placement,
                            position: mark.position,
                            font: mark.font,
                            color: mark.color)

            emit(indent, line)

        case let .caesura(caesura):
            var line = "Caesura"

            line += spacer()
            line += _format(caesura.value)

            appendPlacement(&line,
                            placement: caesura.placement,
                            position: caesura.position,
                            font: caesura.font,
                            color: caesura.color)

            emit(indent, line)

        case let .detachedLegato(position, font, color, placement):
            emit(indent,
                 format("Detached legato", position, font, color, placement))

        case let .doit(line):
            var out = "Doit"

            append(&out, format(line))

            emit(indent, out)

        case let .falloff(line):
            var out = "Falloff"

            append(&out, format(line))

            emit(indent, out)

        case let .otherArticulation(other):
            var line = "Other articulation"

            line += spacer()
            line += format(other.value)

            appendPlacement(&line,
                            placement: other.placement,
                            position: other.printStyle.position,
                            font: other.printStyle.font,
                            color: other.printStyle.color,
                            smufl: other.smufl)

            emit(indent, line)

        case let .plop(line):
            var out = "Plop"

            append(&out, format(line))

            emit(indent, out)

        case let .scoop(line):
            var out = "Scoop"

            append(&out, format(line))

            emit(indent, out)

        case let .softAccent(position, font, color, placement):
            emit(indent,
                 format("Soft accent", position, font, color, placement))

        case let .spiccato(position, font, color, placement):
            emit(indent,
                 format("Spiccato", position, font, color, placement))

        case let .staccatissimo(position, font, color, placement):
            emit(indent,
                 format("Staccatissimo", position, font, color, placement))

        case let .staccato(position, font, color, placement):
            emit(indent,
                 format("Staccato", position, font, color, placement))

        case let .stress(position, font, color, placement):
            emit(indent,
                 format("Stress", position, font, color, placement))

        case let .strongAccent(accent):
            var line = "Strong accent"

            line += spacer()
            line += format(accent.kind)

            appendPlacement(&line,
                            placement: accent.placement,
                            position: accent.position,
                            font: accent.font,
                            color: accent.color)

            emit(indent, line)

        case let .tenuto(position, font, color, placement):
            emit(indent,
                 format("Tenuto", position, font, color, placement))

        case let .unstress(position, font, color, placement):
            emit(indent,
                 format("Unstress", position, font, color, placement))
        }
    }

    // MARK: Private Instance Methods

    private func _format(_ value: MXLBreathMark.Value) -> String {
        switch value {
        case .comma:
            "comma"

        case .empty:
            "empty"

        case .salzedo:
            "salzedo"

        case .tick:
            "tick"

        case .upbow:
            "upbow"
        }
    }

    private func _format(_ value: MXLCaesura.Value) -> String {
        switch value {
        case .curved:
            "curved"

        case .empty:
            "empty"

        case .normal:
            "normal"

        case .short:
            "short"

        case .single:
            "single"

        case .thick:
            "thick"
        }
    }
}
