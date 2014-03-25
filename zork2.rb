require 'formula'
require 'find'
require 'fileutils'

def copy_without(source_path, target_path, exclude)
  Find.find(source_path) do |source|
    target = source.sub(/^#{source_path}/, target_path)
    if File.directory? source
      Find.prune if File.basename(source) == exclude
      FileUtils.mkdir target unless File.exists? target
    else
      FileUtils.copy source, target
    end
  end
end

class Zork2 < Formula
  homepage 'http://www.infocom-if.org/downloads/downloads.html'
  url 'http://www.infocom-if.org/downloads/zork2.zip'
  version '1'
  sha1 'd4c4be791e6bbb97f486b317a6631c9e92a93b79'

  depends_on 'jzip'

  def install
    FileUtils.makedirs("./share/zork2")
    copy_without('.', './share/zork2', 'share')
    file = File.new("zork2", "w+", 0755)
    file.write "#!/bin/bash
jzip #{prefix}/share/zork2/DATA/ZORK2.DAT
"
    bin.install "zork2"
    share.install "share/zork2"
  end
end
