// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import Foundation
internal import IvorABC

extension ABCDumper {

    // MARK: Internal Instance Methods

    internal func format(_ field: ABCField) -> String { // swiftlint:disable:this function_body_length
        var result = ""

        switch field {
        case let .area(value):
            result += "Area"
            result += spacer()
            result += format(value.stringValue)

        case let .book(value):
            result += "Book"
            result += spacer()
            result += format(value.stringValue)

        case let .composer(value):
            result += "Composer"
            result += spacer()
            result += format(value.stringValue)

        case let .discography(value):
            result += "Discography"
            result += spacer()
            result += format(value.stringValue)

        case let .elemskip(value):
            result += "Elemskip"
            result += spacer()
            result += _format(value)

        case let .fileURL(value):
            result += "File URL"
            result += spacer()
            result += format(value.stringValue)

        case let .group(value):
            result += "Group"
            result += spacer()
            result += format(value.stringValue)

        case let .history(value):
            result += "History"
            result += spacer()
            result += format(value.stringValue)

        case let .information(value):
            result += "Information"
            result += spacer()
            result += format(value.stringValue)

        case let .instruction(value):
            result += "Instruction"
            result += spacer()
            result += format(value)

        case let .key(value):
            result += "Key"
            result += spacer()
            result += format(value)

        case let .macro(value):
            result += "Macro"
            result += spacer()
            result += format(value.target)
            result += spacer()
            result += format(value.replacement)

        case let .meter(value):
            result += "Meter"
            result += spacer()
            result += _format(value)

        case let .notes(value):
            result += "Notes"
            result += spacer()
            result += format(value.stringValue)

        case let .origin(value):
            result += "Origin"
            result += spacer()
            result += format(value.stringValue)

        case let .part(value):
            result += "Part"
            result += spacer()
            result += _format(value)

        case let .parts(value):
            result += "Parts"
            result += spacer()
            result += format(value.expansion)
            result += spacer()
            result += _format(value.items)

        case let .referenceNumber(value):
            result += "Reference number"
            result += spacer()
            result += format(value.uintValue)

        case let .remark(value):
            result += "Remark"
            result += spacer()
            result += format(value.stringValue)

        case let .rhythm(value):
            result += "Rhythm"
            result += spacer()
            result += format(value.stringValue)

        case let .source(value):
            result += "Source"
            result += spacer()
            result += format(value.stringValue)

        case let .symbolLine(value):
            result += "Symbol line"
            result += spacer()
            result += _format(value)

        case let .tempo(value):
            result += "Tempo"
            result += spacer()
            result += _format(value)

        case let .transcription(value):
            result += "Transcription"
            result += spacer()
            result += format(value.stringValue)

        case let .tuneTitle(value):
            result += "Tune title"
            result += spacer()
            result += format(value.stringValue)

        case let .unitNoteLength(value):
            result += "Unit note length"
            result += spacer()
            result += format(value)

        case let .userDefined(value):
            result += "User-defined symbol"
            result += spacer()
            result += format(value)

        case let .voice(value):
            result += "Voice"
            result += spacer()
            result += format(value)

        case let .words(value):
            result += "Words"
            result += spacer()
            result += format(value.stringValue)

        case let .wordsAligned(value):
            result += "Aligned words"
            result += spacer()
            result += _format(value)
        }

        return result
    }

    // MARK: Private Instance Methods

    private func _format(_ alignedWords: ABCAlignedWords) -> String {
        alignedWords.segments.map { _format($0) }.joined(separator: spacer())
    }

    private func _format(_ element: ABCSymbolLine.Element) -> String {
        switch element {
        case let .annotation(annotation):
            format(annotation)

        case let .chordSymbol(chordSymbol):
            format(chordSymbol)

        case let .decoration(decoration):
            format(decoration)

        case .skip:
            "*"
        }
    }

    private func _format(_ elemskip: ABCElemskip) -> String {
        switch elemskip {
        case let .decimal(value):
            format(value)

        case let .integer(value):
            format(value)
        }
    }

    private func _format(_ items: [ABCPartSequence.Item]) -> String {
        items.map { item in
            switch item {
            case let .group(children, repeatCount):
                "(" + _format(children) + ")" + _format(repeatCount)

            case let .part(part, repeatCount):
                _format(part) + _format(repeatCount)
            }
        }.joined(separator: " ")
    }

    private func _format(_ part: ABCPart) -> String {
        switch part {
        case .a:
            "A"

        case .b:
            "B"

        case .c:
            "C"

        case .d:
            "D"

        case .e:
            "E"

        case .f:
            "F"

        case .g:
            "G"

        case .h:
            "H"

        case .i:
            "I"

        case .j:
            "J"

        case .k:
            "K"

        case .l:
            "L"

        case .m:
            "M"

        case .n:
            "N"

        case .o:
            "O"

        case .p:
            "P"

        case .q:
            "Q"

        case .r:
            "R"

        case .s:
            "S"

        case .t:
            "T"

        case .u:
            "U"

        case .v:
            "V"

        case .w:
            "W"

        case .x:
            "X"

        case .y:
            "Y"

        case .z:
            "Z"
        }
    }

    private func _format(_ repeatCount: ABCPartSequence.Item.RepeatCount) -> String {
        repeatCount.uintValue != 1 ? format(repeatCount.uintValue) : ""
    }

    private func _format(_ segment: ABCAlignedWords.Segment) -> String {
        switch segment {
        case .barAlign:
            "|"

        case .continuation:
            "-"

        case .hold:
            "_"

        case .skip:
            "*"

        case let .syllable(syllable):
            "\"\(syllable.stringValue)\""
        }
    }

    private func _format(_ symbolLine: ABCSymbolLine) -> String {
        symbolLine.elements.map { _format($0) }.joined(separator: spacer())
    }

    private func _format(_ tempo: ABCTempo) -> String {
        var items: [String] = []

        // A non-nil beat multiplier means the tempo is still unresolved: the
        // beat is `n` times the active unit note length, and `lengths` is empty.
        if let multiplier = tempo.beatMultiplier {
            items.append("beat " + format(multiplier) + "×L")
        } else if !tempo.lengths.isEmpty {
            items.append(tempo.lengths.map { format($0) }.joined(separator: " "))
        }

        if let rate = tempo.rate {
            items.append(format(rate) + " bpm")
        }

        if let text = tempo.text {
            items.append(format(text))
        }

        return items.joined(separator: spacer())
    }

    private func _format(_ timeSignature: ABCTimeSignature) -> String {
        switch timeSignature {
        case .common:
            "Common time"

        case let .complex(meter):
            meter.numerators.map { format($0) }.joined(separator: "+") + "/" + format(meter.denominator)

        case .cut:
            "Cut time"

        case .empty:
            "Empty"

        case let .standard(meter):
            format(meter.numerator) + "/" + format(meter.denominator)
        }
    }
}
