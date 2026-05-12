// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import Foundation

private import IvorABC
private import XestiText

// swiftlint:disable file_length

extension IvorDumper {

    // MARK: Internal Instance Methods

    internal func dumpABC(_ fileURL: URL) throws {
        var banner = "Dump of ABC File "

        banner += format(fileURL.path)

        emit()
        emit(banner)

        let tunebook = try ABCParser().parse(readFile(fileURL))

        _dump(2, tunebook)

        emit()
    }

    // MARK: Private Type Properties

    private static let modes: [ABCKeySignature.Mode: String] = [.aeolian: "aeolian",
                                                                .dorian: "dorian",
                                                                .explicit: "explicit",
                                                                .ionian: "ionian",
                                                                .locrian: "locrian",
                                                                .lydian: "lydian",
                                                                .major: "major",
                                                                .minor: "minor",
                                                                .mixolydian: "mixolydian",
                                                                .phrygian: "phrygian"]

    private static let pitchAccidentals: [ABCPitch.Accidental: String] = [.doubleFlat: "𝄫",
                                                                          .doubleSharp: "𝄪",
                                                                          .flat: "♭",
                                                                          .natural: "♮",
                                                                          .sharp: "♯"]

    private static let pitchLetters: [ABCPitch.Letter: String] = [.a: "A",
                                                                  .b: "B",
                                                                  .c: "C",
                                                                  .d: "D",
                                                                  .e: "E",
                                                                  .f: "F",
                                                                  .g: "G"]

    private static let tonics: [ABCKeySignature.Tonic: String] = [.a: "A",
                                                                  .aFlat: "A♭",
                                                                  .aSharp: "A♯",
                                                                  .b: "B",
                                                                  .bFlat: "B♭",
                                                                  .bSharp: "B♯",
                                                                  .c: "C",
                                                                  .cFlat: "C♭",
                                                                  .cSharp: "C♯",
                                                                  .d: "D",
                                                                  .dFlat: "D♭",
                                                                  .dSharp: "D♯",
                                                                  .e: "E",
                                                                  .eFlat: "E♭",
                                                                  .eSharp: "E♯",
                                                                  .f: "F",
                                                                  .fFlat: "F♭",
                                                                  .fSharp: "F♯",
                                                                  .g: "G",
                                                                  .gFlat: "G♭",
                                                                  .gSharp: "G♯"]

    // MARK: Private Instance Methods

    private func _dump(_ indent: Int,
                       _ chord: [ABCNote]) {
        var line = "Chord"

        line += spacer()
        line += format(chord.count, "note")

        emit(indent, line)

        for note in chord {
            emit(indent + 2, _format(note))
        }
    }

    private func _dump(_ indent: Int,
                       _ entry: ABCEntry) {
        switch entry {
        case let .directive(directive):
            emit(indent, _format(directive))

        case let .field(field):
            if case let .voice(voice) = field,
               !voice.properties.isEmpty {
                _dump(indent, voice)
                return
            } else {
                emit(indent, _format(field))
            }

        case let .symbols(symbols):
            var line = "Body"

            line += spacer()
            line += format(symbols.count, "symbol")

            emit(indent, line)

            for symbol in symbols {
                _dump(indent + 2, symbol)
            }
        }
    }

    private func _dump(_ indent: Int,
                       _ header: ABCHeader) {
        var line = ""

        switch header {
        case let .directive(directive):
            line += _format(directive)

        case let .field(field):
            if case let .voice(voice) = field,
               !voice.properties.isEmpty {
                _dump(indent, voice)
                return
            } else {
                line += _format(field)
            }
        }

        emit(indent, line)
    }

    private func _dump(_ indent: Int,
                       _ key: String,
                       _ value: String) {
        var line = ""

        line += "Property"
        line += spacer()
        line += key
        line += spacer()
        line += _format(value)

        emit(indent, line)
    }

