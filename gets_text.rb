# -*- coding: utf-8 -*-
# Wikipedia のページビューを解析するコード
# http://dumps.wikimedia.org/other/pagecounts-raw/
# 言語コード 記事名 閲覧回数 ページ容量(byte)
# ※記事名の中にspaceが入っているデータをうまく扱えない問題があります。

require 'CGI'
filename = 'pagecounts-20120301-000000'
#filename = '20120301-000000-ja.txt'
file = File.open(filename, 'r:UTF-8')
list = []
while text = file.gets
  begin
    next unless text =~ /^ja/
    #print CGI.unescape(text) if text =~ /^ja/
    data = text.split
    h = {:title => CGI.unescape(data[1]), :count => data[-2]}
    list << h
  rescue Exception => e
    #p e
  end
end
file.close

# count順にソート
result = list.sort_by do |i|
  i[:count].to_i
end

# トップ20表示
result.reverse.first(20).each do |i|
  puts i
end
