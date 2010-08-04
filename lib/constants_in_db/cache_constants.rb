module ConstantsCache

  def cache_constants(field)
    find(:all).each { |instance| cache_constant(field, instance) }
    after_save {|instance| cache_constant(field, instance) }
  end
  def cache_constant(field=:name,instance=nil)
    if instance and !instance.send(field).blank?
      const = instance.send(field).gsub(/\s+/, '_').upcase
      remove_const(const) if const_defined?(const)
      const_set(const, instance)
    end
  end
  def const_get(args)
    if args.is_a?(Array)
      args.collect{|arg| const_get(arg) }
    else
      super(args.to_s.upcase)
    end
  end

end


