// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import Foundation
internal import IvorMusicXML
internal import XestiTools

internal struct MXLDumper {

    // MARK: Internal Initializers

    internal init(_ stdio: StandardIO) {
        self.stdio = stdio
    }

    // MARK: Internal Instance Properties

    internal let stdio: StandardIO
}

// MARK: -

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ fileURL: URL) throws {
        let compressed = fileURL.pathExtension == "mxl"

        var banner = "Dump of "

        if compressed {
            banner += "Compressed "
        }

        banner += "MusicXML Document "
        banner += format(fileURL.path)

        emit()
        emit(banner)

        let (document, diagnostics) = try MXLParser().parse(readFile(fileURL),
                                                            compressed: compressed)

        _dump(2, document)
        _dump(2, diagnostics)

        emit()
    }

    internal func dump(_ indent: Int,
                       _ item: MXLMusicItem) {
        var line = ""

        switch item {
        case let .attributes(attributes):
            dump(indent, attributes)

            return

        case let .backup(backup):
            line += "Backup"
            line += spacer()
            line += format(backup.duration.intValue)

        case let .barline(barline):
            dump(indent, barline)

            return

        case let .bookmark(bookmark):
            line += format(bookmark)

        case let .direction(direction):
            dump(indent, direction)

            return

        case let .figuredBass(figuredBass):
            dump(indent, figuredBass)

            return

        case let .forward(forward):
            line += "Forward"
            line += spacer()
            line += format(forward.duration.intValue)

        case let .grouping(grouping):
            dump(indent, grouping)

            return

        case let .harmony(harmony):
            dump(indent, harmony)

            return

        case let .link(link):
            line += format(link)

        case let .listening(listening):
            dump(indent, listening)

            return

        case let .note(note):
            dump(indent, note)

            return

        case let .print(print):
            dump(indent, print)

            return

        case let .sound(sound):
            line += "Sound"

            if let tempo = sound.tempo {
                line += spacer()
                line += format(Int(tempo))
                line += " bpm"
            }
        }

        emit(indent, line)
    }

    internal func format(_ version: MXLDocument.Version) -> String {
        var result = "v"

        result += format(version.major)
        result += "."
        result += format(version.minor)

        return result
    }

    // MARK: Private Instance Methods

    private func _dump(_ indent: Int,
                       _ diagnostics: [MXLParser.Diagnostic]) {
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
                       _ document: MXLDocument) {
        switch document.content {
        case let .opus(opus):
            _dump(indent, opus)

        case let .scorePartwise(score):
            dump(indent, score)

        case let .scoreTimewise(score):
            dump(indent, score)
        }
    }

    private func _dump(_ indent: Int,
                       _ item: MXLOpus.Item) {
        switch item {
        case let .opus(opus):
            _dump(indent, opus)

        case let .opusLink(link):
            emit(indent,
                 "Opus link" + spacer() + format(link))

        case let .score(score):
            emit(indent,
                 "Score" + spacer() + _format(score))
        }
    }

    private func _dump(_ indent: Int,
                       _ opus: MXLOpus) {
        let items = opus.items

        var header = "Opus"

        header += spacer()
        header += format(opus.version)
        header += spacer()
        header += format(items.count, "item")

        emit()
        emit(indent, header)

        if let title = opus.title {
            var line = "Title"

            line += spacer()
            line += format(title)

            emit()
            emit(indent + 2, line)
        }

        for item in items {
            _dump(indent + 2, item)
        }
    }

    private func _format(_ score: MXLOpus.Score) -> String {
        var result = format(score.xlink)

        if let newPage = score.newPage {
            result += spacer()
            result += newPage ? "New page" : "Same page"
        }

        return result
    }
}

// MARK: - Dumper

extension MXLDumper: Dumper {
}
