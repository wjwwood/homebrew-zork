require 'formula'
require 'find'
require 'fileutils'

class Zork2 < Formula
  homepage 'http://www.infocom-if.org/downloads/downloads.html'
  url 'http://www.infocom-if.org/downloads/zork2.zip'
  version '1'
  sha256 '7c360a14ec61d8e8f265e1aa99a13487c5e0f016a752e4b32314405a0e9ffea0'

  depends_on 'fizmo'

  def install
    def copy_without(source_path, target_path, exclude)
      Find.find(source_path) do |source|
        target = source.sub(/^#{source_path}/, target_path)
        if File.directory? source
          Find.prune if File.basename(source) == exclude
          FileUtils.makedirs(target) unless File.exists? target
        else
          FileUtils.copy source, target
        end
      end
    end

    FileUtils.makedirs("./share/zork2")
    copy_without('.', './share/zork2', 'share')
    file = File.new("zork2", "w+", 0755)
    file.write "#!/bin/bash
fizmo-console #{prefix}/share/zork2/DATA/ZORK2.DAT
"
    bin.install "zork2"
    share.install "share/zork2"
  end
end
