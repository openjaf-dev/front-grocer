# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )

#Rails.application.config.assets.precompile += %w( jquery-2.1.0.min.js )

#Rails.application.config.assets.precompile += %w( modernizr.js )
#Rails.application.config.assets.precompile += %w( bootstrap-tour.custom.js )
#Rails.application.config.assets.precompile += %w( king-common.js )
#Rails.application.config.assets.precompile += %w( deliswitch.js )

Rails.application.config.assets.precompile += %w( *.png *.gif *.jpg )


Rails.application.config.assets.precompile += %w( main.css )
Rails.application.config.assets.precompile += %w( bootstrap.css )


Rails.application.config.assets.precompile += %w( bootstrap.js )
Rails.application.config.assets.precompile += %w( highcharts.js )
Rails.application.config.assets.precompile += %w( chartkick.js )
Rails.application.config.assets.precompile += %w( font-awesome.css )
Rails.application.config.assets.precompile += %w( stat/colorbrewer.js )
Rails.application.config.assets.precompile += %w( stat/d3.min.js )
Rails.application.config.assets.precompile += %w( king-chart-stat.js )




