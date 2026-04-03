class Happenstance < Formula
  include Language::Python::Virtualenv

  desc "Search your network and research people via the Happenstance CLI"
  homepage "https://happenstance.ai"
  url "https://files.pythonhosted.org/packages/3d/74/2ebb90d5cce4a670c3e0e979ac5a57333f0ea0c8c3ba2dfcb4497cb222bc/happenstance-0.2.2.tar.gz"
  sha256 "a610f4bdb2812e44e86d00092a2d9437c22bf1c8e7e585de99f6126c4ac2dd67"
  license "MIT"

  depends_on "python@3.12"

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/9a/3c/c17fb3ca2d9c3acff52e30b309f538586f9f5b9c9cf454f3845fc9af4881/certifi-2026.2.25-py3-none-any.whl"
    sha256 "027692e4402ad994f1c42e52a4997a9763c646b73e4096e4d5d6db8af1d6f0fa"
  end

  resource "charset-normalizer" do
    url "https://files.pythonhosted.org/packages/db/8f/61959034484a4a7c527811f4721e75d02d653a35afb0b6054474d8185d4c/charset_normalizer-3.4.7-py3-none-any.whl"
    sha256 "3dce51d0f5e7951f8bb4900c257dad282f49190fdbebecd4ba99bcc41fef404d"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/0e/61/66938bbb5fc52dbdf84594873d5b51fb1f7c7794e9c0f5bd885f30bc507b/idna-3.11-py3-none-any.whl"
    sha256 "771a87f49d9defaf64091e6e6fe9c18d4833f140bd19464795bc32d966ca37ea"
  end

  resource "requests" do
    url "https://files.pythonhosted.org/packages/d7/8e/7540e8a2036f79a125c1d2ebadf69ed7901608859186c856fa0388ef4197/requests-2.33.1-py3-none-any.whl"
    sha256 "4e6d1ef462f3626a1f0a0a9c42dd93c63bad33f9f1c1937509b8c5c8718ab56a"
  end

  resource "urllib3" do
    url "https://files.pythonhosted.org/packages/39/08/aaaad47bc4e9dc8c725e68f9d04865dbcb2052843ff09c97b08904852d84/urllib3-2.6.3-py3-none-any.whl"
    sha256 "bf272323e553dfb2e87d9bfd225ca7b0f467b919d7bbd355436d3fd37cb0acd4"
  end

  def install
    venv = virtualenv_create(libexec, "python3.12")
    venv.pip_install resources
    system Formula["python@3.12"].opt_bin/"python3.12", "-m", "pip",
           "--python=#{libexec}/bin/python", "install", "--verbose",
           "--no-deps", "--ignore-installed", "--no-compile", buildpath
    (bin/"hpn").write_env_script libexec/"bin/hpn", PATH: "#{libexec}/bin:$PATH"
    (bin/"happenstance").write_env_script libexec/"bin/happenstance", PATH: "#{libexec}/bin:$PATH"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hpn --version")
  end
end

