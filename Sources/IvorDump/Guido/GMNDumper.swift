// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import Foundation
internal import IvorGuido
internal import XestiTools

internal struct GMNDumper: Dumper {

    // MARK: Internal Initializers

    internal init(_ stdio: StandardIO) {
        self.stdio = stdio
    }

    // MARK: Internal Instance Properties

    internal let stdio: StandardIO
}

// MARK: -

extension GMNDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ fileURL: URL) throws {
        var banner = "Dump of Guido Score File "

        banner += format(fileURL.path)

        emit()
        emit(banner)

        let (score, diagnostics) = try GMNParser().parse(readFile(fileURL))

        _dump(2, score)
        _dump(2, diagnostics)

        emit()
    }

    internal func dump(_ indent: Int,
                       _ symbol: GMNSymbol) {
        switch symbol {
        case let .chord(chord):
            dump(indent, chord)

        case let .note(note):
            dump(indent, note)

        case let .rest(rest):
            dump(indent, rest)

        case let .tablature(tablature):
            dump(indent, tablature)

        case let .tag(tag):
            dump(indent, tag)

        case let .variable(name):
            var line = ""

            line += "Variable"
            line += spacer()
            line += name.stringValue

            emit(indent, line)
        }
    }

    // MARK: Private Instance Methods

    private func _dump(_ indent: Int,
                       _ diagnostics: [GMNParser.Diagnostic]) {
        guard !diagnostics.isEmpty
        else { return }

        var header = "Diagnostics"

        header += spacer()
        header += format(diagnostics.count, "diagnostic")

        emit()
        emit(indent, header)
        emit()

        for (index, diagnostic) in diagnostics.enumerated() {
            var line = "Diagnostic #"

            line += format(index + 1)
            line += spacer()
            line += diagnostic.message

            emit(indent + 2, line)
        }
    }

    private func _dump(_ indent: Int,
                       _ score: GMNScore) {
        let variables = score.variables
        let voices = score.voices

        var header = "Score"

        if !variables.isEmpty {
            header += spacer()
            header += format(variables.count, "variable")
        }

        if !voices.isEmpty {
            header += spacer()
            header += format(voices.count, "voice")
        }

        emit()
        emit(indent, header)

        if !variables.isEmpty {
            emit()

            for (index, variable) in variables.enumerated() {
                _dump(indent + 2, variable, index)
            }
        }

        for (index, voice) in voices.enumerated() {
            _dump(indent + 2, voice, index)
        }
    }

    private func _dump(_ indent: Int,
                       _ variable: GMNVariable,
                       _ index: Int) {
        var line = "Variable #"

        line += format(index + 1)
        line += spacer()
        line += variable.name.stringValue
        line += spacer()

        switch variable.value {
        case let .floating(value):
            line += format(value)

        case let .integer(value):
            line += format(value)

        case let .string(value):
            line += format(value)
        }

        emit(indent, line)
    }

    private func _dump(_ indent: Int,
                       _ voice: GMNVoice,
                       _ index: Int) {
        let symbols = voice.symbols

        var header = "Voice #"

        header += format(index + 1)
        header += spacer()
        header += format(symbols.count, "symbol")

        emit()
        emit(indent, header)

        if !symbols.isEmpty {
            emit()

            for symbol in symbols {
                dump(indent + 2, symbol)
            }
        }
    }
}
