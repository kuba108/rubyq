namespace :seed do

  task :create_admin_users => [:environment] do |t, args|
    puts 'Creating admin user...'
    AdminUser.create email: 'rubyq@example.com',
                     password: 'admin1234',
                     first_name: 'RubyQ',
                     last_name: 'Admin',
                     acl: {"policies":{"dashboard":{"show_stats":"1"},"admin_user":{"index":"1","show":"1","update":"1","create":"1","destroy":"1","update_acl":"1","change_passwords":"1"},"menu":{"index":"1","show":"1","update":"1","create":"1","destroy":"1","change_order":"1"},"menu_item":{"index":"1","show":"1","update":"1","create":"1","destroy":"1"},"page":{"index":"1","show":"1","update":"1","create":"1","destroy":"1"},"gallery":{"index":"1","show":"1","update":"1","create":"1","destroy":"1"},"gallery_item":{"index":"1","show":"1","update":"1","create":"1","destroy":"1"},"setting":{"index":"1","show":"1","update":"1","create":"1","destroy":"1"}}}
  end

end