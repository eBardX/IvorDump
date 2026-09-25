// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ indent: Int,
                       _ listening: MXLListening) {
        var line = "Listening"

        if let offset = listening.offset {
            line += spacer()
            line += "Offset "
            line += format(offset.value)
        }

        emit(indent, line)

        for item in listening.items {
            emit(indent + 2, format(item))
        }
    }

    internal func format(_ item: MXLListening.Item) -> String {
        switch item {
        case let .otherListening(other):
            var result = "Other listening "

            result += format(other.kind)

            if !other.value.isEmpty {
                result += spacer()
                result += format(other.value)
            }

            if let player = other.player {
                result += spacer()
                result += "Player "
                result += format(player)
            }

            return result

        case let .sync(sync):
            var result = "Sync "

            result += _format(sync.kind)

            if let latency = sync.latency {
                result += spacer()
                result += "Latency "
                result += format(latency.uintValue)
                result += " ms"
            }

            if let player = sync.player {
                result += spacer()
                result += "Player "
                result += format(player)
            }

            return result
        }
    }

    internal func format(_ listen: MXLListen) -> String {
        var result = "Listen"

        for item in listen.items {
            result += spacer()
            result += _format(item)
        }

        return result
    }

    internal func format(_ play: MXLPlay) -> String {
        var result = "Play"

        for item in play.items {
            result += spacer()
            result += _format(item)
        }

        return result
    }

    // MARK: Private Instance Methods

    private func _format(_ item: MXLListen.Item) -> String {
        switch item {
        case let .assess(assess):
            var result = "Assess "

            result += assess.shouldAssess ? "yes" : "no"

            if let player = assess.player {
                result += spacer()
                result += "Player "
                result += format(player)
            }

            return result

        case .otherListen:
            return "Other listen"

        case .wait:
            return "Wait"
        }
    }

    private func _format(_ item: MXLPlay.Item) -> String {
        switch item {
        case let .ipa(text):
            "IPA " + format(text)

        case .mute:
            "Mute"

        case .otherPlay:
            "Other play"

        case .semiPitched:
            "Semi-pitched"
        }
    }

    private func _format(_ kind: MXLSync.Kind) -> String {
        switch kind {
        case .alwaysEvent:
            "Always event"

        case .event:
            "Event"

        case .mostlyEvent:
            "Mostly event"

        case .mostlyTempo:
            "Mostly tempo"

        case .tempo:
            "Tempo"

        case .unsynchronized:
            "Unsynchronized"
        }
    }
}
