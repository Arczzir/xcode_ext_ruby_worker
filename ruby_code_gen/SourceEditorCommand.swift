//
//  SourceEditorCommand.swift
//  codegen
//
//  Created by Z on 2/17/17.
//  Copyright © 2017 Z. All rights reserved.
//
import Foundation
import XcodeKit

public extension Int {
    func index(of string: String) -> String.Index {
        return string.index(string.startIndex, offsetBy: self)
    }
}

class SourceEditorCommand: NSObject, XCSourceEditorCommand {
    
    func perform(with invocation: XCSourceEditorCommandInvocation, completionHandler: @escaping (Error?) -> Void ) -> Void {
        // Implement your command here, invoking the completion handler when done. Pass it nil on success, and an NSError on failure.
        
        let url = rbDirectory().appendingPathComponent(invocation.commandIdentifier)
        if let b = try? url.checkResourceIsReachable(), b {
            var s = selection(invocation)
            let result = run(cmd: "/usr/bin/ruby", args: [url.path, s])
            s = result ?? "93092xxxxxxx"
            invocation.buffer.lines.add(s)
        }
        
        completionHandler(nil)
    }
    
    func selection(_ invocation: XCSourceEditorCommandInvocation) -> String {
        var s = ""

        for selection in invocation.buffer.selections as! [XCSourceTextRange] {
            let lineRange = selection.start.line...selection.end.line
            
            for i in lineRange {
                let line = invocation.buffer.lines[i] as! String
                if i == lineRange.first {
                    s += line.substring(from: selection.start.column.index(of: line))
                } else if i == lineRange.last {
                    s += line.substring(to: selection.end.column.index(of: line))
                } else {
                    s += line
                }
                
            }
        }
        
        return s
    }
    
    
    func run(cmd: String, args: [String]) -> String? {
        do {
            var output: String?
            try Objc.catchException {
                let task = Process()
                
                task.launchPath = cmd
                task.arguments = args
                
                let pipe = Pipe()
                task.standardOutput = pipe
                task.launch()
                task.waitUntilExit()
                
                let data = pipe.fileHandleForReading.readDataToEndOfFile()
                output = String(data: data, encoding: .utf8)
                
            }
            return output
        
        } catch(let e) {
            print(e)
            return nil
        }
    }

}
