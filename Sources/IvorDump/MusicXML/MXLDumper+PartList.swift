// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ partList: MXLPartList) {
        let items = partList.items

        var header = "Part-list"

        header += spacer()
        header += format(items.count, "item")

        emit()
        emit(indent, header)
        emit()

        for item in items {
            switch item {
            case let .partGroup(partGroup):
                _dump(indent + 2, partGroup)

            case let .scorePart(scorePart):
                _dump(indent + 2, scorePart)
            }
        }
    }

    internal func format(_ elementPosition: MXLElementPosition) -> String {
        var result = ""

        if let element = elementPosition.element {
            result += spacer()
            result += "Element "
            result += format(element)
        }

        if let position = elementPosition.position {
            result += spacer()
            result += "Position "
            result += format(position)
        }

        return result
    }

    internal func format(_ instrument: MXLMidiInstrument) -> String {
        var result = "MIDI instrument "

        result += format(instrument.id)

        if let name = instrument.midiName {
            result += spacer()
            result += format(name)
        }

        if let bank = instrument.midiBank {
            result += spacer()
            result += "Bank "
            result += format(bank.uintValue)
        }

        if let channel = instrument.midiChannel {
            result += spacer()
            result += "Channel "
            result += format(channel.uintValue)
        }

        if let program = instrument.midiProgram {
            result += spacer()
            result += "Program "
            result += format(program.uintValue)
        }

        if let unpitched = instrument.midiUnpitched {
            result += spacer()
            result += "Unpitched "
            result += format(unpitched.uintValue)
        }

        if let volume = instrument.volume {
            result += spacer()
            result += "Volume "
            result += format(volume)
        }

        if let pan = instrument.pan {
            result += spacer()
            result += "Pan "
            result += format(pan)
        }

        return result
    }

    internal func format(_ nameDisplay: MXLNameDisplay) -> String {
        var parts: [String] = []

        for item in nameDisplay.items {
            switch item {
            case let .accidentalText(text):
                parts.append(format(text))

            case let .displayText(text):
                parts.append(format(text))
            }
        }

        if let printsObject = nameDisplay.printsObject {
            parts.append(printsObject ? "Printed" : "Not printed")
        }

        return parts.joined(separator: spacer())
    }

    // MARK: Private Instance Methods

    private func _dump(_ indent: Int,
                       _ group: MXLScorePart.Group2) {
        if let midiDevice = group.midiDevice {
            var line = "MIDI device"

            line += spacer()
            line += format(midiDevice.value)

            if let port = midiDevice.port {
                line += spacer()
                line += "Port "
                line += format(port.uintValue)
            }

            if let id = midiDevice.id {
                line += spacer()
                line += "ID "
                line += format(id)
            }

            emit(indent, line)
        }

        if let midiInstrument = group.midiInstrument {
            emit(indent, format(midiInstrument))
        }
    }

    private func _dump(_ indent: Int,
                       _ instrument: MXLScoreInstrument) {
        var line = "Score-instrument "

        line += format(instrument.id)
        line += spacer()
        line += format(instrument.name)

        if let abbreviation = instrument.abbreviation {
            line += spacer()
            line += format(abbreviation)
        }

        emit(indent, line)

        let data = instrument.virtualInstrumentData

        if let sound = data.instrumentSound {
            emit(indent + 2,
                 "Instrument sound" + spacer() + format(sound))
        }

        if let content = data.content {
            switch content {
            case let .ensemble(size):
                var line = "Ensemble"

                if let size {
                    line += spacer()
                    line += format(size)
                }

                emit(indent + 2, line)

            case .solo:
                emit(indent + 2, "Solo")
            }
        }

        if let virtual = data.virtualInstrument {
            var line = "Virtual instrument"

            if let library = virtual.virtualLibrary {
                line += spacer()
                line += format(library)
            }

            if let name = virtual.virtualName {
                line += spacer()
                line += format(name)
            }

            emit(indent + 2, line)
        }
    }

    private func _dump(_ indent: Int,
                       _ link: MXLPartLink) {
        emit(indent,
             "Part-link" + spacer() + format(link.xlink))

        for group in link.groupLink {
            emit(indent + 2,
                 "Group link" + spacer() + format(group))
        }

        for instrument in link.instrumentLink {
            emit(indent + 2,
                 "Instrument link" + spacer() + format(instrument.id))
        }
    }

    private func _dump(_ indent: Int,
                       _ partGroup: MXLPartGroup) {
        emit(indent, _format(partGroup))

        if let nameDisplay = partGroup.nameDisplay {
            emit(indent + 2,
                 "Name display" + spacer() + format(nameDisplay))
        }

        if let nameDisplay = partGroup.abbreviationDisplay {
            emit(indent + 2,
                 "Abbreviation display" + spacer() + format(nameDisplay))
        }
    }

    private func _dump(_ indent: Int,
                       _ scorePart: MXLScorePart) {
        emit(indent, _format(scorePart))

        if let nameDisplay = scorePart.nameDisplay {
            emit(indent + 2,
                 "Name display" + spacer() + format(nameDisplay))
        }

        if let nameDisplay = scorePart.abbreviationDisplay {
            emit(indent + 2,
                 "Abbreviation display" + spacer() + format(nameDisplay))
        }

        for group in scorePart.group {
            emit(indent + 2,
                 "Group" + spacer() + format(group))
        }

        if let identification = scorePart.identification {
            dump(indent + 2, identification)
        }

        for instrument in scorePart.instrument {
            _dump(indent + 2, instrument)
        }

        for player in scorePart.player {
            emit(indent + 2,
                 "Player " + format(player.id) + spacer() + format(player.name))
        }

        for entry in scorePart.group2 {
            _dump(indent + 2, entry)
        }

        for link in scorePart.link {
            _dump(indent + 2, link)
        }
    }

    private func _format(_ partGroup: MXLPartGroup) -> String {
        var result = "Part-group "

        result += format(partGroup.kind)
        result += spacer()
        result += format(partGroup.number)

        if let name = partGroup.name {
            result += spacer()
            result += format(name.value)
        }

        if let abbreviation = partGroup.abbreviation {
            result += spacer()
            result += format(abbreviation.value)
        }

        if let symbol = partGroup.symbol {
            result += spacer()
            result += format(symbol.value)

            append(&result, format(symbol.position))
            append(&result, symbol.color.map { format($0) })
        }

        if let barline = partGroup.barline {
            result += spacer()
            result += "Barline "
            result += _format(barline.value)

            append(&result, barline.color.map { format($0) })
        }

        if partGroup.stretchesTimeSignature {
            result += spacer()
            result += "Stretches time signature"
        }

        if let footnote = partGroup.footnote {
            result += spacer()
            result += "Footnote "
            result += format(footnote)
        }

        if let level = partGroup.level {
            result += spacer()
            result += format(level)
        }

        return result
    }

    private func _format(_ scorePart: MXLScorePart) -> String {
        var result = "Score-part "

        result += format(scorePart.id)
        result += spacer()
        result += format(scorePart.name.value)

        append(&result, scorePart.name.text.printsObject, "Printed", "Not printed")

        if let abbreviation = scorePart.abbreviation {
            result += spacer()
            result += format(abbreviation.value)

            append(&result,
                   abbreviation.text.printsObject,
                   "Abbreviation printed",
                   "Abbreviation not printed")
        }

        return result
    }

    private func _format(_ value: MXLGroupBarline.Value) -> String {
        switch value {
        case .mensurstrich:
            "Mensurstrich"

        case .no:
            "No"

        case .yes:
            "Yes"
        }
    }
}
