import Foundation

/// Calls a shell command and returns its exit code.
public func call(command: String) -> Int {
    let task = NSTask()
    task.launchPath = "/usr/bin/env"
    task.arguments = split(command) { $0 == " " }

    let pipe = NSPipe()
    task.standardOutput = pipe
    task.launch()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    if let output = NSString(data: data, encoding: NSUTF8StringEncoding) as? String {
        print(output)
    }

    task.waitUntilExit()
    return Int(task.terminationStatus)
}
