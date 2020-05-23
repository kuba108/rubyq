namespace :seed do

  task :create_admin_users => [:environment] do |t, args|
    puts 'Creating admin user...'
    AdminUser.create email: 'admin@rubyq.com',
                     password: 'admin1234',
                     first_name: 'RubyQ',
                     last_name: 'Admin',
                     acl: {}
  end

end