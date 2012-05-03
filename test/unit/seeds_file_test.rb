# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'



class SeedsFileTest < ActiveSupport::TestCase
  prepare_env

  def test_base_class
    assert_equal ConstantTestOne, SeedsFile.new(RAILS_ROOT+'/db/seeds/common/constant_test_ones.yml').base_class    
  end

  def test_data
    data = SeedsFile.new(RAILS_ROOT+'/db/seeds/common/constant_test_ones.yml').data
    assert data.is_a?(Array)
    assert_equal [], ['record_one', 'record_two', 'record_tree'] - data.collect{|attr| attr['name'] }
  end

  def test_instanciate_data
    seeds_file = SeedsFile.new(RAILS_ROOT+'/db/seeds/common/constant_test_ones.yml')
    assert_equal [], ['1','2','3'] - seeds_file.instanciate_data(:name).map(&:value)
  end
end
