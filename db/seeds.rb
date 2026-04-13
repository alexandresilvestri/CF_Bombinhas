Dir[Rails.root.join("db/seeds/#{Rails.env}/**/*.rb")].each { |f| load f }
