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

  desc "Populate Database"
  task :populate do
    require 'logger'
    require 'open-uri'
    require 'zlib'

    require_relative 'db/database'
    require_relative 'lib/chile_convencion'

    logger = Logger.new($stdout)

    urls = ChileConvencion.download_urls
    total = urls.count

    urls.shuffle.each.with_index do |url, index|
      # progress display
      count_str = format('(%5d/%5d)', index + 1, total)

      if Page.find url: url
        logger.info "#{count_str} Skipping #{url}. Found in database."
      else
        logger.info "#{count_str} Fetching #{url}."

        html = URI.open(url).read
        Page.create(url: url, body: Zlib.gzip(html))

        sleep 1 + rand
      end
    end
  end
end
