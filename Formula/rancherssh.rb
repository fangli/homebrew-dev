require "language/go"

class Rancherssh < Formula
  desc "Native SSH Client and docker terminal for Rancher Containers"
  homepage "https://github.com/fangli/rancherssh"
  url "https://github.com/fangli/rancherssh/archive/v1.0.0.tar.gz"
  version "1.0.0"
  sha256 "3e217f1d3a8d36baa1f824e513869c62166c128c13f1e3332444b3ad65445876"

  head "https://github.com/fangli/rancherssh.git"

  depends_on "go" => :build

  def install
    mkdir_p buildpath/"src/github.com/fangli"
    ln_s buildpath, buildpath/"src/github.com/fangli/rancherssh"

    ENV["GOPATH"] = "#{buildpath}/Godeps/_workspace:#{buildpath}"

    Language::Go.stage_deps resources, buildpath/"src"

    system "go", "get", "-d"
    system "go", "build", "-o", "rancherssh"

    bin.install "rancherssh"
  end

  test do
    output = shell_output(bin/"rancherssh --version")
    assert_match version, output
  end
end
