// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ score: MXLScorePartwise) {
        let parts = score.parts

        var header = "Score"

        header += spacer()
        header += "Partwise"
        header += spacer()
        header += format(score.version)
        header += spacer()
        header += format(parts.count, "part")

        emit()
        emit(indent, header)

        if let work = score.work {
            _dump(indent + 2, work)
        }

        _dump(indent + 2,
              score.movementNumber,
              score.movementTitle)

        if let identification = score.identification {
            dump(indent + 2, identification)
        }

        if let defaults = score.defaults {
            dump(indent + 2, defaults)
        }

        for credit in score.credit {
            dump(indent + 2, credit)
        }

        dump(indent + 2, score.partList)

        for part in parts {
            _dump(indent + 2, part)
        }
    }

    internal func dump(_ indent: Int,
                       _ score: MXLScoreTimewise) {
        let measures = score.measures

        var header = "Score"

        header += spacer()
        header += "Timewise"
        header += spacer()
        header += format(score.version)
        header += spacer()
        header += format(measures.count, "measure")

        emit()
        emit(indent, header)

        if let work = score.work {
            _dump(indent + 2, work)
        }

        _dump(indent + 2,
              score.movementNumber,
              score.movementTitle)

        if let identification = score.identification {
            dump(indent + 2, identification)
        }

        if let defaults = score.defaults {
            dump(indent + 2, defaults)
        }

        for credit in score.credit {
            dump(indent + 2, credit)
        }

        dump(indent + 2, score.partList)

        for measure in measures {
            _dump(indent + 2, measure)
        }
    }

    internal func format(measureId: String?,
                         isImplicit: Bool,
                         isNonControlling: Bool,
                         text: MXLMeasureText?,
                         width: MXLTenths?) -> String {
        var result = ""

        if isImplicit {
            result += spacer()
            result += "Implicit"
        }

        if isNonControlling {
            result += spacer()
            result += "Non-controlling"
        }

        if let text {
            result += spacer()
            result += "Text "
            result += format(text.stringValue)
        }

        if let width {
            result += spacer()
            result += "Width "
            result += format(width)
        }

        if let measureId {
            result += spacer()
            result += "ID "
            result += format(measureId)
        }

        return result
    }

    // MARK: Private Instance Methods

    private func _dump(_ indent: Int,
                       _ measure: MXLScorePartwise.Part.Measure) {
        let items = measure.items

        var header = "Measure "

        header += measure.number
        header += spacer()
        header += format(items.count, "item")
        header += format(measureId: measure.id,
                         isImplicit: measure.isImplicit,
                         isNonControlling: measure.isNonControlling,
                         text: measure.text,
                         width: measure.width)

        emit()
        emit(indent, header)

        if !items.isEmpty {
            emit()

            for item in items {
                dump(indent + 2, item)
            }
        }
    }

    private func _dump(_ indent: Int,
                       _ measure: MXLScoreTimewise.Measure) {
        let parts = measure.parts

        var header = "Measure "

        header += measure.number
        header += spacer()
        header += format(parts.count, "part")
        header += format(measureId: measure.id,
                         isImplicit: measure.isImplicit,
                         isNonControlling: measure.isNonControlling,
                         text: measure.text,
                         width: measure.width)

        emit()
        emit(indent, header)

        for part in parts {
            _dump(indent + 2, part)
        }
    }

    private func _dump(_ indent: Int,
                       _ movementNumber: String?,
                       _ movementTitle: String?) {
        var line = "Movement"

        if let movementNumber {
            line += spacer()
            line += format(movementNumber)
        }

        if let movementTitle {
            line += spacer()
            line += format(movementTitle)
        }

        emit()
        emit(indent, line)
    }

    private func _dump(_ indent: Int,
                       _ part: MXLScorePartwise.Part) {
        let measures = part.measures

        var header = "Part "

        header += format(part.id)
        header += spacer()
        header += format(measures.count, "measure")

        emit()
        emit(indent, header)

        for measure in measures {
            _dump(indent + 2, measure)
        }
    }

    private func _dump(_ indent: Int,
                       _ part: MXLScoreTimewise.Measure.Part) {
        let items = part.items

        var header = "Part "

        header += format(part.id)
        header += spacer()
        header += format(items.count, "item")

        emit()
        emit(indent, header)

        if !items.isEmpty {
            emit()

            for item in items {
                dump(indent + 2, item)
            }
        }
    }

    private func _dump(_ indent: Int,
                       _ work: MXLWork) {
        var line = "Work"

        if let number = work.number {
            line += spacer()
            line += format(number)
        }

        if let title = work.title {
            line += spacer()
            line += format(title)
        }

        emit()
        emit(indent, line)

        if let opus = work.opus {
            emit(indent + 2,
                 "Opus" + spacer() + format(opus))
        }
    }
}
