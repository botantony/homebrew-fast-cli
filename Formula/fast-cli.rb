class FastCli < Formula
  desc "Command-line version of fast.com in ~1.2 MB"
  homepage "https://github.com/mikkelam/fast-cli"
  url "https://github.com/mikkelam/fast-cli/archive/refs/tags/v0.3.6.tar.gz"
  sha256 "9e54037b2712943b0227f09c33f137cc55a7ec859ac89684782165fb8dba1487"
  license "MIT"
  head "https://github.com/mikkelam/fast-cli.git", branch: "main"

  bottle do
    root_url "https://github.com/botantony/homebrew-fast-cli/releases/download/fast-cli-0.3.6"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "6236a6f0a09df94aab9282f785bd27ec81d913da3d897e19e0fedd1bc452b8c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "18aa74d7debc16c251fdc02851d759484def7c7ebd773514ee947b8d1a4e4ff6"
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
