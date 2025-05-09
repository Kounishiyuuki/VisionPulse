import Foundation
import HealthKit

final class HealthKitManager {
    static let shared = HealthKitManager()
    private let store = HKHealthStore()
    private let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate)!

    /// HealthKit の読み取り許可をリクエスト
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        // 読み取り(read) だけでなく、書き込み(toShare) も同じ heartRateType を渡す
        let typesToShare: Set<HKSampleType> = [heartRateType]
        let typesToRead: Set<HKObjectType> = [heartRateType]

        store.requestAuthorization(toShare: typesToShare, read: typesToRead) { success, error in
            completion(success, error)
        }
    }

    /// 最新の心拍数を取得してクロージャで返す
    func fetchLatestHeartRate(completion: @escaping (Double?, Error?) -> Void) {
        let sort = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: false)
        let query = HKSampleQuery(
            sampleType: heartRateType,
            predicate: nil,
            limit: 1,
            sortDescriptors: [sort]
        ) { _, samples, error in
            guard let sample = samples?.first as? HKQuantitySample else {
                completion(nil, error)
                return
            }
            // 単位：beats per minute
            let bpm = sample.quantity.doubleValue(for: .init(from: "count/min"))
            completion(bpm, nil)
        }
        store.execute(query)
    }
}
