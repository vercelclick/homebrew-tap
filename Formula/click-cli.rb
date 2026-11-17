class ClickCli < Formula
  desc "Click uses passkeys to encrypt and decrypt secrets on your device offering a Just In Time secret injection model. Encrypted secrets are stored in your codebase or on a our hosted vault service."
  homepage "https://vercel.click"
  version "0.2.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vercelclick/cli/releases/download/0.2.7/click-cli-aarch64-apple-darwin.tar.xz"
      sha256 "e54c662bfaa279f0888a96a3d20f09328248cf0994686b5c0100f92efb2b2b9c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vercelclick/cli/releases/download/0.2.7/click-cli-x86_64-apple-darwin.tar.xz"
      sha256 "455da23b599e7785650277ebf5466cbb835a05d41f6a7ff4858187a3b392f0a8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vercelclick/cli/releases/download/0.2.7/click-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "1828c6dadc065b5ef273ce4045c90ba7acf1612ef5871056202a31ac868d1067"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vercelclick/cli/releases/download/0.2.7/click-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7407af3a106efd642990b3427a17db3d456eeb28b9821da4144667865f0b6966"
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
