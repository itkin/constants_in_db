require File.expand_path(File.dirname(__FILE__)) + "/constants_in_db/cache_constants"
require File.expand_path(File.dirname(__FILE__)) + "/constants_in_db/seeds"
require File.expand_path(File.dirname(__FILE__)) + "/constants_in_db/seeds_file"

ActiveRecord::Base.send(:extend, ConstantsCache)
