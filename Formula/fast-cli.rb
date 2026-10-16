class FastCli < Formula
  desc "Command-line version of fast.com in ~1.2 MB"
  homepage "https://github.com/mikkelam/fast-cli"
  url "https://github.com/mikkelam/fast-cli/archive/refs/tags/v0.3.10.tar.gz"
  sha256 "f138be28f21095369e27663a9c97bdfe29d440ce49adc82d1b0484cea1db44f4"
  license "MIT"
  head "https://github.com/mikkelam/fast-cli.git", branch: "main"

  bottle do
    root_url "https://github.com/botantony/homebrew-fast-cli/releases/download/fast-cli-0.3.10"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "3cc22b2b49d154ca828c092fa285e337a1dd7e6aecbc829c806ab91fc9155212"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "694ac95133308e35005bc93b4790b5966b9f019582be2cf1a146bbf6777ee1ad"
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
