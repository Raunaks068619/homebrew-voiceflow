cask "voiceflow" do
  version "0.1.0-beta.1"
  sha256 "9cdef12b111a9f34e693f0a5c22ee4f26214922130513913f49309146d0d1404"

  url "https://github.com/raunaksingh/voiceflow/releases/download/v#{version}/VoiceFlow-Beta.dmg",
      verified: "github.com/raunaksingh/voiceflow/"
  name "VoiceFlow"
  desc "Bilingual (Hindi/English) dictation app with real-time translation"
  homepage "https://github.com/raunaksingh/voiceflow"

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
