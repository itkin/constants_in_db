require "constants_in_db/cache_constants"
require "constants_in_db/seeds"
require "constants_in_db/seeds_file"

ActiveRecord::Base.send(:extend, ConstantsCache)
