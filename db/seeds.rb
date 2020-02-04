ActionMailer::Base.perform_deliveries = false

system('redis-cli flushall')

admin = User.new(
  name: 'dotwiki',
  email: 'info@dotwiki.xyz',
  password: 'password',
  agreement: true
)
admin.save!
admin.activate!

t4traw = User.new(
  name: 't4traw',
  email: 't4traw@gmail.com',
  password: 'password',
  agreement: true
)
t4traw.save!
t4traw.activate!

# 一番最初のdotwikiの処理
dotwiki = Wiki.create(
  title: 'dotwiki',
  description: 'dotwikiの使い方に関するwikiです',
  terms: '機能要望や改善要望などは、こちらのwikiのフォーラムに書き込んでください'
)
dotwiki.wiki_maintainers.create(user: admin, level: 3)

wiki = Wiki.create(
  title: 'かいはつよーうぃき',
)
wiki.wiki_maintainers.create(user: t4traw, level: 3)

admin.watches.create(wiki_id: dotwiki.id)
t4traw.watches.create(wiki_id: wiki.id)

3.times do
  user = User.new(
    name: Faker::Games::Pokemon.name,
    email: Faker::Internet.email,
    password: 'password',
    agreement: true
  )
  user.save!
  user.activate!
  wiki.wiki_maintainers.create(user: user, level: (1..3).to_a.sample)
  user.watches.create(wiki_id: wiki.id)
end

10.times do
  user = User.new(
    name: Faker::Games::Pokemon.name,
    email: Faker::Internet.email,
    password: 'password',
    agreement: true
  )
  user.save!
  user.activate!
  user.watches.create(wiki_id: wiki.id)
end