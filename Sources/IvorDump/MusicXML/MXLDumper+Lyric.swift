// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func format(_ extend: MXLExtend) -> String {
        var result = "Extend"

        if let kind = extend.kind {
            result += " "
            result += format(kind)
        }

        append(&result, format(extend.position))
        append(&result, extend.color.map { format($0) })

        return result
    }

    internal func format(_ lyric: MXLLyric) -> String {
        var result = "Lyric"

        if let number = lyric.number {
            result += spacer()
            result += format(number)
        }

        if let name = lyric.name {
            result += spacer()
            result += format(name)
        }

        result += spacer()
        result += _format(lyric.content)

        if lyric.endsLine {
            result += spacer()
            result += "End line"
        }

        if lyric.endsParagraph {
            result += spacer()
            result += "End paragraph"
        }

        append(&result, lyric.placement.map { format($0) })
        append(&result, lyric.justify.map { "Justify " + format($0) })
        append(&result, format(lyric.position))
        append(&result, lyric.color.map { format($0) })
        append(&result, lyric.printsObject, "Printed", "Not printed")

        return result
    }

    // MARK: Private Instance Methods

    private func _format(_ content: MXLLyric.Content) -> String {
        switch content {
        case .extend:
            return "Extend"

        case .humming:
            return "Humming"

        case .laughing:
            return "Laughing"

        case let .syllabic(syllabic, text, group, extend):
            var result = format(text)

            if let syllabic {
                result += spacer()
                result += _format(syllabic)
            }

            for entry in group {
                if let entryGroup = entry.group {
                    result += spacer()
                    result += "Elision "
                    result += format(entryGroup.elision.value)

                    append(&result, format(entryGroup.elision.font))
                    append(&result, entryGroup.elision.color.map { format($0) })
                    append(&result, entryGroup.elision.smufl.map { format($0.stringValue) })

                    if let entrySyllabic = entryGroup.syllabic {
                        result += spacer()
                        result += _format(entrySyllabic)
                    }
                }

                result += spacer()
                result += format(entry.text)
            }

            if let extend {
                result += spacer()
                result += format(extend)
            }

            return result
        }
    }

    private func _format(_ syllabic: MXLSyllabic) -> String {
        switch syllabic {
        case .begin:
            "Begin"

        case .end:
            "End"

        case .middle:
            "Middle"

        case .single:
            "Single"
        }
    }
}
