// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ direction: MXLDirection) {
        emit(indent, _format(direction))

        for kind in direction.kind {
            _dump(indent + 2, kind.content)
        }

        if let sound = direction.sound {
            dump(indent + 2, sound)
        }

        if let listening = direction.listening {
            for item in listening.items {
                emit(indent + 2, format(item))
            }
        }
    }

    internal func format(_ label: String,
                         _ kind: MXLStartStopContinue,
                         _ number: MXLNumberLevel?) -> String {
        var result = label + " "

        result += format(kind)

        if let number {
            result += spacer()
            result += format(number.uintValue)
        }

        return result
    }

    internal func format(_ placement: MXLAboveBelow) -> String {
        switch placement {
        case .above:
            "Above"

        case .below:
            "Below"
        }
    }

    // MARK: Private Instance Methods

    private func _dump(_ indent: Int,
                       _ content: MXLDirection.Kind.Content) {
        switch content {
        case let .accordionRegistration(registration):
            emit(indent, format(registration))

        case let .bracket(bracket):
            emit(indent, format(bracket))

        case let .coda(codas):
            for coda in codas {
                emit(indent, format(coda))
            }

        case .damp:
            emit(indent, "Damp")

        case .dampAll:
            emit(indent, "Damp all")

        case let .dashes(dashes):
            var line = format("Dashes", dashes.kind, dashes.number)

            append(&line, format(dashLength: dashes.dashLength, spaceLength: dashes.spaceLength))
            append(&line, format(dashes.position))
            append(&line, dashes.color.map { format($0) })

            emit(indent, line)

        case let .dynamics(dynamics):
            for entry in dynamics {
                emit(indent, format(entry))
            }

        case .eyeglasses:
            emit(indent, "Eyeglasses")

        case let .harpPedals(harpPedals):
            emit(indent, format(harpPedals))

        case let .image(image):
            emit(indent, format(image))

        case let .metronome(metronome):
            emit(indent, format(metronome))

        case let .octaveShift(shift):
            emit(indent, format(shift))

        case let .otherDirection(other):
            var line = "Other direction"

            line += spacer()
            line += format(other.value)

            append(&line, other.printsObject, "Printed", "Not printed")
            appendStyle(&line,
                        position: other.position,
                        font: other.font,
                        color: other.color,
                        halign: other.halign,
                        valign: other.valign)
            append(&line, other.smufl.map { format($0.stringValue) })

            emit(indent, line)

        case let .pedal(pedal):
            emit(indent, format(pedal))

        case let .percussion(percussions):
            for percussion in percussions {
                var line = "Percussion"

                line += spacer()
                line += format(percussion.content)

                appendStyle(&line,
                            position: percussion.position,
                            font: percussion.font,
                            color: percussion.color,
                            halign: percussion.halign,
                            valign: percussion.valign,
                            enclosure: percussion.enclosure)

                emit(indent, line)
            }

        case let .principalVoice(voice):
            emit(indent, format(voice))

        case let .rehearsal(rehearsals):
            for rehearsal in rehearsals {
                emit(indent,
                     "Rehearsal" + spacer() + format(rehearsal))
            }

        case let .scordatura(scordatura):
            emit(indent, "Scordatura")

            for accord in scordatura.accord {
                var line = "Accord"

                if let string = accord.string {
                    line += spacer()
                    line += "String "
                    line += format(string.uintValue)
                }

                line += spacer()
                line += format(accord.tuning)

                emit(indent + 2, line)
            }

        case let .segno(segnos):
            for segno in segnos {
                emit(indent, format(segno))
            }

        case let .staffDivide(divide):
            emit(indent, format(divide))

        case let .stringMute(mute):
            emit(indent, format(mute))

        case let .symbol(symbol):
            emit(indent,
                 "Symbol" + spacer() + format(symbol))

        case let .wedge(wedge):
            emit(indent, format(wedge))

        case let .words(words):
            emit(indent,
                 "Words" + spacer() + format(words))
        }
    }

    private func _format(_ direction: MXLDirection) -> String {
        var result = "Direction"

        if let placement = direction.placement {
            result += spacer()
            result += format(placement)
        }

        if let staff = direction.staff {
            result += spacer()
            result += "Staff "
            result += format(staff.uintValue)
        }

        if let voice = direction.voice {
            result += spacer()
            result += "Voice "
            result += format(voice.voice)
        }

        if let offset = direction.offset {
            result += spacer()
            result += "Offset "
            result += format(offset.value)

            if !offset.affectsPlayback {
                result += " (display only)"
            }
        }

        if let system = direction.system {
            result += spacer()
            result += format(system)
        }

        append(&result, direction.isDirective, "Directive", "Not directive")

        if let footnote = direction.footnote {
            result += spacer()
            result += "Footnote "
            result += format(footnote)
        }

        if let level = direction.level {
            result += spacer()
            result += format(level)
        }

        return result
    }
}
