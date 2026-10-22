# SuhasVasisht/tap

Homebrew formulae for [Perch](https://github.com/SuhasVasisht/perch): small, cropped web apps that float on your Mac desktop.

```sh
brew install SuhasVasisht/tap/perch
perch
```

Perch builds from source on your Mac and needs macOS 26 or later on Apple silicon, plus the Xcode command line tools (`xcode-select --install`). To build the latest `main` instead of the latest release:

```sh
brew install --HEAD SuhasVasisht/tap/perch
```

## How this tap is maintained

`Formula/perch.rb` is generated. Don't edit it here; change `packaging/homebrew/perch.rb.in` in the Perch repository instead. Every push to Perch's `main` branch runs its Homebrew workflow, which:

- publishes a new GitHub release and points this formula at it when `Info.plist` has a version that hasn't been released yet;
- otherwise refreshes this formula from the template for the current release.
