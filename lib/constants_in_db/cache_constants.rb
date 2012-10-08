# -*- encoding : utf-8 -*-
module ConstantsCache

  def cache_constants(field)
    begin
      find(:all).each { |instance| cache_constant(field, instance) }
      after_save {|instance| self.class.cache_constant(field, instance) }
      model_name.human
      define_method :human do |opts={}|
        scopes = self.class.lookup_ancestors.map do |klass|
          klass.model_name.i18n_key
        end.map do |klass_key|
          [self.class.i18n_scope, :constants, klass_key]
        end
        I18n.translate( send(field).underscore, {:scope => scopes, :count => 1, :default => send(field)}.merge(opts.except(:default)) )
      end
    rescue ActiveRecord::StatementInvalid
    end
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
      super(args)
    end
  end

end


