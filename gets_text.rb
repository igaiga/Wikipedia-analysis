# -*- coding: utf-8 -*-
# Wikipedia のページビューを解析するコード
# http://dumps.wikimedia.org/other/pagecounts-raw/
# 言語コード 記事名 閲覧回数 ページ容量(byte)
# ※記事名の中にspaceが入っているデータをうまく扱えない問題があります。

require 'CGI'
#filename = 'sample.txt'
#filename = 'pagecounts-20120301-000000'
filename = '20120301-000000-ja.txt'
file = File.open(filename, 'r:UTF-8')
list = []
while text = file.gets
  begin
    #print CGI.unescape(text) if text =~ /^ja/
    data = CGI.unescape(text).split
    h = {:title => data[1], :count => data[2]}
    list << h
  rescue Exception => e
    #p e
  end
end
file.close

# count順にソート
result = list.sort_by do |i|
  if i
    i[:count].to_i
  else
    0
  end
end

# トップ20表示
result.reverse.first(20).each do |i|
  puts i
end
