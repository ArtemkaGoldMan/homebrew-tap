cask "contextswitcher" do
  # Always the newest release: the app updates itself from Settings > Updates, so there is no
  # version here to bump. `brew upgrade --greedy` reinstalls the latest too.
  version :latest
  sha256 :no_check

  url "https://github.com/ArtemkaGoldMan/ContextSwitcher/releases/latest/download/ContextSwitcher.zip"
  name "ContextSwitcher"
  desc "Switch between work and personal setups in one click"
  homepage "https://github.com/ArtemkaGoldMan/ContextSwitcher"

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "ContextSwitcher.app"

  # ContextSwitcher is not notarised by Apple (that needs a paid Developer ID), so macOS would
  # refuse to open the quarantined copy Homebrew installs. Releases are signed with the project's
  # own certificate, and the app checks it before installing any update.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/ContextSwitcher.app"]
  end

  uninstall quit: "com.artem.contextswitcher"

  zap trash: "~/.config/ContextSwitcher"
end
