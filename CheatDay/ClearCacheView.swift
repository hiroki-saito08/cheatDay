import SwiftUI

struct ClearCacheView: View {
    @State private var showAlert = false
    
    var body: some View {
        Form {
            Section {
                Button(action: {
                    clearAllCaches()
                    showAlert = true
                }) {
                    Text("キャッシュをクリアする")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .navigationBarTitle("キャッシュ管理", displayMode: .inline)
        .alert(isPresented: $showAlert) {
            Alert(title: Text("キャッシュクリア完了"), message: Text("キャッシュが正常にクリアされました。"), dismissButton: .default(Text("OK")))
        }
    }
    
    func clearAllCaches() {
        clearURLCache()
        clearTemporaryFiles()
        clearUserDefaults()
        clearCustomCacheDirectory()
        print("All caches cleared")
    }
    
    func clearURLCache() {
        let cache = URLCache.shared
        cache.removeAllCachedResponses()
        print("URL cache cleared")
    }
    
    func clearTemporaryFiles() {
        let tempDirectory = FileManager.default.temporaryDirectory
        do {
            let tempFiles = try FileManager.default.contentsOfDirectory(atPath: tempDirectory.path)
            for file in tempFiles {
                let filePath = tempDirectory.appendingPathComponent(file).path
                try FileManager.default.removeItem(atPath: filePath)
            }
            print("Temporary files cleared")
        } catch {
            print("Failed to clear temporary files: \(error.localizedDescription)")
        }
    }
    
    func clearUserDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        print("UserDefaults cache cleared")
    }
    
    func clearCustomCacheDirectory() {
        let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        do {
            let cacheFiles = try FileManager.default.contentsOfDirectory(atPath: cacheDirectory.path)
            for file in cacheFiles {
                let filePath = cacheDirectory.appendingPathComponent(file).path
                try FileManager.default.removeItem(atPath: filePath)
            }
            print("Custom cache cleared")
        } catch {
            print("Failed to clear custom cache: \(error.localizedDescription)")
        }
    }
}

struct ClearCacheView_Previews: PreviewProvider {
    static var previews: some View {
        ClearCacheView()
    }
}
