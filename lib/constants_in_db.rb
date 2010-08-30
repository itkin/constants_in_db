require "/constants_in_db/cache_constants.rb"
require "/constants_in_db/seeds.rb"
require "constants_in_db/seeds_file.rb"

ActiveRecord::Base.send(:extend, ConstantsCache)
