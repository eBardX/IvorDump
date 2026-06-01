// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import Foundation

private import IvorJohnnySonic

extension IvorDumper {

    // MARK: Internal Instance Methods

    internal func dumpJohnnySonic(_ fileURL: URL) throws {
        var banner = "Dump of JohnnySonic Score File "

        banner += format(fileURL.path)

        emit()
        emit(banner)

        let score = try DKMParser().parse(readFile(fileURL))

        _dump(2, score)

        emit()
    }

    // MARK: Private Instance Methods

    private func _dump(_ indent: Int,
                       _ command: DKMCommand) {
        emit(indent, _format(command))
    }

    private func _dump(_ indent: Int,
                       _ score: DKMScore) {
        let commands = score.commands

        var header = "Score"

        header += spacer()
        header += format(commands.count, "command")

        emit()
        emit(indent, header)

        if !commands.isEmpty {
            emit()

            for command in commands {
                _dump(indent + 2, command)
            }
        }
    }

    private func _format(_ channel: DKMChannel) -> String {
        switch channel {
        case .both:
            "Both"

        case .left:
            "Left"

        case .right:
            "Right"
        }
    }

    private func _format(_ channel: DKMClipChannel) -> String {
        switch channel {
        case .left:
            "Left"

        case .right:
            "Right"
        }
    }

    private func _format(_ buffer: DKMFBABuffer) -> String {
        switch buffer {
        case .mix:
            "Mix"

        case .sound:
            "Sound"
        }
    }

    private func _format(_ channel: DKMFBAChannel) -> String {
        switch channel {
        case .combined:
            "Combined"

        case .left:
            "Left"

        case .right:
            "Right"
        }
    }

    private func _format(_ filterType: DKMFilterType) -> String {
        switch filterType {
        case .allPoleBandpassZeroDBGain:
            "All-pole bandpass (0 dB gain)"

        case .allPoleBandpassPowerPreserving:
            "All-pole bandpass (power-preserving)"

        case .butterworthLowpass:
            "Butterworth lowpass"

        case .butterworthHighpass:
            "Butterworth highpass"

        case .butterworthBandpass:
            "Butterworth bandpass"

        case .butterworthNotch:
            "Butterworth notch"

        case .firLowpass:
            "FIR lowpass"

        case .firHighpass:
            "FIR highpass"

        case .firNotch:
            "FIR notch"
        }
    }

    private func _format(_ direction: DKMReverbDirection) -> String {
        switch direction {
        case .backward:
            "Backward"

        case .forward:
            "Forward"
        }
    }

    private func _format(_ size: DKMReverbSize) -> String {
        switch size {
        case .large:
            "Large"

        case .medium:
            "Medium"

        case .small:
            "Small"
        }
    }

    private func _format(_ level: DKMScreenLevel) -> String {
        switch level {
        case .debug:
            "Debug"

        case .medium:
            "Medium"

        case .quiet:
            "Quiet"

        case .verbose:
            "Verbose"
        }
    }

