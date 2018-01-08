//
//  Functions.swift
//  iBooks
//
//  Created by Chase Choi on 08/01/2018.
//  Copyright © 2018 Chase Choi. All rights reserved.
//

import Foundation
import Dispatch

func afterDelay(_ seconds: Double, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: closure)
}
