class SliceFile
  def self.readlines(filename, slice_by:, chomp: false)
    File.readlines(filename, chomp: chomp).each_slice(slice_by)
  end
end
