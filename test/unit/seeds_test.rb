# -*- encoding : utf-8 -*-
require File.dirname(__FILE__) + '/../test_helper'

class ConstantsInDbTest < ActiveSupport::TestCase
  prepare_env

  def test_all_file_paths
    assert_equal [RAILS_ROOT+'/db/seeds/common/constant_test_ones.yml', RAILS_ROOT+'/db/seeds/test/constant_test_trees.yml'], Seeds.all_file_paths.values
  end

  def test_files_are_loaded_without_options
    seeds = Seeds.new
    assert seeds.files.is_a?(Array)
    assert_equal [RAILS_ROOT+'/db/seeds/common/constant_test_ones.yml', RAILS_ROOT+'/db/seeds/test/constant_test_trees.yml'], seeds.files.map(&:path)
  end

  def test_test_files_are_loaded_with_only_option
    assert_equal [RAILS_ROOT+'/db/seeds/common/constant_test_ones.yml'], Seeds.new(:only => :constant_test_ones).files.map(&:path)
  end

  def test_test_files_are_loaded_with_except_option
    assert_equal [RAILS_ROOT+'/db/seeds/test/constant_test_trees.yml'], Seeds.new(:except => :constant_test_ones).files.map(&:path)
  end


  def test_new_with_key_options
    seeds = Seeds.new
    assert_equal Seeds::DEFAULT_KEY_NAMES, seeds.keys

    seeds = Seeds.new(:keys => ['name'], :only => 'constant_test_ones')
    assert_equal ['name'], seeds.keys
  end

  def test_seeds_data_are_instanciated
    [ConstantTestOne, ConstantTestTwo, ConstantTestTree].each{|klass| klass.delete_all }
    
    assert_difference "ConstantTestOne.count", 3 do #3 ici ca 2 parents et un enfant
      assert_difference "ConstantTestTwo.count", 1 do
        assert_difference "ConstantTestTree.count", 1 do
          seeds = Seeds.new
          seeds.load_data
          seeds.save
        end
      end
    end
  end

end
