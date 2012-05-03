# -*- encoding : utf-8 -*-
require 'active_record'

class ConstantTestOne < ActiveRecord::Base
  cache_constants :name
end

class ConstantTestTwo < ConstantTestOne

end

class ConstantTestTree < ActiveRecord::Base

end
