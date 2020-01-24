$:.unshift(File.expand_path('../lib', File.dirname(__FILE__)))
$:.unshift(File.expand_path('../spec', File.dirname(__FILE__)))

require 'spec_helper'
require 'bitmap'
require 'bitmap_editor'


describe Bitmap do
  context "when testing the bitmap class" do
    
    #it "creates a new bitmap with a canvas in white" do
    #  expect {Bitmap.new()}.to raise_error(ArgumentError,"wrong number of arguments (given 0, expected 2)")
    #end

    #it "raise an error if the coordinates are out of the limits" do
    #  bitmap = Bitmap.new(2, 3)
    #  expect {bitmap.paint!(5,5,'R')}.to raise_error(ArgumentError,"invalid column")
    #end
    
    #it ".draw_vertical! raise an error when the column or rows are out of bounds" do
    #  bitmap = Bitmap.new(2, 3)
    #  expect {bitmap.draw_vertical!(5,1,1,'R')}.to raise_error(ArgumentError,"invalid column")
    #end
    
     #it ".draw_vertical! raise an error when the the segment described is empty" do
     # bitmap = Bitmap.new(5,5)
     # expect {bitmap.draw_vertical!(1,4,2,'R')}.to raise_error(ArgumentError,"invalid segment")
    #end
     
    #it ".draw_horizontal! raise an error when the column or rows are out of bounds" do
    #  bitmap = Bitmap.new(2, 3)
    #  expect {bitmap.draw_horizontal!(1,1,5,'R')}.to raise_error(ArgumentError,"invalid row")
    #end
    
    #it ".draw_horizontal! raise an error when the the segment described is empty" do
    #  bitmap = Bitmap.new(5,5)
    #  expect {bitmap.draw_horizontal!(4,1,2,'R')}.to raise_error(ArgumentError,"invalid segment")
    #end   
    
  end
end  

describe BitmapEditor do
  context "when testing the bitmap_editor class" do
    
    #it "creates a new bitmap with invalid args" do
    #  expect {BitmapEditor.new.run_command!("A",["320","3","A"])}.to raise_error(ArgumentError,"Integer '320' out of bounds")
    #end
    
    it "run file should raise invalid file " do
      @editor = BitmapEditor.new
      expect {@editor.run()}.to raise_error(ArgumentError,/wrong number of arguments/i)
    end
    
    it ".run_command should raise wrong number of arguments " do
      @editor = BitmapEditor.new
      expect {@editor.run_command!('I',[])}.to raise_error(ArgumentError,/Wrong number of arguments for command/)
    end
    
    it "should create a bitmap obj" do
      @editor = BitmapEditor.new
      @editor.run_command!('I', ['3', '3'])
      @n =  @editor.instance_variable_get(:@bitmap)
      expect(@n).to be_a(Bitmap)
    end  
    
  end
end