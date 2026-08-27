// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import Foundation
internal import IvorMIDI
internal import XestiTools

private import XestiText

internal struct SMFDumper: Dumper {

    // MARK: Internal Initializers

    internal init(_ stdio: StandardIO) {
        self.stdio = stdio
    }

    // MARK: Internal Instance Properties

    internal let stdio: StandardIO
}

// MARK: -

extension SMFDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ fileURL: URL) throws {
        var banner = "Dump of Standard MIDI File "

        banner += format(fileURL.path)

        emit()
        emit(banner)

        let (sequence, _) = try SMFParser().parse(readFile(fileURL))

        _dump(2, sequence)

        emit()
    }

    internal func format(_ bytes: [UInt8]) -> String {
        bytes.map { _format($0) }.joined(separator: " ")
    }

    // MARK: Private Instance Methods

    private func _asciify(_ bytes: [UInt8]) -> String {
        bytes.map { _asciify($0) }.joined(separator: " ")
    }

    private func _asciify(_ dataByte: UInt8) -> String {
        switch dataByte {
        case 0x20...0x7e,
             0xa1...0xff:
            String(Unicode.Scalar(dataByte))

        default:
            "."
        }
    }

    private func _dump(_ indent: Int,
                       _ bytes: [UInt8],
                       chunkSize: Int = 16) {
        emit()

        var tmpBytes = bytes

        while !tmpBytes.isEmpty {
            let chunk = Array(tmpBytes.prefix(16))

            var line = format(chunk)

            if chunk.count < chunkSize {
                line += "   ".repeating(to: chunkSize - chunk.count)
            }

            line += spacer()
            line += _asciify(chunk)

            emit(indent, line)

            tmpBytes = Array(tmpBytes.dropFirst(chunk.count))
        }

        emit()
    }

    private func _dump(_ indent: Int,
                       _ event: SMFEvent,
                       _ division: SMFDivision) {
        var line = _format(event.eventTime,
                           division)

        line += spacer()

        var bytes: [UInt8]?

        switch event {
        case let .meta(_, message):
            line += format(message)

        case let .midi(_, message):
            line += format(message)

        case let .sysEx(_, message):
            let (tmpMessage, tmpBytes) = format(message)

            line += tmpMessage

            bytes = tmpBytes
        }

        emit(indent, line)

        if let bytes {
            _dump(indent + 2, bytes)
        }
    }

    private func _dump(_ indent: Int,
                       _ sequence: SMFSequence) {
        let division = sequence.division
        let sformat = sequence.format
        let tracks = sequence.tracks

        var header = "Sequence"

        header += spacer()
        header += "Format "
        header += format(sformat.uintValue)
        header += spacer()
        header += format(tracks.count, "track")
        header += spacer()
        header += _format(division)

        emit()
        emit(indent, header)

        for (index, track) in tracks.enumerated() {
            _dump(indent + 2, track, index, division)
        }
    }

    private func _dump(_ indent: Int,
                       _ track: SMFTrack,
                       _ index: Int,
                       _ division: SMFDivision) {
        let events = track.events

        var header = "Track #"

        header += format(index + 1)
        header += spacer()
        header += format(events.count, "event")

        emit()
        emit(indent, header)

        if !events.isEmpty {
            emit()

            for event in events {
                _dump(indent + 2, event, division)
            }
        }
    }

    private func _format(_ byte: UInt8) -> String {
        let hexString = String(byte,
                               radix: 16,
                               uppercase: true)

        if hexString.count < 2 {
            return "0" + hexString
        }

        return hexString
    }

    private func _format(_ division: SMFDivision) -> String {
        switch division {
        case let .metrical(tickRate):
            _format(tickRate)

        case let .timeCode(timeCode):
            format(timeCode)
        }
    }

    private func _format(_ eventTime: SMFEventTime,
                         _ division: SMFDivision) -> String {
        switch division {
        case let .metrical(tickRate):
            format(eventTime.beatTime(tickRate),
                   precision: 3...3)

        case let .timeCode(timeCode):
            format(eventTime.smpteTime(timeCode),
                   includeFrameRate: false)
        }
    }

    private func _format(_ tickRate: SMFTickRate) -> String {
        let rawTickRate = tickRate.uintValue

        var result = format(rawTickRate, "tick")

        result += "/quarter-note"

        return result
    }
}
