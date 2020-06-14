//
//  Micrologger.swift
//  DemoApp
//
//  Created by Raluca Mesterca on 14/06/2020.
//  Copyright © 2020 Fig. All rights reserved.
//

typealias Micro = MicroLogger

// NOTE: - it makes showing events in the console cleaner and more visible
enum MicroLogger {

    static func log(_ message: String) {
        print("""

            📩 ===========================
            \(message)
            📩 ===========================

            """)
    }

    static func logSuccess(_ message: String) {
        print("""

            🎉 ===========================
            \(message)
            🎉 ===========================

            """)
    }

    static func logWarning(_ warning: String) {
        print("""

            ⚠️ ===========================
            \(warning)
            ⚠️ ===========================

            """)
    }

    static func logError(_ error: String) {
        print("""

            🔴❗️ ===========================
            \(error)
            🔴❗️ ===========================

            """)
    }
}
