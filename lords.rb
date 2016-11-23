require 'win32/screenshot'
require "rautomation"



class LordBot
  attr_accessor :win, :win_name, :win_left, :win_top, :win_width, :win_height

  SCREENSHOT_FILENAME = "screen.bmp"

  def attach window_name
    @win_name = window_name
    @win = RAutomation::Window.new(:title => @win_name)
    unless @win.exists?
      puts("Window named #{@win_name} is NOT exists!") and return false
    end
    coords = @win.dimensions
    @win_left = coords[:left]
    @win_top = coords[:top]
    @win_width = coords[:width]
    @win_height = coords[:height]
    return true
  end

  def makeScreenShot
    Win32::Screenshot::Take.of(:window, title: @win_name).write(SCREENSHOT_FILENAME)
  end
  
  def click x, y
    rel_x = @win_left + x
    rel_y = @win_top + y
    mouse = @win.mouse
    mouse.move :x => rel_x, :y => rel_y
    mouse.click
  end

  def printWinInfo
    puts "---- win #{@win_name} information:"
    puts "left: #{@win_left}"
    puts "top: #{@win_top}"
    puts "width: #{@win_width}"
    puts "height: #{@win_height}"
    puts "---- finish information ----"

  end

end



bot = LordBot.new
exit unless bot.attach /Droid4X/
bot.click 200, 200
bot.makeScreenShot
bot.printWinInfo
