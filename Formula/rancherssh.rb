require "language/go"

class Rancherssh < Formula
  desc "Native SSH Client and docker terminal for Rancher Containers"
  homepage "https://github.com/fangli/rancherssh"
  url "https://github.com/fangli/rancherssh/archive/v1.1.3.tar.gz"
  version "1.1.3"
  sha256 "f36a678e66e8d7b832901bc37747e09424910180d06af89d3c5c3ed53f5d03f7"

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
