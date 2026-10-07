class FastCli < Formula
  desc "Command-line version of fast.com in ~1.2 MB"
  homepage "https://github.com/mikkelam/fast-cli"
  url "https://github.com/mikkelam/fast-cli/archive/refs/tags/v0.3.9.tar.gz"
  sha256 "249e222e6fd534c508f2338eef35e66a5a588c51e8093642cc24d587c3a7cb10"
  license "MIT"
  head "https://github.com/mikkelam/fast-cli.git", branch: "main"

  bottle do
    root_url "https://github.com/botantony/homebrew-fast-cli/releases/download/fast-cli-0.3.7"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "3c0794aee4fd15900549bd85b97e442212435899f35a18b0ce17a902d5eb5011"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6bcdd5b4223652031b40065af877982780ad45a13449d98bbb4088f5cdf07ffc"
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
