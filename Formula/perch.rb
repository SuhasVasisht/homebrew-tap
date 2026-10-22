class Perch < Formula
  desc "Small, cropped web apps that float on your Mac desktop"
  homepage "https://github.com/SuhasVasisht/perch"
  url "https://github.com/SuhasVasisht/perch/releases/download/v1.9/Perch-1.9-source.tar.gz"
  sha256 "6fba0c6efad246fb45aa3e1ddbaa9ddcd70412fec67801df06537e531ca3c1e1"
  license "MIT"
  head "https://github.com/SuhasVasisht/perch.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :tahoe

  # Keep Homebrew's stripping step from invalidating the signed app bundle.
  skip_clean "Perch.app"

  def install
    system "./build.sh"
    prefix.install "Perch.app"
    (bin/"perch").write <<~EOS
      #!/bin/bash
      set -euo pipefail
      case "$#:${1:-}" in
        0:) exec /usr/bin/open "#{opt_prefix}/Perch.app" ;;
        1:--version) exec "#{opt_prefix}/Perch.app/Contents/MacOS/Perch" --version ;;
        *) echo "Usage: perch [--version]" >&2; exit 2 ;;
      esac
    EOS
  end

  def caveats
    <<~EOS
      Run perch to open the app, or perch --version to check the installed build.
      Perch.app is at:
        #{opt_prefix}/Perch.app

      This formula builds from source on your Mac with a free ad-hoc signature.
      It does not download a prebuilt app or require an Apple Developer account.
      An existing /Applications/Perch.app is left in place. Quit that copy before
      opening this one. Both copies use the same saved settings and sign-ins.
    EOS
  end

  test do
    system "/usr/bin/codesign", "--verify", "--strict", prefix/"Perch.app"
    if version.head?
      assert_match(/\APerch \S+ \(\d+\)\n\z/, shell_output("#{bin}/perch --version"))
    else
      assert_equal "Perch #{version} (12)\n", shell_output("#{bin}/perch --version")
    end
  end
end
