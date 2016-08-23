require "language/go"

class Rancherssh < Formula
  desc "Native SSH Client and docker terminal for Rancher Containers"
  homepage "https://github.com/fangli/rancherssh"
  url "https://github.com/fangli/rancherssh/archive/v1.1.2.tar.gz"
  version "1.1.2"
  sha256 "38974f8c601fa8cd9b9620893eea0ec3fed281513213f86029c3fb3097b9c251"

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
