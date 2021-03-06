import ArgumentParser
import Foundation

struct Pixelmatch: ParsableCommand {
  @Argument() var image1: String
  @Argument() var image2: String
  @Argument() var diff: String
  @Argument() var threshold: String = "0.1"
  @Argument() var includeAA: String = "false"

  func run() {
    let task = Process()
    task.executableURL = Bundle.module.url(forResource: "pixelmatch", withExtension: "")!
    task.arguments = [image1, image2, diff, threshold, includeAA]

    let outputPipe = Pipe()
    let errorPipe = Pipe()
    task.standardOutput = outputPipe
    task.standardError = errorPipe

    task.launch()
    task.waitUntilExit()

    let output = String(
      decoding: outputPipe.fileHandleForReading.readDataToEndOfFile(),
      as: UTF8.self
    )
    let error = String(
      decoding: errorPipe.fileHandleForReading.readDataToEndOfFile(),
      as: UTF8.self
    )
    if(output != "") {
      print(chomp(output))
    }
    if(error != "") {
      print(chomp(error))
    }
  }

  func chomp(_ str: String) -> String {
    if str.hasSuffix("\n") {
      return String(str.dropLast())
    } else {
      return str
    }
  }
}

Pixelmatch.main()
