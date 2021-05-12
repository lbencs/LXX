//
//  AppDelegate.swift
//  LXX
//
//  Created by lben on 2021/1/19.
//

import SQLite3
import UIKit

func example(of message: String, _ exec: () -> Void) {
    print("\n\n\(message)")
    exec()
}

// @main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // TODO: #lben -  手写一个sqlite数据库使用教程
//        var stmp = sqlite3_stmt_readonly(<#T##pStmt: OpaquePointer!##OpaquePointer!#>)

        // Override point for customization after application launch.
//        let lock = NSRecursiveLock()
//        lock.lock()
//        lock.lock()
//        print("hello lock")
//        lock.unlock()
//        lock.unlock()
//        GCD.test()
//        gcdtest()
//        testAsyncAfter()
//        gcd_timer_test()
//        gcd_dispatch_io_test()
//        gcd_perform_test()
//        test_arithmetic_test()
//        test_runloop_timer()
        test_copy()
//        Test.test()
        return true
    }

    func applicationDidFinishLaunching(_ application: UIApplication) {
        print(#function)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        print(#function)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print(#function)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print(#function)
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print(#function)
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print(#function)
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

class DownloadAccelerateService {
    func trailAble(task: Any) -> Bool {
        /**
         ○资源可以秒下
         ○文件大小>=200M
         ○下载进度<50%
         ○当日加速试用次数未用完(服务端控制每日3次)
         ○下载列表当前没有展示加速试用下挂条(下载列表仅同时展示一个加速试用下挂条)
         */
        return true
    }
}

class DownloadAccelerateDownHanger: UIView {
}
