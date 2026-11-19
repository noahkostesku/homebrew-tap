class Agentflow < Formula
  desc "One live view of every coding agent you run: a terminal visualizer for Claude Code, Codex and other agent harnesses"
  homepage "https://github.com/noahkostesku/agentflow"
  version "0.3.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/noahkostesku/agentflow/releases/download/v0.3.1/agentflow-aarch64-apple-darwin.tar.xz"
      sha256 "43d18b9f28fcac58523b795d5fa598138e6a47336298ba54e1b4e6010212090e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/noahkostesku/agentflow/releases/download/v0.3.1/agentflow-x86_64-apple-darwin.tar.xz"
      sha256 "9957b96ad232ccb962a0dbaeb0feb2e6415eb0d66fa3d890491f4468badabe95"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/noahkostesku/agentflow/releases/download/v0.3.1/agentflow-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "cef9b5f52756293177c1d0034bc6d3d62202a2b323668502c41f4ff31eb16b9f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/noahkostesku/agentflow/releases/download/v0.3.1/agentflow-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "02ea2773cb431aed332e361216959bd5b3049504aae4d50d577003a88fed954f"
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
