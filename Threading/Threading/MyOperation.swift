//
//  MyOperation.swift
//  Threading
//
//  Created by kooapps on 4/18/21.
//

import UIKit

class MyOperation: Operation {
    private var range: ClosedRange<Int>

    init(_ range: ClosedRange<Int>) {
        self.range = range
    }
    
    override func main() {
        Array(range).forEach {
            (i) in
            print(i)
            Thread.sleep(forTimeInterval: TimeInterval.random(in: 0.0...0.5))
        }
    }
}
