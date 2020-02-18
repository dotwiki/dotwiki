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
admin.watches.create(wiki_id: dotwiki.id)

dev_wiki = Wiki.create(
  title: 'かいはつよーうぃき',
)
dev_wiki.wiki_maintainers.create(user: t4traw, level: 3)
t4traw.watches.create(wiki_id: dev_wiki.id)

3.times do
  user = User.new(
    name: Faker::Games::Pokemon.name,
    email: Faker::Internet.email,
    password: 'password',
    agreement: true
  )
  user.save!
  user.activate!
  dev_wiki.wiki_maintainers.create(user: user, level: (1..3).to_a.sample)
  user.watches.create(wiki_id: dev_wiki.id)
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
  user.watches.create(wiki_id: dev_wiki.id)
end



markdown = <<~MARKDOWN
ほのお系テムテムは火のように強力で予想がつかない。みどりとクリスタルに強く、みずやだいち等に弱い。

![file](https://res.cloudinary.com/dotwiki/image/upload/v1581133079/vhsmw61cmj8q4cxnvnif.png)

## ほのお系のテムテム一覧

| :sortable:ID | 画像 | テムテム名 | タイプ | HP | STA | SPD | ATK | DEF | SPATK | SPDEF | 合計 |
| ------------ | --- | ----- | --- | --- | --- | --- | --- | --- | ----- | ----- | --- |
| 37 | <img src="https://res.cloudinary.com/dotwiki/image/upload/v1581132578/l19babxa5z0x1imy4yzb.png" alt="Banapi" width="50"> | バナピー | ![](https://res.cloudinary.com/dotwiki/image/upload/w_25/v1581133079/vhsmw61cmj8q4cxnvnif.png) | 42 | 40 | 70 | 50 | 50 | 40 | 41 | 333 |
| 38 | <img src="https://res.cloudinary.com/dotwiki/image/upload/v1581132685/cum8wsyq50jj3kfqcldu.png" alt="Capyre" width="50"> | Capyre | ![](https://res.cloudinary.com/dotwiki/image/upload/w_25/v1581133079/vhsmw61cmj8q4cxnvnif.png) | 55 | 55 | 88 | 71 | 68 | 45 | 47 | 429 |
| 57 | <img src="https://res.cloudinary.com/dotwiki/image/upload/v1581132770/n4rqxumv5imqmlwmct6s.png" alt="Raiber" width="50"> | ライバール | ![](https://res.cloudinary.com/dotwiki/image/upload/w_25/v1581133079/vhsmw61cmj8q4cxnvnif.png) | 57 | 35 | 42 | 40 | 61 | 59 | 38 | 332 |
| 58 | <img src="https://res.cloudinary.com/dotwiki/image/upload/v1581214063/imidi0kyll6hfle2f42u.png" alt="Raize" width="50"> | ライゼ | ![](https://res.cloudinary.com/dotwiki/image/upload/w_25/v1581133079/vhsmw61cmj8q4cxnvnif.png) | 66 | 46 | 48 | 46 | 74 | 69 | 43 | 392 |
| 59 | <img src="https://res.cloudinary.com/dotwiki/image/upload/v1581132842/thyswdnpefll9yageewh.png" alt="Raican" width="50"> | Raican | ![](https://res.cloudinary.com/dotwiki/image/upload/w_25/v1581133079/vhsmw61cmj8q4cxnvnif.png) | 77 | 49 | 60 | 77 | 77 | 51 | 50 | 441 |

## ほのお系のワザ一覧

| :sortable:ワザ名 | タイプ | 種類 | ダメージ | 消費スタミナ | ホールド | 優先度 |
| ------------- | --- | --- | ---- | ------ | ---- | --- |
| Heat Up | ![](https://res.cloudinary.com/dotwiki/image/upload/w_25/v1581133079/vhsmw61cmj8q4cxnvnif.png) | ![](https://res.cloudinary.com/dotwiki/image/upload/w_25/v1581134192/rk8vjlz52okyzo7qzmtl.png) | - | 23 | 0 | ![](https://res.cloudinary.com/dotwiki/image/upload/w_50/v1581134994/kgpp4ybmh2mm1jragkn0.png) |
| Extinction | ![](https://res.cloudinary.com/dotwiki/image/upload/w_25/v1581133079/vhsmw61cmj8q4cxnvnif.png) | ![](https://res.cloudinary.com/dotwiki/image/upload/w_25/v1581134192/rk8vjlz52okyzo7qzmtl.png) | - | 32 | 2 | ![](https://res.cloudinary.com/dotwiki/image/upload/w_50/v1581134994/kgpp4ybmh2mm1jragkn0.png) |
| Fire Flame | ![](https://res.cloudinary.com/dotwiki/image/upload/w_25/v1581133079/vhsmw61cmj8q4cxnvnif.png) | ![](https://res.cloudinary.com/dotwiki/image/upload/w_25/v1581134236/bs3imz8h2tv36oxfduz9.png) | 45 | 7 | 0 | ![](https://res.cloudinary.com/dotwiki/image/upload/w_50/v1581134994/kgpp4ybmh2mm1jragkn0.png) |
| Warm Cuddle | ![](https://res.cloudinary.com/dotwiki/image/upload/w_25/v1581133079/vhsmw61cmj8q4cxnvnif.png) | ![](https://res.cloudinary.com/dotwiki/image/upload/v1581134278/sysuyhvrncm205q8hx5k.png) | 53 | 12 | 0 | ![](https://res.cloudinary.com/dotwiki/image/upload/w_50/v1581134994/kgpp4ybmh2mm1jragkn0.png) |
MARKDOWN

new_page = dev_wiki.pages.create({
  title: 'ほのお系',
  histories_attributes: [
    content: markdown,
    user_id: t4traw.id,
  ]
})