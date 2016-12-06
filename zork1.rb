require 'formula'
require 'find'
require 'fileutils'

class Zork1 < Formula
  homepage 'http://www.infocom-if.org/downloads/downloads.html'
  url 'http://www.infocom-if.org/downloads/zork1.zip'
  version '1'
  sha256 '645027fb189ba8fd30daecca609e68e2bf2337b76e7b4f925ccf58778f3eac40'

  #depends_on 'jzip'

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

    FileUtils.makedirs("./share/zork1")
    copy_without('.', './share/zork1', 'share')
    file = File.new("zork1", "w+", 0755)
    file.write "#!/bin/bash
jzip #{prefix}/share/zork1/DATA/ZORK1.DAT
"
    bin.install "zork1"
    share.install "share/zork1"
  end
end
