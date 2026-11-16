class ClickCli < Formula
  desc "Click uses passkeys to encrypt and decrypt secrets on your device offering a Just In Time secret injection model. Encrypted secrets are stored in your codebase or on a our hosted vault service."
  homepage "https://vercel.click"
  version "0.2.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vercelclick/cli/releases/download/0.2.5/click-cli-aarch64-apple-darwin.tar.xz"
      sha256 "42001840e9381680a4bcf3c829d43692cc90cbf4ad85b22f92928df34317af86"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vercelclick/cli/releases/download/0.2.5/click-cli-x86_64-apple-darwin.tar.xz"
      sha256 "b842d2091acccac9959332477498d7f034e56d809d7cce9df65bab85ca11e50c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vercelclick/cli/releases/download/0.2.5/click-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fcc115390516c93b1632ffccfa8ad06aa0ec2e722487f8ab97bfcd5cf93565ca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vercelclick/cli/releases/download/0.2.5/click-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "11394ef03588abc1a65f11011d2e860d183a81a924536162b9417fb44a8470db"
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
