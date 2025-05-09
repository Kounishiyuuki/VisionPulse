//import SwiftUI
//import RealityKit
//import RealityKitContent
//
//struct RealityPanelView: View {
//    @Binding var heartRate: Double?
//
//    var body: some View {
//        RealityView { content in
//            // シーンをロード
//            let panel = try! HealthPanel.loadScene()
//            content.add(panel)
//        } update: { content in
//            // テキストエンティティを探して書き換え
//            if let hr = heartRate,
//               let textEnt = content.scene.findEntity(named: "HeartRateText") as? HasText {
//                textEnt.model?.mesh = .generateText(
//                    "\(Int(hr)) BPM",
//                    extrusionDepth: 0.01,
//                    font: .systemFont(ofSize: 0.1),
//                    containerFrame: .zero,
//                    alignment: .center,
//                    lineBreakMode: .byWordWrapping
//                )
//            }
//        }
//        // ウィンドウスタイルを自動選択（Vision Pro ウィンドウにフィット）
//        .windowStyle(.automatic)
//    }
//}
