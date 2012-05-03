# -*- encoding : utf-8 -*-
ActiveRecord::Schema.define(:version => 0) do

  create_table "constant_test_ones", :force => true do |t|
    t.string   "name"
    t.string   "type"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "constant_test_trees", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end


end
