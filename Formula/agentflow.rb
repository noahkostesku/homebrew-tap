class Agentflow < Formula
  desc "One live view of every coding agent you run: a terminal visualizer for Claude Code, Codex and other agent harnesses"
  homepage "https://github.com/noahkostesku/agentflow"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/noahkostesku/agentflow/releases/download/v0.2.0/agentflow-aarch64-apple-darwin.tar.xz"
      sha256 "c0f0d09bfb616145b36449f2d9c7102fa70dacb9f58e4faf5a3a206ecb69a922"
    end
    if Hardware::CPU.intel?
      url "https://github.com/noahkostesku/agentflow/releases/download/v0.2.0/agentflow-x86_64-apple-darwin.tar.xz"
      sha256 "48fcf64a10bc434830fb033599d8e1f1546392f68a5a6a6180e3db9c628edce5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/noahkostesku/agentflow/releases/download/v0.2.0/agentflow-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6a030312fd8b8324e64fd5aaf49bd6752e0efdd503b22298093002461e6c83f3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/noahkostesku/agentflow/releases/download/v0.2.0/agentflow-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "bd970f7e1a6b69e611bd7d3fde3cc6ad73ec0ce8f8e193d7ce85be4f21e1304e"
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
