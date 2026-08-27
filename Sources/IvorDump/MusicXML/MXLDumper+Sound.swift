// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ sound: MXLSound) {
        emit(indent, _format(sound))

        for group in sound.group {
            if let midiDevice = group.midiDevice {
                emit(indent + 2,
                     "MIDI device" + spacer() + format(midiDevice.value))
            }

            if let midiInstrument = group.midiInstrument {
                emit(indent + 2, format(midiInstrument))
            }

            if let instrumentChange = group.instrumentChange {
                emit(indent + 2,
                     "Instrument change" + spacer() + format(instrumentChange.id))
            }

            if let play = group.play {
                emit(indent + 2, format(play))
            }
        }
    }

    // MARK: Private Instance Methods

    private func _format(_ kind: MXLSwing.Kind) -> String {
        switch kind {
        case .eighth:
            "eighth"

        case .n16th:
            "16th"
        }
    }

    private func _format(_ sound: MXLSound) -> String {
        var result = "Sound"

        result += _format(playbackOf: sound)
        result += _format(navigationOf: sound)

        if let offset = sound.offset {
            result += spacer()
            result += "Offset "
            result += format(offset.value)
        }

        if let timeOnly = sound.timeOnly,
           !timeOnly.isEmpty {
            result += spacer()
            result += "Times "
            result += timeOnly.map { format($0) }.joined(separator: ",")
        }

        if let swing = sound.swing {
            result += spacer()
            result += _format(swing)
        }

        return result
    }

    private func _format(_ swing: MXLSwing) -> String {
        var result = "Swing "

        switch swing.content {
        case let .first(first, second, kind):
            result += format(first)
            result += ":"
            result += format(second)

            if let kind {
                result += " "
                result += _format(kind)
            }

        case .straight:
            result += "straight"
        }

        if let style = swing.style {
            result += spacer()
            result += format(style)
        }

        return result
    }

    private func _format(navigationOf sound: MXLSound) -> String {
        var result = ""

        append(&result, sound.isDaCapo, "Da capo", "No da capo")

        if let segno = sound.segno {
            result += spacer()
            result += "Segno "
            result += format(segno)
        }

        if let dalsegno = sound.dalsegno {
            result += spacer()
            result += "Dal segno "
            result += format(dalsegno)
        }

        if let coda = sound.coda {
            result += spacer()
            result += "Coda "
            result += format(coda)
        }

        if let tocoda = sound.tocoda {
            result += spacer()
            result += "To coda "
            result += format(tocoda)
        }

        if let fine = sound.fine {
            result += spacer()
            result += "Fine "
            result += format(fine)
        }

        append(&result,
               sound.impliesForwardRepeat,
               "Forward repeat",
               "No forward repeat")

        result += _format(pedalsOf: sound)

        return result
    }

    private func _format(pedalsOf sound: MXLSound) -> String {
        var result = ""

        if let damperPedal = sound.damperPedal {
            result += spacer()
            result += "Damper "
            result += format(damperPedal)
        }

        if let softPedal = sound.softPedal {
            result += spacer()
            result += "Soft "
            result += format(softPedal)
        }

        if let sostenutoPedal = sound.sostenutoPedal {
            result += spacer()
            result += "Sostenuto "
            result += format(sostenutoPedal)
        }

        return result
    }

    private func _format(playbackOf sound: MXLSound) -> String {
        var result = ""

        if let tempo = sound.tempo {
            result += spacer()
            result += format(tempo)
            result += " bpm"
        }

        if let dynamics = sound.dynamics {
            result += spacer()
            result += "Dynamics "
            result += format(dynamics)
            result += "%"
        }

        if let divisions = sound.divisions {
            result += spacer()
            result += "Divisions "
            result += format(divisions.intValue)
        }

        if let pan = sound.pan {
            result += spacer()
            result += "Pan "
            result += format(pan)
        }

        if let elevation = sound.elevation {
            result += spacer()
            result += "Elevation "
            result += format(elevation)
        }

        append(&result, sound.isPizzicato, "Pizzicato", "Arco")

        return result
    }
}
