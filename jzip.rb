require 'formula'

class Jzip < Formula
  homepage 'http://jzip.sourceforge.net/'
  url 'http://download.sourceforge.net/jzip/jzip21-10oct2000.zip'
  sha256 '722a81ee1a9cff51f468dbf38c54a2b149e6cda71e6c540caf4ec4308e290d9d'
  version '2.1'

  patch :DATA

  def install
    ENV.delete("SDKROOT")
    system "make -f unixio.mak"

    bin.install "jzip"
    bin.install "jzexe"
    bin.install "ckifzs"
  end

  def test
    system "jzip"
  end
end

__END__
diff --git a/osdepend.c b/osdepend.c
index 12c8bc4..bf62f06 100644
--- a/osdepend.c
+++ b/osdepend.c
@@ -87,7 +87,7 @@ static int strictz_error_count[STRICTZ_NUM_ERRORS];
 /* getopt linkages */
 
 extern int optind;
-extern const char *optarg;
+// extern const char *optarg;
 extern ZINT16 default_fg, default_bg;
 
 #endif /* !defined(AMIGA) */
