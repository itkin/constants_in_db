require "constants_in_db/cache_constants.rb"
require "constants_in_db/seeds.rb"
require "constants_in_db/seeds_file.rb"

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Base.send(:extend, ConstantsCache)
end

