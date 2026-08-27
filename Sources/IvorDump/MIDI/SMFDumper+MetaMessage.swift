// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import Foundation
internal import IvorMIDI

extension SMFDumper {

    // MARK: Internal Instance Methods

    internal func format(_ message: SMFMetaMessage) -> String { // swiftlint:disable:this function_body_length
        var result = ""

        switch message {
        case let .copyright(text):
            result += "Copyright"
            result += spacer()
            result += _format(text)

        case let .cuePoint(text):
            result += "Cue point"
            result += spacer()
            result += _format(text)

        case let .deviceName(text):
            result += "Device name"
            result += spacer()
            result += _format(text)

        case .endOfTrack:
            result += "End of track"

        case let .instrumentName(text):
            result += "Instrument name"
            result += spacer()
            result += _format(text)

        case let .keySignature(keySignature):
            result += "Key signature"
            result += spacer()
            result += _format(keySignature)

        case let .lyric(text):
            result += "Lyric"
            result += spacer()
            result += _format(text)

        case let .marker(text):
            result += "Marker"
            result += spacer()
            result += _format(text)

        case let .midiChannelPrefix(channel):
            result += "MIDI channel prefix"
            result += spacer()
            result += format(channel)

        case let .midiPort(port):
            result += "MIDI port"
            result += spacer()
            result += format(port)

        case let .programName(text):
            result += "Program name"
            result += spacer()
            result += _format(text)

        case let .reservedTextA(text):
            result += "Reserved text (0x0a)"
            result += spacer()
            result += _format(text)

        case let .reservedTextB(text):
            result += "Reserved text (0x0b)"
            result += spacer()
            result += _format(text)

        case let .reservedTextC(text):
            result += "Reserved text (0x0c)"
            result += spacer()
            result += _format(text)

        case let .reservedTextD(text):
            result += "Reserved text (0x0d)"
            result += spacer()
            result += _format(text)

        case let .reservedTextE(text):
            result += "Reserved text (0x0e)"
            result += spacer()
            result += _format(text)

        case let .reservedTextF(text):
            result += "Reserved text (0x0f)"
            result += spacer()
            result += _format(text)

        case let .sequenceNumber(seqNum):
            result += "Sequence number"
            result += spacer()
            result += format(seqNum)

        case let .sequencerSpecific(bytes):
            result += "Sequencer-specific"
            result += spacer()
            result += format(bytes)

        case let .sequenceTrackName(text):
            result += "Sequence/track name"
            result += spacer()
            result += _format(text)

        case let .smpteOffset(time):
            result += "SMPTE offset"
            result += spacer()
            result += format(time,
                             includeFrameRate: true)

        case let .tempo(tempo):
            result += "Tempo"
            result += spacer()
            result += _format(tempo)

        case let .text(text):
            result += "Text"
            result += spacer()
            result += _format(text)

        case let .timeSignature(timeSignature):
            result += "Time signature"
            result += spacer()
            result += _format(timeSignature)

        case let .unknown(typeByte, bytes):
            result += String(format: "Unknown (0x%02x)", typeByte)
            result += spacer()
            result += format(bytes)
        }

        return result
    }

    internal func format(_ time: SMPTETime,
                         includeFrameRate: Bool) -> String {
        var result = ""

        if includeFrameRate {
            result += _format(time.frameRate)
            result += spacer()
        }

        result += String(format: "%02d:%02d:%02d %02d.%02d",
                         time.hour,
                         time.minute,
                         time.second,
                         time.frame,
                         time.fraction)

        return result
    }

    internal func format(_ timeCode: SMPTETimeCode) -> String {
        var result = _format(timeCode.frameRate)

        result += spacer()
        result += format(timeCode.tickRate, "tick")
        result += "/frame"

        return result
    }

    // MARK: Private Instance Methods

    private func _format(_ frameRate: SMPTEFrameRate) -> String {
        switch frameRate {
        case .fps24:
            "24 fps"

        case .fps25:
            "25 fps"

        case .fps2997:
            "29.97 fps"

        case .fps30:
            "30 fps"
        }
    }

    private func _format(_ keySignature: SMFKeySignature) -> String {
        switch keySignature {
        case .aFlatMajor:
            "A♭ major"

        case .aFlatMinor:
            "A♭ minor"

        case .aMajor:
            "A major"

        case .aMinor:
            "A minor"

        case .aSharpMinor:
            "A♯"

        case .bFlatMajor:
            "B♭ major"

        case .bFlatMinor:
            "B♭ minor"

        case .bMajor:
            "B major"

        case .bMinor:
            "B minor"

        case .cFlatMajor:
            "C♭ major"

        case .cMajor:
            "C major"

        case .cMinor:
            "C minor"

        case .cSharpMajor:
            "C♯ major"

        case .cSharpMinor:
            "C♯ minor"

        case .dFlatMajor:
            "D♭ major"

        case .dMajor:
            "D major"

        case .dMinor:
            "D minor"

        case .dSharpMinor:
            "D♯ minor"

        case .eFlatMajor:
            "E♭ major"

        case .eFlatMinor:
            "E♭ minor"

        case .eMajor:
            "E major"

        case .eMinor:
            "E minor"

        case .fMajor:
            "F major"

        case .fMinor:
            "F minor"

        case .fSharpMajor:
            "F♯ major"

        case .fSharpMinor:
            "F♯ minor"

        case .gFlatMajor:
            "G♭ major"

        case .gMajor:
            "G major"

        case .gMinor:
            "G minor"

        case .gSharpMinor:
            "G♯ minor"
        }
    }

    private func _format(_ tempo: SMFTempo) -> String {
        var result = format(tempo.uintValue, "µsecond")

        result += "/quarter-note"

        return result
    }

    private func _format(_ text: SMFText) -> String {
        format(text.stringValue)
    }

    private func _format(_ timeSignature: SMFTimeSignature) -> String {
        var result = format(timeSignature.numerator)

        result += "/"
        result += format(1 << timeSignature.denominator)
        result += spacer()
        result += format(timeSignature.clockRate, "clock")
        result += "/click"
        result += spacer()
        result += format(timeSignature.beatRate, "32nd-note")
        result += "/quarter-note"

        return result
    }
}
