# Homebrew cask for Moosic. This file is a template: homebrew-publish.yml
# stamps 0.1.13 and 3fb37142b2683aa55c25da50c5b574414c61b80e5189d575bb5abb5d6778caa5 on every tag release and pushes the
# result to Casks/moosic.rb in the public tap andvision/homebrew-moosic.
#
# Users install with:
#   brew tap andvision/moosic
#   brew trust andvision/moosic     # one-time, Homebrew 6+
#   brew install --cask moosic
cask "moosic" do
  version "0.1.13"
  sha256 "3fb37142b2683aa55c25da50c5b574414c61b80e5189d575bb5abb5d6778caa5"

  url "https://dl.moosic.now/v#{version}/moosic-v#{version}-macos.dmg"
  name "Moosic"
  desc "Lightweight retro-style audio player with Subsonic/Navidrome streaming"
  homepage "https://moosic.now/"

  # release.yml writes latest.json to the bucket root on every release.
  livecheck do
    url "https://dl.moosic.now/latest.json"
    strategy :json do |json|
      json["version"]&.delete_prefix("v")
    end
  end

  # No in-app updater; `brew upgrade --cask moosic` is the update path.
  auto_updates false
  # Matches osx_minimum_system_version in Cargo.toml.
  depends_on macos: :big_sur

  app "Moosic.app"

  # ProjectDirs::from("now", "moosic", "moosic") → now.moosic.moosic;
  # bundle identifier → now.moosic.app.
  zap trash: [
    "~/Library/Application Support/now.moosic.moosic",
    "~/Library/Caches/now.moosic.moosic",
    "~/Library/Preferences/now.moosic.app.plist",
    "~/Library/Saved Application State/now.moosic.app.savedState",
  ]
end
