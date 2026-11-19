class Agentflow < Formula
  desc "One live view of every coding agent you run: a terminal visualizer for Claude Code, Codex and other agent harnesses"
  homepage "https://github.com/noahkostesku/agentflow"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/noahkostesku/agentflow/releases/download/v0.3.0/agentflow-aarch64-apple-darwin.tar.xz"
      sha256 "98d81ddb76dd6f5ad0226c502a43681b26359de30f1640fa734686a1bfe44b4c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/noahkostesku/agentflow/releases/download/v0.3.0/agentflow-x86_64-apple-darwin.tar.xz"
      sha256 "7ac68cb15939141c7f594b9337a7a5f7d2078f15b70477a6a3ad4ab1f18eefec"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/noahkostesku/agentflow/releases/download/v0.3.0/agentflow-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a3b9b7d357a301c2227bd69cd0b7bae63b3a004c16b947c4b62624da84f7b57e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/noahkostesku/agentflow/releases/download/v0.3.0/agentflow-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "dcfb53a7cdccccd9df59df0a6fc23dc56b4765d6db25e07022967fa50c2bde04"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "agentflow"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "agentflow"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "agentflow"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "agentflow"
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
