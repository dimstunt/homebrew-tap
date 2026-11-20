# Rendered by `make cask` from packaging/homebrew/vedivox.rb.template — edit the
# template, not this file. Lives in the owner's homebrew-tap.
cask "vedivox" do
  version "0.5.0"
  sha256 "e8658e43be86dbde2fdddf9d95a1aedb55b1cead63285112861bac34eea1fb47"

  url "https://github.com/dimstunt/vedivox/releases/download/v#{version}/Vedivox-#{version}.zip"
  name "Vedivox"
  desc "Meeting recorder with on-device transcription and speaker recognition"
  homepage "https://github.com/dimstunt/vedivox"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app needs macOS 14.4; Homebrew can only say "Sonoma or later".
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "Vedivox-#{version}/Vedivox.app"
  binary "Vedivox-#{version}/vedivox"
  binary "Vedivox-#{version}/vedivox-mcp"

  # Meetings, audio and voice profiles are the user's data: `brew uninstall
  # --zap` must not delete them. Remove them by hand if you mean it:
  #   ~/Library/Application Support/Vedivox
  #   ~/Library/Preferences/com.dimstunt.Vedivox.plist
  #   ~/Library/Application Support/FluidAudio (speech models, ~1.2 GB, shared with other FluidAudio apps)
  zap trash: [
    "~/Library/Caches/com.dimstunt.Vedivox",
    "~/Library/HTTPStorages/com.dimstunt.Vedivox",
    "~/Library/Saved Application State/com.dimstunt.Vedivox.savedState",
  ]

  caveats <<~EOS
    On first launch Vedivox asks for the microphone, screen and system audio
    recording, and (for dictation) Accessibility. Grant them in
    System Settings → Privacy & Security.

    The Claude Code skills are not installed by the cask. They come as a
    plugin; in Claude Code:
      /plugin marketplace add dimstunt/vedivox
      /plugin install vedivox@vedivox
  EOS
end
