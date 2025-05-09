import SwiftUI
import HealthKit
import RealityKitContent  // Reality Composer で作ったシーンをロードするため

struct ContentView: View {
    @State private var heartRate: Double?  // 取得した心拍数を保持

    var body: some View {
        VStack(spacing: 24) {
            // ① 3D パネルで心拍数を表示する部分
//            RealityPanelView(heartRate: $heartRate)
//                .frame(width: 600, height: 350)  // Vision Pro で見やすいサイズに調整

            // ② テキスト表示（ゲージなどに置き換えても OK）
            if let hr = heartRate {
                Text("最新心拍数: \(Int(hr)) BPM")
                    .font(.title2)
            } else {
                Text("心拍数を取得してください")
                    .font(.subheadline)
            }

            // ③ 取得ボタン
            Button("取得") {
                HealthKitManager.shared.requestAuthorization { success, error in
                    guard success else {
                        print("HealthKit 許可エラー:", error?.localizedDescription ?? "")
                        return
                    }
                    HealthKitManager.shared.fetchLatestHeartRate { value, error in
                        DispatchQueue.main.async {
                            heartRate = value
                        }
                    }
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
}