    private func _dump(_ indent: Int,
                       _ symbol: ABCSymbol) {
        var line = ""

        switch symbol {
        case let .annotation(text):
            line += "Annotation"
            line += spacer()
            line += text

        case let .barRepeat(text):
            line += "Bar line/repeat"
            line += spacer()
            line += text

        case let .brokenRhythm(text):
            line += "Broken rhythm"
            line += spacer()
            line += text

        case let .chord(chord):
            _dump(indent, chord)
            return

        case let .chordSymbol(text):
            line += "Chord symbol"
            line += spacer()
            line += text

        case let .decoration(text):
            line += "Decoration"
            line += spacer()
            line += text

        case let .graceNotes(hasSlash, graceNotes):
            line += "Grace notes"
            line += spacer()
            line += _format(hasSlash, graceNotes)

        case let .inlineField(field):
            line += "Inline"
            line += spacer()
            line += _format(field)

        case let .note(note):
            line += "Note"
            line += spacer()
            line += _format(note)

        case let .rest(rest):
            line += "Rest"
            line += spacer()
            line += _format(rest)

        case let .slur(text):
            line += "Slur"
            line += spacer()
            line += text

        case let .tuplet(pcount, qcount, rcount):
            line += "Tuplet"
            line += spacer()
            line += format(pcount)
            line += spacer()
            line += format(qcount)
            line += spacer()
            line += format(rcount)

        case let .variantEnding(text):
            line += "Variant ending"
            line += spacer()
            line += text
        }

        emit(indent, line)
    }

    private func _dump(_ indent: Int,
                       _ tune: ABCTune) {
        let entries = tune.entries

        var header = "Tune"

        if !entries.isEmpty {
            header += spacer()
            header += format(entries.count,
                             "entry",
                             plural: "entries")
        }

        emit()
        emit(indent, header)

        if !entries.isEmpty {
            emit()

            for entry in entries {
                _dump(indent + 2, entry)
            }
        }
    }

    private func _dump(_ indent: Int,
                       _ tunebook: ABCTunebook) {
        let headers = tunebook.headers
        let tunes = tunebook.tunes

        var header = "Tunebook"

        header += spacer()
        header += _format(tunebook.version)

        if !headers.isEmpty {
            header += spacer()
            header += format(headers.count, "header")
        }

        if !tunes.isEmpty {
            header += spacer()
            header += format(tunes.count, "tune")
        }

        emit()
        emit(indent, header)

        if !headers.isEmpty {
            emit()

            for header in headers {
                _dump(indent + 2, header)
            }
        }

        for tune in tunes {
            _dump(indent + 2, tune)
        }
    }

    private func _dump(_ indent: Int,
                       _ voice: ABCVoice) {
        var line = "Voice"

        line += spacer()
        line += format(voice.properties.count,
                       "property",
                       plural: "properties")

        emit(indent, line)

        for key in voice.properties.keys.sorted() {
            _dump(indent + 2,
                  key,
                  voice.properties[key] ?? "")
        }
    }

    private func _format(_ directive: ABCDirective) -> String {
        var result = directive.name

        result += spacer()
        result += format(directive.value)

        return result
    }

    private func _format(_ field: ABCField) -> String { // swiftlint:disable:this function_body_length
        var result = ""

        switch field {
        case let .alignedLyrics(value):
            result += "Aligned lyrics"
            result += spacer()
            result += format(value)

        case let .area(value):
            result += "Area"
            result += spacer()
            result += format(value)

        case let .book(value):
            result += "Book"
            result += spacer()
            result += format(value)

        case let .composer(value):
            result += "Composer"
            result += spacer()
            result += format(value)

        case let .continuation(value):
            result += "Continuation"
            result += spacer()
            result += format(value)

        case let .discography(value):
            result += "Discography"
            result += spacer()
            result += format(value)

        case let .fileURL(value):
            result += "File URL"
            result += spacer()
            result += format(value)

        case let .group(value):
            result += "Group"
            result += spacer()
            result += format(value)

        case let .history(value):
            result += "History"
            result += spacer()
            result += format(value)

        case let .instruction(value):
            result += "Instruction"
            result += spacer()
            result += format(value)

        case let .key(value):
            result += "Key"
            result += spacer()
            result += _format(value)

        case let .lyrics(value):
            result += "Lyrics"
            result += spacer()
            result += format(value)

        case let .macro(value):
            result += "Macro"
            result += spacer()
            result += format(value)

        case let .meter(value):
            result += "Meter"
            result += spacer()
            result += _format(value)

        case let .notes(value):
            result += "Notes"
            result += spacer()
            result += format(value)

        case let .origin(value):
            result += "Origin"
            result += spacer()
            result += format(value)

        case let .parts(value):
            result += "Parts"
            result += spacer()
            result += format(value)

        case let .refNumber(value):
            result += "Reference number"
            result += spacer()
            result += _format(value)

        case let .remark(value):
            result += "Remark"
            result += spacer()
            result += format(value)

        case let .rhythm(value):
            result += "Rhythm"
            result += spacer()
            result += format(value)

        case let .source(value):
            result += "Source"
            result += spacer()
            result += format(value)

        case let .symbolLine(value):
            result += "Symbols"
            result += spacer()
            result += format(value)

        case let .tempo(value):
            result += "Tempo"
            result += spacer()
            result += _format(value)

        case let .title(value):
            result += "Title"
            result += spacer()
            result += format(value)

        case let .transcription(value):
            result += "Transcription"
            result += spacer()
            result += format(value)

        case let .unitNoteLength(value):
            result += "Unit note length"
            result += spacer()
            result += _format(value)

        case let .userDefined(value):
            result += "User-defined"
            result += spacer()
            result += format(value)

        case let .voice(value):
            result += "Voice"
            result += spacer()
            result += value.id
        }

        return result
    }

