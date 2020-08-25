//
//  SameThreadExecuter.swift
//  BreakingBadTests
//
//  Created by Rowan Townshend on 25/08/2020.
//  Copyright © 2020 Keytree. All rights reserved.
//


import BreakingBad
import Foundation

struct SameThreadExecuter: ThreadExecutor {
    func async(group: DispatchGroup?, qos: DispatchQoS, flags: DispatchWorkItemFlags, execute work: @escaping @convention(block) () -> Void) {
        work()
    }
}
