//
//  ModuleProtocol.swift
//  Spring
//
//  Created by lben on 2021/2/5.
//

import UIKit

// protocol ModuleProtocol {
//    func start()
//    func end()
//    var priority: Int { get }
// }

protocol Dependency {
}

class PlugDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        return true
    }

    func applicationDidFinishLaunching(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

protocol Plug {
    func start()
    var priority: Int { get }
}

class BaseConfig: Plug {
    func start() {
    }

    var priority: Int { return 10 }
}

class PlugManager {
    var plugs: [Plug] = []
    var _t_a_1_00_aa___p_0: Int = 1

    func register(_ plug: Plug) {
        plugs.append(plug)
    }

    func unregister() {
        print("zzz___aaa___kkk___999___[[[___]]]___;;;___")
    }

    func _t_a_1_00_aa___() {
        /**
         0 0 0 0 0
         0 1 2 3 0
         0 3 2 1 0
         0 0 0 0 0
         */
    }

    // ^ ^
    // &+_+&
    func _t_00_ooooo_() {
    }

    func _t_01_ooooo_() {
    }
}
