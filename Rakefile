namespace :db do
  desc "Run Sequel migrations"
  task :migrate, [:version] do |t, args|
    require "sequel/core"

    Sequel.extension :migration

    version = args[:version].to_i if args[:version]

    Sequel.sqlite('db/iniciativas.sqlite') do |db|
      Sequel::Migrator.run(db, "db/migrations", target: version)
    end
  end
end
