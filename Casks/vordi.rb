cask "vordi" do
  version "0.7.2"
  sha256 "a4aeb882573bd64a8bd607605f7354dd856afbb64e4c7d4816eb25883f48f0fc"

  url "https://github.com/Raunaks068619/Vordi/releases/download/v#{version}/Vordi-Beta.dmg",
      verified: "github.com/Raunaks068619/Vordi/"
  name "Vordi"
  desc "Bilingual (Hindi/English) dictation app with real-time translation"
  homepage "https://github.com/Raunaks068619/Vordi"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :ventura
  depends_on arch: :arm64

  app "Vordi.app"

  uninstall quit: "com.vordi.app"

  zap trash: [
    "~/Library/Application Support/Vordi",
    "~/Library/Caches/com.vordi.app",
    "~/Library/Logs/Vordi",
    "~/Library/Preferences/com.vordi.app.plist",
  ]

  caveats <<~EOS
    Vordi needs three macOS permissions on first launch:

      1. Microphone        — click Allow when prompted
      2. Accessibility     — System Settings > Privacy & Security > Accessibility > toggle Vordi ON
      3. Input Monitoring  — System Settings > Privacy & Security > Input Monitoring > toggle Vordi ON

    If you previously denied any of these (e.g. upgrading from an earlier version),
    reset and relaunch:
      tccutil reset All com.vordi.app
      open /Applications/Vordi.app

    The app lives in your menu bar (top-right) once permissions are granted.
  EOS
end
