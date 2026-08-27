// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func format(_ bookmark: MXLBookmark) -> String {
        var result = "Bookmark "

        result += format(bookmark.id)

        if let name = bookmark.name {
            result += spacer()
            result += format(name)
        }

        result += format(bookmark.elementPosition)

        return result
    }

    internal func format(_ direction: MXLUpDown) -> String {
        switch direction {
        case .down:
            "Down"

        case .up:
            "Up"
        }
    }

    internal func format(_ kind: MXLStartStopDiscontinue) -> String {
        switch kind {
        case .discontinue:
            "Discontinue"

        case .start:
            "Start"

        case .stop:
            "Stop"
        }
    }

    internal func format(_ kind: MXLStartStopSingle) -> String {
        switch kind {
        case .single:
            "Single"

        case .start:
            "Start"

        case .stop:
            "Stop"
        }
    }

    internal func format(_ kind: MXLStartStop) -> String {
        switch kind {
        case .start:
            "Start"

        case .stop:
            "Stop"
        }
    }

    internal func format(_ kind: MXLTied.Kind) -> String {
        switch kind {
        case .continue:
            "Continue"

        case .letRing:
            "Let ring"

        case .start:
            "Start"

        case .stop:
            "Stop"
        }
    }

    internal func format(_ kind: MXLStartStopContinue) -> String {
        switch kind {
        case .continue:
            "Continue"

        case .start:
            "Start"

        case .stop:
            "Stop"
        }
    }

    internal func format(_ kind: MXLTopBottom) -> String {
        switch kind {
        case .bottom:
            "Bottom"

        case .top:
            "Top"
        }
    }

    internal func format(_ kind: MXLUprightInverted) -> String {
        switch kind {
        case .inverted:
            "Inverted"

        case .upright:
            "Upright"
        }
    }

    internal func format(_ link: MXLLink) -> String {
        var result = "Link"

        if let name = link.name {
            result += spacer()
            result += format(name)
        }

        result += spacer()
        result += format(link.xlink)
        result += format(link.elementPosition)

        append(&result, format(link.position))

        return result
    }

    internal func format(_ orientation: MXLOverUnder) -> String {
        switch orientation {
        case .over:
            "Over"

        case .under:
            "Under"
        }
    }

    internal func format(_ space: MXLXmlSpace) -> String {
        switch space {
        case .default:
            "default"

        case .preserve:
            "preserve"
        }
    }

    internal func format(_ value: MXLYesNoNumber) -> String {
        switch value {
        case .no:
            "no"

        case let .number(number):
            format(number)

        case .yes:
            "yes"
        }
    }

    internal func format(_ xlink: MXLXLink) -> String {
        var result = format(xlink.href)

        if let role = xlink.role {
            result += spacer()
            result += format(role)
        }

        if let title = xlink.title {
            result += spacer()
            result += format(title)
        }

        result += spacer()
        result += _format(xlink.show)

        result += spacer()
        result += _format(xlink.actuate)

        return result
    }

    // MARK: Private Instance Methods

    private func _format(_ actuate: MXLXLink.Actuate) -> String {
        switch actuate {
        case .onLoad:
            "On load"

        case .onRequest:
            "On request"

        case .other:
            "Other"

        case .unspecified:
            "Unspecified"
        }
    }

    private func _format(_ show: MXLXLink.Show) -> String {
        switch show {
        case .embed:
            "Embed"

        case .new:
            "New"

        case .other:
            "Other"

        case .replace:
            "Replace"

        case .undefined:
            "Undefined"
        }
    }
}
