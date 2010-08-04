

class Seeds

  DEFAULT_KEY_NAMES = ['id', 'key', 'constant_name','short','name']

  PATH = File.join(RAILS_ROOT,'db','seeds')
  
  attr_accessor :keys, :files, :data

  def initialize(options={})
    @keys = options.symbolize_keys![:keys] ? options.delete(:keys).map(&:to_s) : DEFAULT_KEY_NAMES
    load_files(options)
    self
  end

  #Instanciate all the seeds corresponding to the targeted files
  def load_data(options={})
    @data = @files.collect do |seeds_file|
      seeds_file.instanciate_data(@keys, :override => options[:override])      
    end.flatten.compact
  end


  #save the loaded data
  def save
    @data.map(&:save)
  end

  #save! the loaded data
  def save!
    @data.map(&:save!)
  end


  def load_files(options={})
    if options.symbolize_keys![:only]
      file_paths = self.class.all_file_paths.delete_if{|basename, file_path| not [options[:only]].flatten.map(&:to_s).include?(basename)}
    elsif options[:except]
      file_paths = self.class.all_file_paths.delete_if{|basename, file_path| [options[:except]].flatten.map(&:to_s).include?(basename)}
    else
      file_paths = self.class.all_file_paths
    end
    @files = file_paths.values.collect{ |file_path| SeedsFile.open(file_path) }
  end

  def self.file_paths_from_directory(directory_name)
    Dir.glob(File.join(PATH, directory_name.to_s,'*.yml')).inject({}) do |sum, file_path|
      basename = File.basename(file_path,'.yml')
      sum.update(basename => file_path)
    end
  end

  #Return an array of yaml files
  def self.all_file_paths
    file_paths_from_directory(RAILS_ENV).inject(file_paths_from_directory('common')) do |sum, value|
      sum.update(value.first => value.last)
    end
  end


end

