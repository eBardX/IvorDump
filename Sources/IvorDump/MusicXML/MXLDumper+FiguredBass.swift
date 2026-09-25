// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ figuredBass: MXLFiguredBass) {
        var line = "Figured bass"

        if let duration = figuredBass.duration {
            line += spacer()
            line += format(duration.intValue)
        }

        if let placement = figuredBass.placement {
            line += spacer()
            line += format(placement)
        }

        append(&line, figuredBass.hasParentheses, "Parenthesized", "Not parenthesized")

        if let printout = format(figuredBass.printout) {
            line += spacer()
            line += printout
        }

        if let id = figuredBass.id {
            line += spacer()
            line += "ID "
            line += format(id)
        }

        if let footnote = figuredBass.footnote {
            line += spacer()
            line += "Footnote "
            line += format(footnote)
        }

        if let level = figuredBass.level {
            line += spacer()
            line += format(level)
        }

        append(&line, figuredBass.placement.map { format($0) })
        appendStyle(&line,
                    position: figuredBass.position,
                    font: figuredBass.font,
                    color: figuredBass.color,
                    halign: figuredBass.halign,
                    valign: figuredBass.valign)

        emit(indent, line)

        for figure in figuredBass.figure {
            emit(indent + 2, _format(figure))
        }
    }

    internal func dump(_ indent: Int,
                       _ grouping: MXLGrouping) {
        var line = "Grouping "

        line += format(grouping.kind)
        line += spacer()
        line += format(grouping.number)

        if let memberOf = grouping.memberOf {
            line += spacer()
            line += "Member of "
            line += format(memberOf)
        }

        if let id = grouping.id {
            line += spacer()
            line += "ID "
            line += format(id)
        }

        emit(indent, line)

        for feature in grouping.feature {
            var featureLine = "Feature"

            if let kind = feature.kind {
                featureLine += spacer()
                featureLine += format(kind)
            }

            featureLine += spacer()
            featureLine += format(feature.value)

            emit(indent + 2, featureLine)
        }
    }

    // MARK: Private Instance Methods

    private func _format(_ figure: MXLFigure) -> String {
        var result = "Figure"

        if let prefix = figure.prefix {
            result += spacer()
            result += format(prefix)
        }

        if let number = figure.number {
            result += spacer()
            result += format(number)
        }

        if let suffix = figure.suffix {
            result += spacer()
            result += format(suffix)
        }

        if let extend = figure.extend {
            result += spacer()
            result += format(extend)
        }

        if let footnote = figure.footnote {
            result += spacer()
            result += "Footnote "
            result += format(footnote)
        }

        if let level = figure.level {
            result += spacer()
            result += format(level)
        }

        return result
    }
}
