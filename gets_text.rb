# -*- coding: utf-8 -*-
# Wikipedia のページビューを解析するコード
# http://dumps.wikimedia.org/other/pagecounts-raw/
# 言語コード 記事名 閲覧回数 ページ容量(byte)

require 'CGI'
#filename = 'sample.txt'
filename = 'pagecounts-20120301-000000'
file = File.open(filename, 'r:UTF-8')
while (text = file.gets)
  begin
    print CGI.unescape(text) if text =~ /^ja/
  rescue Exception => e
    p e
  end
end
file.close

