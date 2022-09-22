//
//  Reachability.swift
//  TheJakartaPost
//
//  Created by Slamet Riyadi on 20/09/22.
//

import SystemConfiguration

// MARK: - Reachability Class
final class Reachability {

    // MARK: - Declearation of share Instance for Reachability class.
    private init () {}
    class var shared: Reachability {
        struct Static {
            static let instance = Reachability()
        }
        return Static.instance
    }
    
    // MARK: - Check internet availability status.
    var isConnectedToNetwork: Bool {
        guard let flags = getFlags() else { return false }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    // MARK: - Get SCNetworkReachabilityFlags for "Internet Protocol version 4 & 6" using getFlags private function.
    private func getFlags() -> SCNetworkReachabilityFlags? {
        guard let reachability = ipv4Reachability() ?? ipv6Reachability() else {
            return nil
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(reachability, &flags) {
            return nil
        }
        return flags
    }
    // MARK: - Check internet availability for "Internet Protocol version 6" using ipv6Reachability private function.
    private func ipv6Reachability() -> SCNetworkReachability? {
        var zeroAddress = sockaddr_in6()
        zeroAddress.sin6_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin6_family = sa_family_t(AF_INET6)

        return withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        })
    }
    // MARK: - Check internet availability for "Internet Protocol version 4" using ipv4Reachability private function.
    private func ipv4Reachability() -> SCNetworkReachability? {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)

        return withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        })
    }
}
