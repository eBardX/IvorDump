// © 2025–2026 John Gary Pusey (see LICENSE.md)

internal import Foundation
internal import XestiTools

internal let args = Array(CommandLine.arguments.dropFirst())

guard !args.isEmpty
else { StandardIO().writeError("Usage: ivordump <file-path>…"); exit(1) }

internal let dumper = IvorDumper()

internal var succeeded = true

for arg in args {
    succeeded = try dumper.dump(URL(fileURLWithPath: arg).absoluteURL) && succeeded
}

exit(succeeded ? EXIT_SUCCESS : EXIT_FAILURE)
