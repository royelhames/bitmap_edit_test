require_relative 'bitmap'

class BitmapEditor
  
  def initialize
    @bitmap = nil
  end

  def run(file)
    unless eval(File.exists?(file.to_s).to_s)
      raise ArgumentError.new("Please provide valid file")
      return
    end

    File.open(file).readlines.map(&:chomp).each do |line|
      begin
        command, *args = line.chomp.split(" ")

        run_command!(command, args)
      rescue ArgumentError => error
        raise ArgumentError.new("#{error.message} (line: #{line})")
        return
      rescue RuntimeError => error
        raise ArgumentError.new("Error parsing the file in line: #{line}" + error.message)
        return
      end
    end

    true
  end

  def run_command!(command, args)
    begin
      validate_args!(args)

      case command
      when 'I'
        fail "Image already created!" if @bitmap
        validate_size(command, args, 2)

        @bitmap = Bitmap.new(*args)
      when 'C'
        validate_bitmap_presence(command)
        validate_size(command, args, 0)

        @bitmap.clear!
      when 'L'
        validate_bitmap_presence(command)
        validate_size(command, args, 3)

        @bitmap.paint!(*args)
      when 'F'
        validate_bitmap_presence(command)
        validate_size(command, args, 3)

        @bitmap.fill!(*args)
      when 'V'
        validate_bitmap_presence(command)
        validate_size(command, args, 4)

        @bitmap.draw_vertical!(*args)
      when 'H'
        validate_bitmap_presence(command)
        validate_size(command, args, 4)

        @bitmap.draw_horizontal!(*args)
      when 'S'
        validate_bitmap_presence(command)
        validate_size(command, args, 0)

        puts @bitmap.inspect
      else
        fail "unrecognised command '#{command}' :("
      end
    rescue ArgumentError => error
        raise ArgumentError.new("#{error.message}")
        return
    end
  end

  private

  def validate_args!(args)
   
    args.map! do |arg|
      if /^[A-Z]$/.match(arg) 
        arg
      elsif /^\d{1,3}$/.match(arg)
        value = Integer(arg)

        if value.between?(1, 250)
          value
        else
          fail ArgumentError.new("Integer '#{value}' out of bounds")
        end
      else
        fail "Parameter unknown: '#{arg}'"
      end
    end
  end

  def validate_bitmap_presence(command)
    fail "Can not execute command '#{command}' if there is no image created first" unless @bitmap
  end

  def validate_size(command, args, n)
    if args.size != n
      fail ArgumentError.new("Wrong number of arguments for command '#{command}' (given #{args.size}, expected #{n})")
    end
  end
end
class BitmapEditorError < StandardError

end
