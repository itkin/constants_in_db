require 'erb'
require 'yaml'
class SeedsFile < File

  attr_accessor :data, :instances, :base_class

  #Return the base class from a seeds file base name (actions.yml => Action)
  def base_class
    @base_class ||= self.class.basename(path,'.yml').classify.constantize
  end

  def data
    if @data
      @data
    else
      @data = YAML::load ERB.new(read).result
      @data = @data.is_a?(Hash) ? @data.map(&:last) : @data
    end
  end

  #Instanciate retrieved data given its key attribute, overriding or not the others attributes
  #instanciate_data(keys,.., { :override => (true/false) })
  def instanciate_data(*params)
    options = params.extract_options!.symbolize_keys!
    keys = params.flatten.map(&:to_s)

    @instances = data.collect do |attr|
      key = keys.detect { |key| attr.keys.include?(key) } or raise "Key not found for #{base_class}"
      base_class #Avoir STI bugs
      klass   = attr['type'] ? attr.delete('type').constantize : base_class

      instance = klass.send("find_or_initialize_by_#{key}", attr[key])
      if instance.new_record? or options[:override]
        instance.send(:attributes=, attr)
      end
      instance
    end.flatten.compact

  end
end
