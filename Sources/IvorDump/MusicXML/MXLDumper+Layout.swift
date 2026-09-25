// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ layout: MXLLayout) {
        if let pageLayout = layout.pageLayout {
            emit(indent, _format(pageLayout))

            for margins in pageLayout.pageMargins {
                emit(indent + 2, _format(margins))
            }
        }

        if let systemLayout = layout.systemLayout {
            emit(indent, _format(systemLayout))

            if let dividers = systemLayout.systemDividers {
                var line = "System dividers"

                append(&line,
                       dividers.leftDivider.printsObject,
                       "Left shown",
                       "Left hidden")
                append(&line,
                       dividers.rightDivider.printsObject,
                       "Right shown",
                       "Right hidden")
                append(&line, format(dividers.leftDivider.printStyleAlign))
                append(&line, format(dividers.rightDivider.printStyleAlign))

                emit(indent + 2, line)
            }
        }

        for staffLayout in layout.staffLayout {
            emit(indent, _format(staffLayout))
        }
    }

    internal func dump(_ indent: Int,
                       _ print: MXLPrint) {
        emit(indent, _format(print))

        dump(indent + 2, print.layout)

        if let measureLayout = print.measureLayout,
           let distance = measureLayout.measureDistance {
            emit(indent + 2,
                 "Measure layout" + spacer() + "Distance " + format(distance))
        }

        if let measureNumbering = print.measureNumbering {
            emit(indent + 2, _format(measureNumbering))
        }

        if let nameDisplay = print.partNameDisplay {
            emit(indent + 2,
                 "Part name display" + spacer() + format(nameDisplay))
        }

        if let nameDisplay = print.partAbbreviationDisplay {
            emit(indent + 2,
                 "Part abbreviation display" + spacer() + format(nameDisplay))
        }
    }

    internal func format(_ system: MXLSystemRelation) -> String {
        switch system {
        case .alsoTop:
            "Also top"

        case .onlyPart:
            "Only part"

        case .onlyTop:
            "Only top"
        }
    }

    // MARK: Private Instance Methods

    private func _format(_ kind: MXLPageMargins.Kind) -> String {
        switch kind {
        case .both:
            "both"

        case .even:
            "even"

        case .odd:
            "odd"
        }
    }

    private func _format(_ margins: MXLPageMargins) -> String {
        var result = "Page margins "

        result += _format(margins.kind)
        result += spacer()
        result += _format(margins.allMargins)

        return result
    }

    private func _format(_ margins: MXLAllMargins) -> String {
        var result = _format(margins.leftRightMargins)

        result += spacer()
        result += "T "
        result += format(margins.topMargin)
        result += spacer()
        result += "B "
        result += format(margins.bottomMargin)

        return result
    }

    private func _format(_ margins: MXLLeftRightMargins) -> String {
        var result = "L "

        result += format(margins.leftMargin)
        result += spacer()
        result += "R "
        result += format(margins.rightMargin)

        return result
    }

    private func _format(_ numbering: MXLMeasureNumbering) -> String {
        var result = "Measure numbering "

        result += _format(numbering.value)

        if let staff = numbering.staff {
            result += spacer()
            result += "Staff "
            result += format(staff.uintValue)
        }

        if let system = numbering.system {
            result += spacer()
            result += _format(system)
        }

        append(&result,
               numbering.alwaysShowsOnMultipleRest,
               "Always on multiple rest",
               "Not always on multiple rest")

        append(&result,
               numbering.showsRangeOnMultipleRest,
               "Range on multiple rest",
               "No range on multiple rest")

        return result
    }

    private func _format(_ pageLayout: MXLPageLayout) -> String {
        var result = "Page layout"

        if let group = pageLayout.group {
            result += spacer()
            result += format(group.pageWidth)
            result += " × "
            result += format(group.pageHeight)
        }

        return result
    }

    private func _format(_ print: MXLPrint) -> String {
        var result = "Print"

        let attributes = print.attributes

        if let startsNewPage = attributes.startsNewPage {
            result += spacer()
            result += startsNewPage ? "New page" : "Same page"
        }

        if let startsNewSystem = attributes.startsNewSystem {
            result += spacer()
            result += startsNewSystem ? "New system" : "Same system"
        }

        if let pageNumber = attributes.pageNumber {
            result += spacer()
            result += "Page "
            result += format(pageNumber)
        }

        if let blankPage = attributes.blankPage {
            result += spacer()
            result += format(blankPage, "blank page")
        }

        if let staffSpacing = attributes.staffSpacing {
            result += spacer()
            result += "Staff spacing "
            result += format(staffSpacing)
        }

        if let id = print.id {
            result += spacer()
            result += "ID "
            result += format(id)
        }

        return result
    }

    private func _format(_ relation: MXLSystemRelationNumber) -> String {
        switch relation {
        case .alsoBottom:
            "Also bottom"

        case .alsoTop:
            "Also top"

        case .onlyBottom:
            "Only bottom"

        case .onlyPart:
            "Only part"

        case .onlyTop:
            "Only top"
        }
    }

    private func _format(_ staffLayout: MXLStaffLayout) -> String {
        var result = "Staff layout"

        if let number = staffLayout.number {
            result += spacer()
            result += "Staff "
            result += format(number.uintValue)
        }

        if let distance = staffLayout.staffDistance {
            result += spacer()
            result += "Distance "
            result += format(distance)
        }

        return result
    }

    private func _format(_ systemLayout: MXLSystemLayout) -> String {
        var result = "System layout"

        if let margins = systemLayout.systemMargins {
            result += spacer()
            result += _format(margins.leftRightMargins)
        }

        if let distance = systemLayout.systemDistance {
            result += spacer()
            result += "Distance "
            result += format(distance)
        }

        if let topDistance = systemLayout.topSystemDistance {
            result += spacer()
            result += "Top distance "
            result += format(topDistance)
        }

        return result
    }

    private func _format(_ value: MXLMeasureNumbering.Value) -> String {
        switch value {
        case .measure:
            "Each measure"

        case .never:
            "Never"

        case .system:
            "Each system"
        }
    }
}
