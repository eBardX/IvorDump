// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import Foundation
internal import IvorABC
internal import XestiTools

internal struct ABCDumper {

    // MARK: Internal Initializers

    internal init(_ stdio: StandardIO) {
        self.stdio = stdio
    }

    // MARK: Internal Instance Properties

    internal let stdio: StandardIO
}

// MARK: -

extension ABCDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ fileURL: URL) throws {
        var banner = "Dump of ABC File "

        banner += format(fileURL.path)

        emit()
        emit(banner)

        let (tunebook, _) = try ABCParser().parse(readFile(fileURL))

        _dump(2, tunebook)

        emit()
    }

    internal func format(_ directive: ABCDirective) -> String {
        var result = "Directive"

        result += spacer()
        result += directive.name.stringValue
        result += spacer()
        result += format(directive.value)

        if let content = directive.content {
            result += spacer()
            result += format(content.count, "content line")
        }

        return result
    }

    internal func format(_ voice: ABCVoice) -> String {
        var result = voice.id.stringValue

        if let clef = voice.clef {
            let clefStr = format(clef)

            if !clefStr.isEmpty {
                result += spacer()
                result += clefStr
            }
        }

        return result
    }

    // MARK: Private Instance Methods

    private func _dump(_ indent: Int,
                       _ bodyEntry: ABCBodyEntry) {
        switch bodyEntry {
        case let .directive(directive):
            _dump(indent, directive)

        case let .field(field):
            if case let .voice(voice) = field,
               !voice.properties.isEmpty {
                _dump(indent, voice)
                return
            } else {
                emit(indent, format(field))
            }

        case let .symbols(symbols):
            var line = "Body"

            line += spacer()
            line += format(symbols.count, "symbol")

            emit(indent, line)

            for symbol in symbols {
                dump(indent + 2, symbol)
            }
        }
    }

    private func _dump(_ indent: Int,
                       _ directive: ABCDirective) {
        emit(indent, format(directive))

        for line in directive.content ?? [] {
            emit(indent + 2, "Content" + spacer() + format(line))
        }
    }

    private func _dump(_ indent: Int,
                       _ headerEntry: ABCHeaderEntry) {
        var line = ""

        switch headerEntry {
        case let .directive(directive):
            _dump(indent, directive)
            return

        case let .field(field):
            if case let .voice(voice) = field,
               !voice.properties.isEmpty {
                _dump(indent, voice)
                return
            } else {
                line += format(field)
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
        line += _formatVoiceProperty(value)

        emit(indent, line)
    }

    private func _dump(_ indent: Int,
                       _ tune: ABCTune) {
        let header = tune.header
        let body = tune.body

        var line = "Tune"

        if !header.isEmpty {
            line += spacer()
            line += format(header.count,
                           "header entry",
                           plural: "header entries")
        }

        if !body.isEmpty {
            line += spacer()
            line += format(body.count,
                           "body entry",
                           plural: "body entries")
        }

        emit()
        emit(indent, line)

        if !header.isEmpty {
            emit()

            for entry in header {
                _dump(indent + 2, entry)
            }
        }

        if !body.isEmpty {
            emit()

            for entry in body {
                _dump(indent + 2, entry)
            }
        }
    }

    private func _dump(_ indent: Int,
                       _ tunebook: ABCTunebook) {
        let fileHeader = tunebook.fileHeader
        let tunes = tunebook.tunes

        var header = "Tunebook"

        if let version = tunebook.version {
            header += spacer()
            header += _format(version)
        }

        if !fileHeader.isEmpty {
            header += spacer()
            header += format(fileHeader.count, "header")
        }

        if !tunes.isEmpty {
            header += spacer()
            header += format(tunes.count, "tune")
        }

        emit()
        emit(indent, header)

        if !fileHeader.isEmpty {
            emit()

            for headerEntry in fileHeader {
                _dump(indent + 2, headerEntry)
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
        line += format(voice)
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

    private func _format(_ version: ABCVersion) -> String {
        var result = format(version.major)

        result += "."
        result += format(version.minor)

        return result
    }

    private func _formatVoiceProperty(_ vpValue: String) -> String {
        if vpValue.isEmpty || vpValue.contains(where: { $0.isWhitespace }) {
            format(vpValue)
        } else {
            vpValue
        }
    }
}

// MARK: - Dumper

extension ABCDumper: Dumper {
}
