# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

AdminUser.create! first_name: 'Admin',
                  last_name: 'Admin',
                  email: 'admin@example.com',
                  password: 'admin1234',
                  acl: {"policies":{"dashboard":{"show_stats":"1"},"admin_user":{"index":"1","show":"1","update":"1","create":"1","destroy":"1","update_acl":"1","change_passwords":"1"},"menu":{"index":"1","show":"1","update":"1","create":"1","destroy":"1","change_order":"1"},"menu_item":{"index":"1","show":"1","update":"1","create":"1","destroy":"1"},"page":{"index":"1","show":"1","update":"1","create":"1","destroy":"1"},"gallery":{"index":"1","show":"1","update":"1","create":"1","destroy":"1"},"gallery_item":{"index":"1","show":"1","update":"1","create":"1","destroy":"1"},"setting":{"index":"1","show":"1","update":"1","create":"1","destroy":"1"}}}