    private func _format(_ command: DKMCommand) -> String { // swiftlint:disable:this function_body_length
        switch command {
        case let .comment(text):
            var result = "Comment"

            if !text.isEmpty {
                result += spacer()
                result += format(text)
            }

            return result

            // MARK: /Chorus

        case let .chorusLine(startBeat, duration, numberOfVoices, depth, flipChannels):
            var result = "Chorus"

            result += spacer() + format(startBeat)
            result += spacer() + format(duration)
            result += spacer() + format(numberOfVoices)
            result += spacer() + format(depth)
            result += spacer() + (flipChannels ? "flip" : "no flip")

            return result

            // MARK: /Clip

        case let .clipMode(channel, name):
            var result = "Clip mode"

            result += spacer() + _format(channel)
            result += spacer() + format(name)

            return result

        case let .clipNote(startBeat, duration, volume, location, clipStart, clipRate, instrument):
            var result = "Clip note"

            result += spacer() + format(startBeat)
            result += spacer() + format(duration)
            result += spacer() + format(volume)
            result += spacer() + format(location)
            result += spacer() + format(clipStart)
            result += spacer() + format(clipRate)
            result += spacer() + format(instrument)

            return result

            // MARK: /Compress

        case let .compressLine(startBeat, duration, maxRatio):
            var result = "Compress"

            result += spacer() + format(startBeat)
            result += spacer() + format(duration)
            result += spacer() + format(maxRatio)

            return result

            // MARK: /End

        case .end:
            return "End"

            // MARK: /Exclude

        case .exclude:
            return "Exclude"

            // MARK: /FBA

        case let .freqBandAnalyzeLine(startBeat, duration, channel, buffer):
            var result = "Frequency band analyze"

            result += spacer() + format(startBeat)
            result += spacer() + format(duration)
            result += spacer() + _format(channel)
            result += spacer() + _format(buffer)

            return result

            // MARK: /Filter

        case let .filterLine(startBeat, duration, filterType, initialPitch, finalPitch, initialBandwidth, finalBandwidth):
            var result = "Filter"

            result += spacer() + format(startBeat)
            result += spacer() + format(duration)
            result += spacer() + _format(filterType)
            result += spacer() + format(initialPitch)
            result += spacer() + format(finalPitch)
            result += spacer() + format(initialBandwidth)
            result += spacer() + format(finalBandwidth)

            return result

            // MARK: /Flange

        case let .flangeLine(startBeat, duration, numberOfVoices, depth, flipChannels):
            var result = "Flange"

            result += spacer() + format(startBeat)
            result += spacer() + format(duration)
            result += spacer() + format(numberOfVoices)
            result += spacer() + format(depth)
            result += spacer() + (flipChannels ? "flip" : "no flip")

            return result

            // MARK: /GEQ

        case let .geqLine(beat, bandGains):
            var result = "GEQ"

            result += spacer() + format(beat)

            for gain in bandGains {
                result += spacer() + format(gain)
            }

            return result

            // MARK: /Haas

        case let .haas(enabled, minDelay, maxDelay, reverbSend):
            var result = "Haas"

            result += spacer() + (enabled ? "enabled" : "disabled")
            result += spacer() + format(minDelay)
            result += spacer() + format(maxDelay)
            result += spacer() + (reverbSend ? "reverb" : "no reverb")

            return result

            // MARK: /Include

        case let .include(fileName):
            var result = "Include"

            result += spacer() + format(fileName)

            return result

            // MARK: /Levels

        case let .levelsLine(startBeat, duration, startGainLossdB, endGainLossdB):
            var result = "Levels"

            result += spacer() + format(startBeat)
            result += spacer() + format(duration)
            result += spacer() + format(startGainLossdB)
            result += spacer() + format(endGainLossdB)

            return result

            // MARK: /Mix

        case let .mixLine(startBeat, duration, gainLossdB, keepSoundBuffer, sign, timeOffset):
            var result = "Mix"

            result += spacer() + format(startBeat)
            result += spacer() + format(duration)
            result += spacer() + format(gainLossdB)
            result += spacer() + (keepSoundBuffer ? "keep" : "clear")
            result += spacer() + format(sign)
            result += spacer() + format(timeOffset)

            return result

            // MARK: /Pitches

        case let .pitchesNote(startBeat, duration, volume, location, startPitch, endPitch, instrument):
            var result = "Pitches note"

            result += spacer() + format(startBeat)
            result += spacer() + format(duration)
            result += spacer() + format(volume)
            result += spacer() + format(location)
            result += spacer() + format(startPitch)
            result += spacer() + format(endPitch)
            result += spacer() + format(instrument)

            return result

            // MARK: /Pulse

        case let .pulseLine(startBeat, channel):
            var result = "Pulse"

            result += spacer() + format(startBeat)
            result += spacer() + _format(channel)

            return result

            // MARK: /Reverb

        case let .reverbLine(startBeat, duration, direction, size, reverbTime, combFilterDryGain, xTalkFactor, wetness):
            var result = "Reverb"

            result += spacer() + format(startBeat)
            result += spacer() + format(duration)
            result += spacer() + _format(direction)
            result += spacer() + _format(size)
            result += spacer() + format(reverbTime)
            result += spacer() + format(combFilterDryGain)
            result += spacer() + format(xTalkFactor)
            result += spacer() + format(wetness)

            return result

            // MARK: /ScreenOut

        case let .screenOut(level):
            var result = "Screen out"

            result += spacer() + _format(level)

            return result

            // MARK: /SendBack

        case let .sendBackLine(startBeat, duration, gainLossdB):
            var result = "Send back"

            result += spacer() + format(startBeat)
            result += spacer() + format(duration)
            result += spacer() + format(gainLossdB)

            return result

            // MARK: /SFN

        case let .soundFileName(name):
            var result = "Sound file name"

            result += spacer() + format(name)

            return result

            // MARK: /ShowBuffer

        case let .showBufferLine(startBeat, duration):
            var result = "Show buffer"

            result += spacer() + format(startBeat)
            result += spacer() + format(duration)

            return result

            // MARK: /Stats

        case let .statsLine(startBeat, duration):
            var result = "Stats"

            result += spacer() + format(startBeat)
            result += spacer() + format(duration)

            return result

            // MARK: /Tempo

        case let .tempoLine(startBeat, duration, initialTempo, finalTempo):
            var result = "Tempo"

            result += spacer() + format(startBeat)
            result += spacer() + format(duration)
            result += spacer() + format(initialTempo)
            result += spacer() + format(finalTempo)

            return result

            // MARK: /Tuning

        case let .tuning(primaryInterval, notesPerInterval, pitchConvExponent, pitchConvFactor):
            var result = "Tuning"

            result += spacer() + format(primaryInterval)
            result += spacer() + format(notesPerInterval)
            result += spacer() + format(pitchConvExponent)
            result += spacer() + format(pitchConvFactor)

            return result

            // MARK: /Vocode

        case let .vocodeMode(channel, name, clipRate, maxHarm, slope, bassBoost, dynExponent, shiftN, peakReduction):
            var result = "Vocode mode"

            result += spacer() + _format(channel)
            result += spacer() + format(name)
            result += spacer() + format(clipRate)
            result += spacer() + format(maxHarm)
            result += spacer() + format(slope)
            result += spacer() + format(bassBoost)
            result += spacer() + format(dynExponent)
            result += spacer() + format(shiftN)
            result += spacer() + format(peakReduction)

            return result

        case let .vocodeNote(startBeat, duration, volume, location, pitch, clipStart, instrument):
            var result = "Vocode note"

            result += spacer() + format(startBeat)
            result += spacer() + format(duration)
            result += spacer() + format(volume)
            result += spacer() + format(location)
            result += spacer() + format(pitch)
            result += spacer() + format(clipStart)
            result += spacer() + format(instrument)

            return result
        }
    }
}
