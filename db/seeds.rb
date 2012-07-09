# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Setting.create({

        :name => "comment_allowed",
        :value => '1',
        :destroyable => '1',
        :created_at => Time.now,
        :updated_at => Time.now

    })
    Setting.create({

        :name => "comment_moderation",
        :value => '1',
        :destroyable => '1',
        :created_at => Time.now,
        :updated_at => Time.now

    })
