// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ credit: MXLCredit) {
        var line = "Credit"

        if let page = credit.page {
            line += spacer()
            line += "Page "
            line += format(page)
        }

        for kind in credit.kind {
            line += spacer()
            line += format(kind)
        }

        if let id = credit.id {
            line += spacer()
            line += "ID "
            line += format(id)
        }

        emit()
        emit(indent, line)

        _dump(indent + 2, credit.content)

        for link in credit.link {
            emit(indent + 2, format(link))
        }

        for bookmark in credit.bookmark {
            emit(indent + 2, format(bookmark))
        }
    }

    internal func dump(_ indent: Int,
                       _ defaults: MXLDefaults) {
        emit()
        emit(indent, _format(defaults))

        dump(indent + 2, defaults.layout)

        if let musicFont = format(defaults.musicFont ?? MXLFont()) {
            emit(indent + 2, "Music " + musicFont)
        }

        if let wordFont = format(defaults.wordFont ?? MXLFont()) {
            emit(indent + 2, "Word " + wordFont)
        }

        for lyricFont in defaults.lyricFont {
            emit(indent + 2, _format(lyricFont))
        }

        for language in defaults.lyricLanguage {
            emit(indent + 2, _format(language))
        }

        if let appearance = defaults.appearance {
            _dump(indent + 2, appearance)
        }
    }

    internal func dump(_ indent: Int,
                       _ identification: MXLIdentification) {
        emit()
        emit(indent, "Identification")

        for creator in identification.creator {
            emit(indent + 2, _format("Creator", creator))
        }

        for rights in identification.rights {
            emit(indent + 2, _format("Rights", rights))
        }

        for relation in identification.relation {
            emit(indent + 2, _format("Relation", relation))
        }

        if let source = identification.source {
            emit(indent + 2,
                 "Source" + spacer() + format(source))
        }

        if let encoding = identification.encoding {
            emit(indent + 2, "Encoding")

            for item in encoding.items {
                emit(indent + 4, _format(item))
            }
        }

        if let miscellaneous = identification.miscellaneous {
            emit(indent + 2, "Miscellaneous")

            for field in miscellaneous.field {
                emit(indent + 4,
                     format(field.name) + spacer() + format(field.value))
            }
        }
    }

    // MARK: Private Instance Methods

    private func _dump(_ indent: Int,
                       _ appearance: MXLAppearance) {
        emit(indent, "Appearance")

        for lineWidth in appearance.lineWidth {
            emit(indent + 2,
                 "Line width" + spacer() + format(lineWidth.kind)
                     + spacer() + format(lineWidth.value))
        }

        for noteSize in appearance.noteSize {
            emit(indent + 2,
                 "Note size" + spacer() + _format(noteSize.kind)
                     + spacer() + format(noteSize.value))
        }

        for distance in appearance.distance {
            emit(indent + 2,
                 "Distance" + spacer() + format(distance.kind)
                     + spacer() + format(distance.value))
        }

        for glyph in appearance.glyph {
            emit(indent + 2,
                 "Glyph" + spacer() + format(glyph.kind)
                     + spacer() + format(glyph.value))
        }

        for other in appearance.otherAppearance {
            emit(indent + 2,
                 "Other appearance" + spacer() + format(other.kind)
                     + spacer() + format(other.value))
        }
    }

    private func _dump(_ indent: Int,
                       _ content: MXLCredit.Content) {
        switch content {
        case let .alternative(alternativeContent, group):
            emit(indent, _format(alternativeContent))

            for entry in group {
                emit(indent, _format(entry.content))

                for link in entry.link {
                    emit(indent + 2, format(link))
                }

                for bookmark in entry.bookmark {
                    emit(indent + 2, format(bookmark))
                }
            }

        case let .creditImage(image):
            emit(indent, format(image))
        }
    }

    private func _format(_ content: MXLCredit.Content.AlternativeContent) -> String {
        switch content {
        case let .creditSymbol(symbol):
            "Credit symbol" + spacer() + format(symbol)

        case let .creditWords(words):
            "Credit words" + spacer() + format(words)
        }
    }

    private func _format(_ content: MXLCredit.Content.AlternativeGroup.Content) -> String {
        switch content {
        case let .creditSymbol(symbol):
            "Credit symbol" + spacer() + format(symbol)

        case let .creditWords(words):
            "Credit words" + spacer() + format(words)
        }
    }

    private func _format(_ defaults: MXLDefaults) -> String {
        var result = "Defaults"

        if defaults.isConcertScore {
            result += spacer()
            result += "Concert score"
        }

        if let scaling = defaults.scaling {
            result += spacer()
            result += "Scaling "
            result += format(scaling.millimeters)
            result += "mm/"
            result += format(scaling.tenths)
            result += " tenths"
        }

        return result
    }

    private func _format(_ item: MXLEncoding.Item) -> String {
        switch item {
        case let .encoder(encoder):
            return _format("Encoder", encoder)

        case let .encodingDate(date):
            return "Encoding date" + spacer() + format(date)

        case let .encodingDescription(description):
            return "Encoding description" + spacer() + format(description)

        case let .software(software):
            return "Software" + spacer() + format(software)

        case let .supports(supports):
            var result = "Supports"

            result += spacer()
            result += supports.isSupported ? "yes" : "no"
            result += spacer()
            result += format(supports.element)

            if let attribute = supports.attribute {
                result += spacer()
                result += format(attribute)
            }

            if let value = supports.value {
                result += spacer()
                result += format(value)
            }

            return result
        }
    }

    private func _format(_ kind: MXLNoteSize.Kind) -> String {
        switch kind {
        case .cue:
            "Cue"

        case .grace:
            "Grace"

        case .graceCue:
            "Grace-cue"

        case .large:
            "Large"
        }
    }

    private func _format(_ label: String,
                         _ text: MXLTypedText) -> String {
        var result = label

        if let kind = text.kind {
            result += spacer()
            result += format(kind)
        }

        result += spacer()
        result += format(text.value)

        return result
    }

    private func _format(_ language: MXLLyricLanguage) -> String {
        var result = "Lyric language"

        if let number = language.number {
            result += spacer()
            result += format(number)
        }

        if let name = language.name {
            result += spacer()
            result += format(name)
        }

        if let xmlLang = language.xmlLang {
            result += spacer()
            result += format(xmlLang)
        }

        return result
    }

    private func _format(_ lyricFont: MXLLyricFont) -> String {
        var result = "Lyric font"

        if let number = lyricFont.number {
            result += spacer()
            result += format(number)
        }

        if let name = lyricFont.name {
            result += spacer()
            result += format(name)
        }

        if let font = format(lyricFont.font) {
            result += spacer()
            result += font
        }

        return result
    }
}
