require 'formula'
require 'find'
require 'fileutils'

class Zork3 < Formula
  homepage 'http://www.infocom-if.org/downloads/downloads.html'
  url 'http://www.infocom-if.org/downloads/zork3.zip'
  version '1'
  sha256 'ef4a3b2bb7d3ae65de54a54520b550f13b3a2e964985550ffd401c8925bd0b10'

  depends_on 'jzip'

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

    FileUtils.makedirs("./share/zork3")
    copy_without('.', './share/zork3', 'share')
    file = File.new("zork3", "w+", 0755)
    file.write "#!/bin/bash
jzip #{prefix}/share/zork3/DATA/ZORK3.DAT
"
    bin.install "zork3"
    share.install "share/zork3"
  end
end
