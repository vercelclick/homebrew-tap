class ClickCli < Formula
  desc "Click uses passkeys to encrypt and decrypt secrets on your device offering a Just In Time secret injection model. Encrypted secrets are stored in your codebase or on a our hosted vault service."
  homepage "https://vercel.click"
  version "0.2.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vercelclick/cli/releases/download/0.2.6/click-cli-aarch64-apple-darwin.tar.xz"
      sha256 "6a4621f27fe7e9d3afe03174455edb491a9263275e05d10c5d4bdfbd33a3003a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vercelclick/cli/releases/download/0.2.6/click-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f75e553646397265107a69fff6892e437c95284251c0877884e0c6bc099558ad"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vercelclick/cli/releases/download/0.2.6/click-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e036c3b4a02b426df601d4313b8175195508f2c0e7aa8e637bdf52a0603efdf4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vercelclick/cli/releases/download/0.2.6/click-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "44d6fb3d11eb2647eaf1041f80705b2555e101a0fdb569a1723cf7bd2fb19aac"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {
      click: [
        "click-cli",
      ],
    },
    "aarch64-unknown-linux-gnu":         {
      click: [
        "click-cli",
      ],
    },
    "x86_64-apple-darwin":               {
      click: [
        "click-cli",
      ],
    },
    "x86_64-unknown-linux-gnu":          {
      click: [
        "click-cli",
      ],
    },
    "x86_64-unknown-linux-musl-dynamic": {
      click: [
        "click-cli",
      ],
    },
    "x86_64-unknown-linux-musl-static":  {
      click: [
        "click-cli",
      ],
    },
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "click"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "click"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "click"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "click"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
