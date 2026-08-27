// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func format(_ bend: MXLBend) -> String {
        var result = "Bend"

        result += spacer()
        result += format(bend.alter)
        result += " semitone(s)"

        if let content = bend.content {
            result += spacer()

            switch content {
            case .preBend:
                result += "Pre-bend"

            case let .release(release):
                result += "Release"

                if let offset = release.offset {
                    result += " "
                    result += format(offset.intValue)
                }
            }
        }

        if let withBar = bend.withBar {
            result += spacer()
            result += "With bar "
            result += format(withBar.value)
        }

        if let shape = bend.shape {
            result += spacer()
            result += _format(shape)
        }

        append(&result, format(bend.sound))
        append(&result, format(bend.position))
        append(&result, format(bend.font))
        append(&result, bend.color.map { format($0) })

        return result
    }

    internal func format(_ handbell: MXLHandbell) -> String {
        var result = "Handbell"

        result += spacer()
        result += _format(handbell.value)

        appendPlacement(&result,
                        placement: handbell.placement,
                        position: handbell.position,
                        font: handbell.font,
                        color: handbell.color)

        return result
    }

    internal func format(_ harmonic: MXLHarmonic) -> String {
        var result = "Harmonic"

        if let content = harmonic.content {
            result += spacer()

            switch content {
            case .artificial:
                result += "Artificial"

            case .natural:
                result += "Natural"
            }
        }

        if let content2 = harmonic.content2 {
            result += spacer()

            switch content2 {
            case .basePitch:
                result += "Base pitch"

            case .soundingPitch:
                result += "Sounding pitch"

            case .touchingPitch:
                result += "Touching pitch"
            }
        }

        appendPlacement(&result,
                        placement: harmonic.placement,
                        position: harmonic.position,
                        font: harmonic.font,
                        color: harmonic.color)
        append(&result, harmonic.printsObject, "Printed", "Not printed")

        return result
    }

    internal func format(_ harmonMute: MXLHarmonMute) -> String {
        var result = "Harmon mute"

        result += spacer()
        result += "Closed "

        switch harmonMute.harmonClosed.value {
        case .half:
            result += "half"

        case .no:
            result += "no"

        case .yes:
            result += "yes"
        }

        appendPlacement(&result,
                        placement: harmonMute.placement,
                        position: harmonMute.position,
                        font: harmonMute.font,
                        color: harmonMute.color)

        return result
    }

    internal func format(_ hole: MXLHole) -> String {
        var result = "Hole"

        if let kind = hole.kind {
            result += spacer()
            result += format(kind)
        }

        result += spacer()
        result += "Closed "

        switch hole.closed.value {
        case .half:
            result += "half"

        case .no:
            result += "no"

        case .yes:
            result += "yes"
        }

        if !hole.shape.isEmpty {
            result += spacer()
            result += "Shape "
            result += format(hole.shape)
        }

        appendPlacement(&result,
                        placement: hole.placement,
                        position: hole.position,
                        font: hole.font,
                        color: hole.color)

        return result
    }

    internal func format(_ sound: MXLBendSound) -> String? {
        var parts: [String] = []

        if sound.accelerates == true {
            parts.append("Accelerates")
        }

        if let beats = sound.beats {
            parts.append(format(beats, precision: 0...2) + " beats")
        }

        if let firstBeat = sound.firstBeat {
            parts.append("First beat " + format(firstBeat) + "%")
        }

        if let lastBeat = sound.lastBeat {
            parts.append("Last beat " + format(lastBeat) + "%")
        }

        return parts.isEmpty ? nil : parts.joined(separator: spacer())
    }

    // MARK: Private Instance Methods

    private func _format(_ shape: MXLBend.Shape) -> String {
        switch shape {
        case .angled:
            "Angled"

        case .curved:
            "Curved"
        }
    }

    private func _format(_ value: MXLHandbell.Value) -> String {
        switch value {
        case .belltree:
            "Belltree"

        case .damp:
            "Damp"

        case .echo:
            "Echo"

        case .gyro:
            "Gyro"

        case .handMartellato:
            "Hand martellato"

        case .malletLift:
            "Mallet lift"

        case .malletTable:
            "Mallet table"

        case .martellato:
            "Martellato"

        case .martellatoLift:
            "Martellato lift"

        case .mutedMartellato:
            "Muted martellato"

        case .pluckLift:
            "Pluck lift"

        case .swing:
            "Swing"
        }
    }
}
