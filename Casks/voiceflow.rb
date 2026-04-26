cask "voiceflow" do
  version "0.3.0"
  sha256 "c1f833749946597fe8c0fbd6cb51aea70d50614ed7551556a73a5b6852b2f1bf"

  url "https://github.com/Raunaks068619/VoiceFlow/releases/download/v#{version}/VoiceFlow-Beta.dmg",
      verified: "github.com/Raunaks068619/VoiceFlow/"
  name "VoiceFlow"
  desc "Bilingual (Hindi/English) dictation app with real-time translation"
  homepage "https://github.com/Raunaks068619/VoiceFlow"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"
  depends_on arch: :arm64

  app "VoiceFlow.app"

  # Ad-hoc signed build — strip quarantine so Gatekeeper lets it launch.
  # Remove this postflight block once we move to Apple Developer ID + notarization.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-cr", "#{appdir}/VoiceFlow.app"],
                   sudo: false
  end

  uninstall quit: "com.voiceflow.app"

  zap trash: [
    "~/Library/Application Support/VoiceFlow",
    "~/Library/Caches/com.voiceflow.app",
    "~/Library/Logs/VoiceFlow",
    "~/Library/Preferences/com.voiceflow.app.plist",
  ]
end
