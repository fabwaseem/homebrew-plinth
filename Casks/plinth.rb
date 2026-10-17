cask "plinth" do
  version "1.0.0"

  on_arm do
    sha256 "d8798a9789493cc1e7c26cfcf880f1813da98e913efe85d4f785757b72dd3991"
    url "https://github.com/fabwaseem/plinth/releases/download/v#{version}/Plinth-mac-arm64.dmg"
  end
  on_intel do
    sha256 "41e531e013938ec274fa03db633dd3bce250a3cc00a4fa65bf95ec6244683678"
    url "https://github.com/fabwaseem/plinth/releases/download/v#{version}/Plinth-mac-x64.dmg"
  end

  name "Plinth"
  desc "YouTube downloader"
  homepage "https://plinth.fabwaseem.com"

  # Electron 44 requires macOS 13; refuse the install on older
  # systems instead of shipping an app that cannot launch. A bare
  # symbol is a minimum; the ">= :x" string form is deprecated.
  depends_on macos: :ventura

  app "Plinth.app"

  # The macOS builds are ad-hoc signed, not notarized, so Homebrew's
  # unconditional quarantine would make first launch fail with
  # "Apple could not verify Plinth.app is free of malware". Homebrew
  # removed --no-quarantine in 4.7, so a tap that ships unsigned apps
  # has to strip the attribute itself; upstream tells tap maintainers
  # this post-processing is theirs to do. Drop this stanza once the
  # app is notarized.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Plinth.app"]
  end

  zap trash: [
    "~/Library/Application Support/Plinth",
    "~/Library/Preferences/com.plinth.app.plist",
    "~/Library/Logs/Plinth",
  ]
end
