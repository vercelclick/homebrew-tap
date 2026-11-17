class ClickCli < Formula
  desc "Click uses passkeys to encrypt and decrypt secrets on your device offering a Just In Time secret injection model. Encrypted secrets are stored in your codebase or on a our hosted vault service."
  homepage "https://vercel.click"
  version "0.2.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vercelclick/cli/releases/download/0.2.8/click-cli-aarch64-apple-darwin.tar.xz"
      sha256 "896b073793a9c5f13397694ae424dab37ea05820a3fddf6ea84585db0e61f04f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vercelclick/cli/releases/download/0.2.8/click-cli-x86_64-apple-darwin.tar.xz"
      sha256 "2605a27aefb3513187b1935ca74f89dc7b8b7327a4b65cbd01ec590f5f79ed82"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vercelclick/cli/releases/download/0.2.8/click-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d9acf45c4d39afb6c1f1636d5d5e6116ed42f75a172d2a0a240b1df5e17ba189"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vercelclick/cli/releases/download/0.2.8/click-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a77058af8a7d457a8644edccbb697fa10c13799d1331655d7b64eb91bbb99a8f"
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
