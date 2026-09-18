class FastCli < Formula
  desc "Command-line version of fast.com in ~1.2 MB"
  homepage "https://github.com/mikkelam/fast-cli"
  url "https://github.com/mikkelam/fast-cli/archive/refs/tags/v0.3.6.tar.gz"
  sha256 "9e54037b2712943b0227f09c33f137cc55a7ec859ac89684782165fb8dba1487"
  license "MIT"
  head "https://github.com/mikkelam/fast-cli.git", branch: "main"

  bottle do
    root_url "https://github.com/botantony/homebrew-fast-cli/releases/download/fast-cli-0.3.5"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "a45c5aa1a8ef0a5e830df15e2bbbe69c2ffe9a428c8c41c55c5d88d7f09e5af1"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "8e07409f57d98cf964780e42ab3a537cdd117e627db95ce6010d01a6ef56140c"
  end

  depends_on "zig@0.15" => :build

  def install
    system "zig", "build", *std_zig_args
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/fast-cli --help 2>&1")

    json_output = JSON.parse(shell_output("#{bin}/fast-cli --json"))

    refute_nil json_output["download_mbps"]
  end
end
