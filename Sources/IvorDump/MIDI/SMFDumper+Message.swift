// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorMIDI

private import XestiTools

extension SMFDumper {

    // MARK: Internal Instance Methods

    internal func format(_ channel: MIDIChannel) -> String {
        format(channel.uintValue)
    }

    internal func format(_ message: MIDIChannelMessage) -> String {
        var result = format(message.channel)

        result += spacer()

        switch message {
        case let .channelPressure(_, value):
            result += "Channel pressure"
            result += spacer()
            result += format(value)

        case let .controlChange(_, controller, value):
            result += _format(controller)
            result += spacer()
            result += format(value)

        case let .noteOff(_, key, velocity):
            result += "Note off"
            result += spacer()
            result += format(key)
            result += spacer()
            result += format(velocity)

        case let .noteOn(_, key, velocity):
            result += "Note on"
            result += spacer()
            result += format(key)
            result += spacer()
            result += format(velocity)

            if velocity == 0 {
                result += " (= off)"
            }

        case let .pitchBendChange(_, change):
            result += "Pitch bend change"
            result += spacer()
            result += _format(change)

        case let .polyphonicPressure(_, key, value):
            result += "Polyphonic pressure"
            result += spacer()
            result += format(key)
            result += spacer()
            result += format(value)

        case let .programChange(_, program):
            result += "Program change"
            result += spacer()
            result += format(program)
        }

        return result
    }

    internal func format(_ message: SMFSysExMessage) -> (String, [UInt8]) {
        var result = ""

        switch message {
        case let .escape(bytes):
            result += "Escape"
            result += spacer()
            result += format(bytes.count, "byte")

            return (result, bytes)

        case let .systemExclusive(bytes):
            result += "System exclusive"
            result += spacer()
            result += format(bytes.count, "byte")

            return (result, bytes)
        }
    }

    internal func format(_ value: MIDIData1Value) -> String {
        format(value.uintValue)
    }

    internal func format(_ value: SMFData2Value) -> String {
        format(value.uintValue)
    }

    // MARK: Private Type Properties

    private static let controllerNames: [UInt: String] = [0: "Bank select MSB",
                                                          1: "Modulation wheel MSB",
                                                          2: "Breath controller MSB",

                                                          4: "Foot controller MSB",
                                                          5: "Portamento time MSB",
                                                          6: "Data entry MSB",
                                                          7: "Channel volume MSB",
                                                          8: "Balance MSB",

                                                          10: "Pan MSB",
                                                          11: "Expression controller MSB",
                                                          12: "Effect control 1 MSB",
                                                          13: "Effect control 2 MSB",

                                                          16: "General purpose controller 1 MSB",
                                                          17: "General purpose controller 2 MSB",
                                                          18: "General purpose controller 3 MSB",
                                                          19: "General purpose controller 4 MSB",

                                                          32: "Bank select LSB",
                                                          33: "Modulation wheel LSB",
                                                          34: "Breath controller LSB",

                                                          36: "Foot controller LSB",
                                                          37: "Portamento time LSB",
                                                          38: "Data entry LSB",
                                                          39: "Channel volume LSB",
                                                          40: "Balance LSB",

                                                          42: "Pan LSB",
                                                          43: "Expression controller LSB",
                                                          44: "Effect control 1 LSB",
                                                          45: "Effect control 2 2LSB",

                                                          48: "General purpose controller 1 LSB",
                                                          49: "General purpose controller 2 LSB",
                                                          50: "General purpose controller 3 LSB",
                                                          51: "General purpose controller 4 LSB",

                                                          64: "Sustain",
                                                          65: "Portamento",
                                                          66: "Sostenuto",
                                                          67: "SoftPedal",
                                                          68: "Legato",
                                                          69: "Hold 2",
                                                          70: "Sound variation",
                                                          71: "Harmonic content",
                                                          72: "Release time",
                                                          73: "Attack time",
                                                          74: "Brightness",
                                                          75: "Decay time",
                                                          76: "Vibrato rate",
                                                          77: "Vibrato depth",
                                                          78: "Vibrato delay",

                                                          80: "General purpose controller 5",
                                                          81: "General purpose controller 6",
                                                          82: "General purpose controller 7",
                                                          83: "General purpose controller 8",
                                                          84: "Portamento control",

                                                          88: "High resolution velocity prefix",

                                                          91: "Reverb send level",
                                                          92: "Tremelo depth",
                                                          93: "Chorus send level",
                                                          94: "Celeste depth",
                                                          95: "Phaser depth",
                                                          96: "Data increment",
                                                          97: "Data decrement",
                                                          98: "Non-registered parameter number LSB",
                                                          99: "Non-registered parameter number MSB",
                                                          100: "Registered parameter number LSB",
                                                          101: "Registered parameter number MSB",

                                                          120: "All sound off",
                                                          121: "Reset all controllers",
                                                          122: "Local control",
                                                          123: "All notes off",
                                                          124: "Omni mode off",
                                                          125: "Omni mode on",
                                                          126: "Mono mode on",
                                                          127: "Poly mode on"]

    // MARK: Private Instance Methods

    private func _format(_ controller: MIDIController) -> String {
        if let name = Self.controllerNames[controller.uintValue] {
            return name
        }

        var result = "Control change"

        result += spacer()
        result += format(controller.uintValue)

        return result
    }

    private func _format(_ pitchBend: MIDIPitchBend) -> String {
        format(pitchBend.intValue)
    }
}
