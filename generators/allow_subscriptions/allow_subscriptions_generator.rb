class AllowSubscriptionsGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.directory File.join('lib')
      m.file "subscription.rb", "app/models/subscription.rb"
      m.file "subscriptions_controller.rb", "app/controllers/subscriptions_controller.rb"
      m.route_resources "subscriptions"

      unless options[:skip_migration]
        m.migration_template 'migration.rb', 'db/migrate', :migration_file_name => "create_subscriptions"
      end
    end
  end
end
