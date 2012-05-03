# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class ConstantsCacheTest < ActiveSupport::TestCase
  prepare_env

  def load_seeds
    seeds = Seeds.new
    seeds.load_data
    seeds.save!
  end
  
  def constants_in_seeds_are_cached_once_loaded
    load_seeds
    assert_not_nil ConstantTestOne::RECORD_ONE
    assert_equal '1', ConstantTestOne::RECORD_ONE.value
    assert_not_nil ConstantTestOne::RECORD_TWO
    assert_equal '2', ConstantTestOne::RECORD_TWO.value
  end

  def test_constants_can_be_cached_at_runtime
    assert_difference "ConstantTestOne.count" do
      ConstantTestOne.create(:name => 'test', :value => 'nico')
    end
    assert_equal 'nico', ConstantTestOne::TEST.value
  end
  
  def test_const_get
    load_seeds
    assert_equal ConstantTestOne::RECORD_ONE, ConstantTestOne.const_get(:record_one)
    assert_equal ConstantTestOne::RECORD_ONE, ConstantTestOne.const_get('record_one')
    assert_equal [ConstantTestOne::RECORD_ONE, ConstantTestOne::RECORD_TWO], ConstantTestOne.const_get([:record_one,:record_two])
    assert_equal [ConstantTestOne::RECORD_ONE, ConstantTestOne::RECORD_TWO], ConstantTestOne.const_get([:record_one,'record_two'])
  end
  

end
