require 'diff/lcs'

old_text = <<-"EOS"
ここに文章が書いてあって

Wikiでリクエストを送りたいわけですよ

AAAがBBBになって、CCCになるわけで
EOS

# 比較先
new_text = <<-"EOS"
ここに文章が書いてあって

Wikiでリクエストを送りたいわけですよ

AAAがBBBになってDDDにかわる
EOS

foo = Diff::LCS.sdiff(old_text.lines, new_text.lines)
pp foo