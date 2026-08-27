// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import IvorJohnnySonic

extension DKMDumper {

    // MARK: Internal Instance Methods

    internal func format(_ command: DKMCommand) -> String { // swiftlint:disable:this function_body_length
        switch command {
        case let .chorusLine(line):
            var result = "Chorus"

            result += spacer() + format(line.startBeat)
            result += spacer() + format(line.duration)
            result += spacer() + format(line.numberOfVoices)
            result += spacer() + format(line.depth)
            result += spacer() + (line.flipChannels ? "flip" : "no flip")

            return result

        case let .clipMode(mode):
            var result = "Clip mode"

            result += spacer() + format(mode.channel)
            result += spacer() + format(mode.name)

            return result

        case let .clipNote(note):
            var result = "Clip note"

            result += spacer() + format(note.startBeat)
            result += spacer() + format(note.duration)
            result += spacer() + format(note.volume)
            result += spacer() + format(note.location)
            result += spacer() + format(note.clipStart)
            result += spacer() + format(note.clipRate)
            result += spacer() + format(note.instrument)

            return result

        case let .comment(text):
            var result = "Comment"

            if !text.isEmpty {
                result += spacer()
                result += format(text)
            }

            return result

        case let .compressLine(line):
            var result = "Compress"

            result += spacer() + format(line.startBeat)
            result += spacer() + format(line.duration)
            result += spacer() + format(line.maxRatio)

            return result

        case .dynamics:
            return "Dynamics"

        case .end:
            return "End"

        case .exclude:
            return "Exclude"

        case let .filterLine(line):
            var result = "Filter"

            result += spacer() + format(line.startBeat)
            result += spacer() + format(line.duration)
            result += spacer() + format(line.filterType)
            result += spacer() + format(line.initialPitch)
            result += spacer() + format(line.finalPitch)
            result += spacer() + format(line.initialBandwidth)
            result += spacer() + format(line.finalBandwidth)

            return result

        case let .flangeLine(line):
            var result = "Flange"

            result += spacer() + format(line.startBeat)
            result += spacer() + format(line.duration)
            result += spacer() + format(line.numberOfVoices)
            result += spacer() + format(line.depth)
            result += spacer() + (line.flipChannels ? "flip" : "no flip")

            return result

        case let .freqBandAnalyzeLine(line):
            var result = "Frequency band analyze"

            result += spacer() + format(line.startBeat)
            result += spacer() + format(line.duration)
            result += spacer() + format(line.channel)
            result += spacer() + format(line.buffer)

            return result

        case let .geqLine(line):
            var result = "GEQ"

            result += spacer() + format(line.beat)

            for gain in line.bandGains {
                result += spacer() + format(gain)
            }

            return result

        case let .haas(haas):
            var result = "Haas"

            result += spacer() + (haas.enabled ? "enabled" : "disabled")
            result += spacer() + format(haas.minDelay)
            result += spacer() + format(haas.maxDelay)
            result += spacer() + (haas.reverbSend ? "reverb" : "no reverb")

            return result

        case let .include(fileName):
            var result = "Include"

            result += spacer() + format(fileName)

            return result

        case let .levelsLine(line):
            var result = "Levels"

            result += spacer() + format(line.startBeat)
            result += spacer() + format(line.duration)
            result += spacer() + format(line.startGainLossdB)
            result += spacer() + format(line.endGainLossdB)

            return result

        case let .mixLine(line):
            var result = "Mix"

            result += spacer() + format(line.startBeat)
            result += spacer() + format(line.duration)
            result += spacer() + format(line.gainLossdB)
            result += spacer() + (line.keepSoundBuffer ? "keep" : "clear")
            result += spacer() + format(line.sign)
            result += spacer() + format(line.timeOffset)

            return result

        case let .pitchesNote(note):
            var result = "Pitches note"

            result += spacer() + format(note.startBeat)
            result += spacer() + format(note.duration)
            result += spacer() + format(note.volume)
            result += spacer() + format(note.location)
            result += spacer() + format(note.startPitch)
            result += spacer() + format(note.endPitch)
            result += spacer() + format(note.instrument)

            return result

        case let .pulseLine(line):
            var result = "Pulse"

            result += spacer() + format(line.startBeat)
            result += spacer() + format(line.channel)

            return result

        case let .reverbLine(line):
            var result = "Reverb"

            result += spacer() + format(line.startBeat)
            result += spacer() + format(line.duration)
            result += spacer() + format(line.direction)
            result += spacer() + format(line.size)
            result += spacer() + format(line.reverbTime)
            result += spacer() + format(line.combFilterDryGain)
            result += spacer() + format(line.xTalkFactor)
            result += spacer() + format(line.wetness)

            return result

        case let .screenOut(level):
            var result = "Screen out"

            result += spacer() + format(level)

            return result

        case let .sendBackLine(line):
            var result = "Send back"

            result += spacer() + format(line.startBeat)
            result += spacer() + format(line.duration)
            result += spacer() + format(line.gainLossdB)

            return result

        case let .showBufferLine(line):
            var result = "Show buffer"

            result += spacer() + format(line.startBeat)
            result += spacer() + format(line.duration)

            return result

        case let .soundFileName(name):
            var result = "Sound file name"

            result += spacer() + format(name)

            return result

        case let .statsLine(line):
            var result = "Stats"

            result += spacer() + format(line.startBeat)
            result += spacer() + format(line.duration)

            return result

        case let .tempoLine(line):
            var result = "Tempo"

            result += spacer() + format(line.startBeat)
            result += spacer() + format(line.duration)
            result += spacer() + format(line.initialTempo)
            result += spacer() + format(line.finalTempo)

            return result

        case let .tuning(tuning):
            var result = "Tuning"

            result += spacer() + format(tuning.primaryInterval)
            result += spacer() + format(tuning.notesPerInterval)
            result += spacer() + format(tuning.pitchConvExponent)
            result += spacer() + format(tuning.pitchConvFactor)

            return result

        case let .vocodeMode(mode):
            var result = "Vocode mode"

            result += spacer() + format(mode.channel)
            result += spacer() + format(mode.name)
            result += spacer() + format(mode.clipRate)
            result += spacer() + format(mode.maxHarm)
            result += spacer() + format(mode.slope)
            result += spacer() + format(mode.bassBoost)
            result += spacer() + format(mode.dynExponent)
            result += spacer() + format(mode.shiftN)
            result += spacer() + format(mode.peakReduction)

            return result

        case let .vocodeNote(note):
            var result = "Vocode note"

            result += spacer() + format(note.startBeat)
            result += spacer() + format(note.duration)
            result += spacer() + format(note.volume)
            result += spacer() + format(note.location)
            result += spacer() + format(note.pitch)
            result += spacer() + format(note.clipStart)
            result += spacer() + format(note.instrument)

            return result
        }
    }
}
