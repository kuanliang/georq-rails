class FileWithBom < File
  #useage File.open("file_utf8_1.csv", "w:utf-8"){|f| f << csv_str }
  BOM = {
    Encoding::UTF_8    => "\xEF\xBB\xBF"    ,
    Encoding::UTF_16BE => "\xFE\xFF"        ,
    Encoding::UTF_16LE => "\xFF\xFE"        ,
    Encoding::UTF_32BE => "\x00\x00\xFE\xFF",
    Encoding::UTF_32LE => "\xFE\xFF\x00\x00"
  }
  def utf_bom_hex(encoding = external_encoding )
    BOM[encoding].force_encoding(encoding)
  end
  class << self
    alias :open_old :open
  end
  def self.open(filename, mode_string = 'w:utf-8', options = {}, &block)
    f = open_old(filename, mode_string, options)
    case mode_string
    when /\Ar/
      f.rewind if f.read(f.utf_bom_hex.bytesize) != f.utf_bom_hex
    when /\Aw/
      f << f.utf_bom_hex
    end
    if block_given?
      yield f
      f.close
    end
  end
end