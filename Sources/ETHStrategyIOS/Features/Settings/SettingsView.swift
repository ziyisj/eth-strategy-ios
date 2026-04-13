import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var config: AppConfig
    @EnvironmentObject private var store: DashboardStore

    var body: some View {
        Form {
            Section("接口") {
                TextField("Base URL", text: $config.baseURLString)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .keyboardType(.URL)
            }

            Section("默认参数") {
                Picker("周期", selection: $config.defaultBar) {
                    ForEach(config.availableBars, id: \.self) { bar in
                        Text(bar).tag(bar)
                    }
                }

                Picker("策略", selection: $config.defaultStrategy) {
                    ForEach(config.availableStrategies, id: \.self) { strategy in
                        Text(strategy).tag(strategy)
                    }
                }
            }

            Section("操作") {
                Button("立即同步") {
                    Task {
                        await store.refresh(using: config)
                    }
                }
            }
        }
        .scrollContentBackground(.hidden)
        .background(Color.black)
        .navigationTitle("设置")
    }
}
