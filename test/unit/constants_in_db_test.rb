# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'



class ConstantsInDbTest < ActiveSupport::TestCase
  prepare_env

  def test_env_is_loaded
    assert_equal File.expand_path(File.dirname(__FILE__)+ '/../fixtures'), RAILS_ROOT
    
    [ConstantTestOne, Seeds, SeedsFile].each do |klass|
      assert defined? klass
    end

  end


  
end