    private func _format(_ duration: ABCDuration) -> String {
        format(duration.numerator) + "/" + format(duration.denominator)
    }

    private func _format(_ keySignature: ABCKeySignature) -> String {
        var result = ""

        switch keySignature {
        case .empty:
            result += "Empty"

        case .highlandPipes:
            result += "Highland pipes"

        case let .standard(tonic, mode, accidentals):
            result += Self.tonics[tonic] ?? "\(tonic)"
            result += " "
            result += Self.modes[mode] ?? "\(mode)"

            for accidental in accidentals {
                result += spacer()
                result += _format(accidental)
            }
        }

        return result
    }

    private func _format(_ note: ABCNote) -> String {
        var result = _format(note.pitch)

        result += spacer()
        result += _format(note.duration)

        if note.isTied {
            result += spacer()
            result += "Tied"
        }

        return result
    }

    private func _format(_ hasSlash: Bool,
                         _ graceNotes: [ABCNote]) -> String {
        var result = ""

        if hasSlash {
            result += "/"
            result += spacer()
        }

        for graceNote in graceNotes {
            if !result.isEmpty {
                result += spacer()
            }

            result += _format(graceNote.pitch)  // ignore duration and isTied for time being
        }

        return result
    }

    private func _format(_ pitch: ABCPitch) -> String {
        guard let letter = Self.pitchLetters[pitch.letter],
              let accidental = Self.pitchAccidentals[pitch.accidental]
        else { return "\(pitch)" }

        return letter + accidental + pitch.octave.description
    }

    private func _format(_ refNumber: ABCRefNumber) -> String {
        format(refNumber.uintValue)
    }

    private func _format(_ rest: ABCRest) -> String {
        var result = ""

        switch rest {
        case let .multiMeasure(_, count):
            result += format(count, "measure")

        case let .regular(_, duration):
            result += _format(duration)
        }

        if rest.isInvisible {
            result += spacer()
            result += "Invisible"
        }

        return result
    }

    private func _format(_ tempo: ABCTempo) -> String {
        var result = ""

        if let duration = tempo.duration,
           let rate = tempo.rate {
            result += _format(duration)
            result += spacer()
            result += format(rate)
            result += " bpm"
        }

        if let text = tempo.text {
            if !result.isEmpty {
                result += spacer()
            }

            result += format(text)
        }

        return result
    }

    private func _format(_ timeSignature: ABCTimeSignature) -> String {
        switch timeSignature {
        case .common:
            "Common time"

        case .cut:
            "Cut time"

        case .empty:
            "Empty"

        case let .explicit(fraction):
            _format(fraction)
        }
    }

    private func _format(_ version: ABCVersion) -> String {
        var result = format(version.major)

        result += "."
        result += format(version.minor)

        return result
    }

    private func _format(_ vpValue: String) -> String {
        if vpValue.isEmpty || vpValue.contains(where: { $0.isWhitespace }) {
            format(vpValue)
        } else {
            vpValue
        }
    }
}

// swiftlint:enable file_length
