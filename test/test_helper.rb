# -*- encoding : utf-8 -*-
#Bon je suis as hyper sur de moi dans tous ces .. de require
require 'rubygems'
require 'test/unit'
require 'active_support'
require 'active_support/test_case'

require 'active_record'

ENV['RAILS_ENV'] = RAILS_ENV = 'test'
ENV['RAILS_ROOT'] = RAILS_ROOT = File.expand_path(File.dirname(__FILE__)+ '/fixtures')

def start_debugger
  begin
    require_library_or_gem 'ruby-debug'
    Debugger.start
    if Debugger.respond_to?(:settings)
      Debugger.settings[:autoeval] = true
      Debugger.settings[:autolist] = 1
    end
  rescue LoadError
    raise LoadError.new("ruby-debug wasn't available so neither can the debugging be")
  end
end

def load_schema
  config = YAML::load(IO.read(File.dirname(__FILE__) + '/fixtures/database.yml'))
  ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")

  db_adapter = 'mysql'
  
  db_adapter ||=
    begin
      require 'sqlite'
      'sqlite'
    rescue MissingSourceFile
      begin require 'sqlite3'
        'sqlite3'
      rescue MissingSourceFile
      end
    end

  if db_adapter.nil?
    raise "No DB Adapter selected. Pass the DB= option to pick one, or install Sqlite or Sqlite3."
  end

  ActiveRecord::Base.establish_connection(config[db_adapter])
  load(File.dirname(__FILE__) + "/fixtures/schema.rb")
  require File.dirname(__FILE__) + '/../init.rb'

end

def load_data_model
  require File.join(File.dirname(__FILE__),'fixtures','data_model')
end

def prepare_env
  start_debugger
  load_schema
  load_data_model  
end
