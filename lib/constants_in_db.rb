
Dir.glob(File.join(File.dirname(__FILE__),'constants_in_db','*')).each do |file|
  require file
end


ActiveRecord::Base.send(:extend, ConstantsCache)
