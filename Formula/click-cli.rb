class ClickCli < Formula
  desc "Click uses passkeys to encrypt and decrypt secrets on your device offering a Just In Time secret injection model. Encrypted secrets are stored in your codebase or on a our hosted vault service."
  homepage "https://vercel.click"
  version "0.2.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/vercelclick/cli/releases/download/0.2.7/click-cli-aarch64-apple-darwin.tar.xz"
      sha256 "2be6ccf1104a8fc679043a4757de0c387e48057bb6579dd7ab97e3d52c3d8b42"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vercelclick/cli/releases/download/0.2.7/click-cli-x86_64-apple-darwin.tar.xz"
      sha256 "78619512c67aa69d2d419652c08d164f1946e64a50ce21473a6a2f94e69835f7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/vercelclick/cli/releases/download/0.2.7/click-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5179fa42a3c5902fe8b4e6c987bb49a0c04259ed2114661887cc11a6071cd279"
    end
    if Hardware::CPU.intel?
      url "https://github.com/vercelclick/cli/releases/download/0.2.7/click-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a750e38eb17be39cbe88b526a2a8ae2f24a231aec9891adbb288cf63a40efe49"
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
