# -*- coding: utf-8 -*-
# Wikipedia のページビューを解析するコード
# Data file(pagecounts-20120301-000000) は以下のページから取得
# http://dumps.wikimedia.org/other/pagecounts-raw/
# Data file format : 言語コード 記事名 閲覧回数 ページ容量(byte)

require 'cgi'
#filename = 'pagecounts-20120301-000000'
filename = '20120301-000000-ja.txt'
file = File.open(filename, 'r:UTF-8')
list = []
while text = file.gets
  begin
    next unless text =~ /^ja/
    #print CGI.unescape(text) if text =~ /^ja/
    data = text.split
    h = {:title => CGI.unescape(data[1]), :count => data[-2]}
    # replace to follow line if you use windows prompt and display like "\u4FDD\u5143\u306E\u4E71".
    # h = {:title => CGI.unescape(data[1]).encode("cp932"), :count => data[-2]}
    list.push h
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
