class FastCli < Formula
  desc "Command-line version of fast.com in ~1.2 MB"
  homepage "https://github.com/mikkelam/fast-cli"
  url "https://github.com/mikkelam/fast-cli/archive/refs/tags/v0.3.9.tar.gz"
  sha256 "249e222e6fd534c508f2338eef35e66a5a588c51e8093642cc24d587c3a7cb10"
  license "MIT"
  head "https://github.com/mikkelam/fast-cli.git", branch: "main"

  bottle do
    root_url "https://github.com/botantony/homebrew-fast-cli/releases/download/fast-cli-0.3.9"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "b7f26242ea031c9b44a5e397b0925dede6e3f0f6e683f48a50b2506ee203063b"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "02737d00e025814ca554272d7b69c0972dbdfe2d6d3a657228760e69226bdf8e"
  end

  depends_on "zig@0.16" => :build

  def install
    system "zig", "build", *std_zig_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fast-cli --help 2>&1")

    json_output = JSON.parse(shell_output("#{bin}/fast-cli --json"))

    refute_nil json_output["download_mbps"]
  end
end
