ActionMailer::Base.perform_deliveries = false

# 一番最初のdotwikiの処理
dotwiki = Wiki.create(
  title: 'dotwiki',
  description: 'dotwikiの使い方に関するwikiです',
  terms: '機能要望や改善要望などは、こちらのwikiのフォーラムに書き込んでください'
)
dotwiki_admin = User.new(
  name: 'dotwiki',
  email: 'info@dotwiki.xyz',
  password: 'password',
  agreement: true
)
dotwiki_admin.save!
dotwiki_admin.activate!
dotwiki.wiki_maintainers.create(user: dotwiki_admin)
dotwiki_admin.watches.create(wiki_id: dotwiki.id)

# 自分がアクセスできるテスト用wiki
admin1 = User.new(
  name: 'あどみんさん',
  email: 't4traw+kanri1@gmail.com',
  password: 'password',
  agreement: true
)
admin1.save!
admin1.activate!

wiki = Wiki.create(
  title: 'かいはつよーうぃき',
)
wiki.wiki_maintainers.create(user: admin1)
admin1.watches.create(wiki_id: wiki.id)

