// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import Foundation
internal import IvorJohnnySonic
internal import XestiTools

internal struct DKMDumper: Dumper {

    // MARK: Internal Initializers

    internal init(_ stdio: StandardIO) {
        self.stdio = stdio
    }

    // MARK: Internal Instance Properties

    internal let stdio: StandardIO
}

// MARK: -

extension DKMDumper {

    // MARK: Internal Instance Methods

    internal func dump(_ fileURL: URL) throws {
        var banner = "Dump of JohnnySonic Score File "

        banner += format(fileURL.path)

        emit()
        emit(banner)

        let (score, diagnostics) = try DKMParser().parse(readFile(fileURL))

        _dump(2, score)
        _dump(2, diagnostics)

        emit()
    }

    internal func format(_ buffer: DKMFBABuffer) -> String {
        switch buffer {
        case .mix:
            "Mix"

        case .sound:
            "Sound"
        }
    }

    internal func format(_ channel: DKMChannel) -> String {
        switch channel {
        case .both:
            "Both"

        case .left:
            "Left"

        case .right:
            "Right"
        }
    }

    internal func format(_ channel: DKMClipChannel) -> String {
        switch channel {
        case .left:
            "Left"

        case .right:
            "Right"
        }
    }

    internal func format(_ channel: DKMFBAChannel) -> String {
        switch channel {
        case .combined:
            "Combined"

        case .left:
            "Left"

        case .right:
            "Right"
        }
    }

    internal func format(_ direction: DKMReverbDirection) -> String {
        switch direction {
        case .backward:
            "Backward"

        case .forward:
            "Forward"
        }
    }

    internal func format(_ filterType: DKMFilterType) -> String {
        switch filterType {
        case .allPoleBandpassPowerPreserving:
            "All-pole bandpass (power-preserving)"

        case .allPoleBandpassZeroDBGain:
            "All-pole bandpass (0 dB gain)"

        case .butterworthBandpass:
            "Butterworth bandpass"

        case .butterworthHighpass:
            "Butterworth highpass"

        case .butterworthLowpass:
            "Butterworth lowpass"

        case .butterworthNotch:
            "Butterworth notch"

        case .firHighpass:
            "FIR highpass"

        case .firLowpass:
            "FIR lowpass"

        case .firNotch:
            "FIR notch"
        }
    }

    internal func format(_ level: DKMScreenLevel) -> String {
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

    internal func format(_ size: DKMReverbSize) -> String {
        switch size {
        case .large:
            "Large"

        case .medium:
            "Medium"

        case .small:
            "Small"
        }
    }

    // MARK: Private Instance Methods

    private func _dump(_ indent: Int,
                       _ command: DKMCommand) {
        emit(indent, format(command))
    }

    private func _dump(_ indent: Int,
                       _ diagnostics: [DKMParser.Diagnostic]) {
        guard !diagnostics.isEmpty
        else { return }

        var header = "Diagnostics"

        header += spacer()
        header += format(diagnostics.count, "diagnostic")

        emit()
        emit(indent, header)
        emit()

        for (index, diagnostic) in diagnostics.enumerated() {
            var line = "Diagnostic #"

            line += format(index + 1)
            line += spacer()
            line += diagnostic.message

            emit(indent + 2, line)
        }
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
}
