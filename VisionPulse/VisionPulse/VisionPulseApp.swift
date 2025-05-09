import SwiftUI
import HealthKit

@main
struct VisionPulseApp: App {
    // アプリ全体で使う HealthStore
    private let healthStore = HKHealthStore()

    init() {
        seedDummyHeartRate()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    /// ダミーの心拍数サンプルをシミュレータの HealthKit に保存
    private func seedDummyHeartRate() {
        // 注：requestAuthorization で write 権限を取ったあとに保存します
        let hrType = HKQuantityType.quantityType(forIdentifier: .heartRate)!
        healthStore.requestAuthorization(toShare: [hrType], read: [hrType]) { granted, error in
            guard granted else {
                print("ダミーデータ用のHealthKit権限取得失敗:", error?.localizedDescription ?? "")
                return
            }
            // 現在時刻から 1 分前までの 72 BPM サンプルを作成
            let now = Date()
            let sample = HKQuantitySample(
                type: hrType,
                quantity: HKQuantity(unit: .count().unitDivided(by: .minute()), doubleValue: 72),
                start: now.addingTimeInterval(-60),
                end: now
            )
            self.healthStore.save(sample) { success, error in
                print("ダミー心拍数サンプル保存:", success, error?.localizedDescription ?? "")
            }
        }
    }
}
