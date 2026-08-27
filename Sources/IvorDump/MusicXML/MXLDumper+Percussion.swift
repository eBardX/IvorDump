// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMusicXML

extension MXLDumper {

    // MARK: Internal Instance Methods

    internal func format(_ content: MXLPercussion.Content) -> String {
        switch content {
        case let .beater(beater):
            var result = "Beater "

            result += format(beater.value)

            if let tip = beater.tip {
                result += spacer()
                result += "Tip "
                result += _format(tip)
            }

            return result

        case let .effect(effect):
            return _percussionValue("Effect", format(effect.value), effect.smufl)

        case let .glass(glass):
            return _percussionValue("Glass", _format(glass.value), glass.smufl)

        case let .membrane(membrane):
            return _percussionValue("Membrane", format(membrane.value), membrane.smufl)

        case let .metal(metal):
            return _percussionValue("Metal", format(metal.value), metal.smufl)

        case let .otherPercussion(other):
            return "Other " + format(other.value)

        case let .pitched(pitched):
            return _percussionValue("Pitched", format(pitched.value), pitched.smufl)

        case let .stick(stick):
            return _format(stick)

        case let .stickLocation(location):
            return "Stick location " + _format(location)

        case let .timpani(timpani):
            var result = "Timpani"

            if let smufl = timpani.smufl {
                result += spacer()
                result += format(smufl.stringValue)
            }

            return result

        case let .wood(wood):
            return _percussionValue("Wood", format(wood.value), wood.smufl)
        }
    }

    // MARK: Private Instance Methods

    private func _format(_ stick: MXLStick) -> String {
        var result = "Stick "

        result += _format(stick.kind)
        result += spacer()
        result += _format(stick.material)

        if let tip = stick.tip {
            result += spacer()
            result += "Tip "
            result += _format(tip)
        }

        if stick.hasDashedCircle {
            result += spacer()
            result += "Dashed circle"
        }

        if stick.hasParentheses {
            result += spacer()
            result += "Parenthesized"
        }

        return result
    }

    private func _format(_ value: MXLGlass.Value) -> String {
        switch value {
        case .glassHarmonica:
            "Glass harmonica"

        case .glassHarp:
            "Glass harp"

        case .windChimes:
            "Wind chimes"
        }
    }

    private func _format(_ value: MXLStick.Kind) -> String {
        switch value {
        case .bassDrum:
            "Bass drum"

        case .doubleBassDrum:
            "Double bass drum"

        case .glockenspiel:
            "Glockenspiel"

        case .gum:
            "Gum"

        case .hammer:
            "Hammer"

        case .superball:
            "Superball"

        case .timpani:
            "Timpani"

        case .wound:
            "Wound"

        case .xylophone:
            "Xylophone"

        case .yarn:
            "Yarn"
        }
    }

    private func _format(_ value: MXLStick.Material) -> String {
        switch value {
        case .hard:
            "Hard"

        case .medium:
            "Medium"

        case .shaded:
            "Shaded"

        case .soft:
            "Soft"

        case .x:
            "X"
        }
    }

    private func _format(_ value: MXLStickLocation) -> String {
        switch value {
        case .center:
            "Center"

        case .cymbalBell:
            "Cymbal bell"

        case .cymbalEdge:
            "Cymbal edge"

        case .rim:
            "Rim"
        }
    }

    private func _format(_ value: MXLTipDirection) -> String {
        switch value {
        case .down:
            "Down"

        case .left:
            "Left"

        case .northeast:
            "Northeast"

        case .northwest:
            "Northwest"

        case .right:
            "Right"

        case .southeast:
            "Southeast"

        case .southwest:
            "Southwest"

        case .up:
            "Up"
        }
    }

    private func _percussionValue(_ label: String,
                                  _ value: String,
                                  _ smufl: MXLSmuflPictogramGlyphName?) -> String {
        var line = label + " " + value

        if let smufl {
            line += spacer()
            line += format(smufl.stringValue)
        }

        return line
    }
}
