# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create!(
  email: 'admin@admin10.com',
  password: 'Admin10'
)

nekotaro = EndUser.create!(
  end_user_name: '猫太郎',
  email: 'nekotarou@example.com',
  password: 'nekotarou',
  profile_photo: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-enduser1.jpg"), filename:"sample-enduser1.jpg"),
  introduction: '猫好き。よろしくお願いします。',
  is_active: true
)

catlife = EndUser.create!(
  end_user_name: 'catlife',
  email: 'catlife@example.com',
  password: 'catlife',
  profile_photo: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-enduser2.jpg"), filename:"sample-enduser2.jpg"),
  introduction: '猫と暮らして10年以上になります。毎日癒されてます。',
  is_active: true
)

EndUser.create!(
  end_user_name: 'nekoneko',
  email: 'nekoneko@example.com',
  password: 'nekoneko',
  profile_photo: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-enduser3.jpg"), filename:"sample-enduser3.jpg"),
  introduction: '見る専です。',
  is_active: true
)

Post.create!(
  [
    {
      name: 'じっと見つめてます',
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post1.jpg"), filename:"sample-post1.jpg"),
      introduction: '何かが気になる様です。',
      end_user: nekotaro,
    },
    {
      name: '警戒中',
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post2.jpg"), filename:"sample-post2.jpg"),
      introduction: 'こちらを警戒してます。',
      end_user: catlife,
    },
    {
      name: '眠たいにゃ〜',
      image: ActiveStorage::Blob.create_and_upload!(io: File.open("#{Rails.root}/db/fixtures/sample-post3.jpg"), filename:"sample-post3.jpg"),
      introduction: '今にも寝てしまいそうです。',
      end_user: catlife,
    }
  ]
)