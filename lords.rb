# coding: utf-8

#
#   OY_BRO 2016
#

require 'win32/screenshot'
require "rautomation"
require_relative "ui_mapper"

# require 'dl'
# require 'dl/import'
# BUTTONS_OK = 0
# BUTTONS_OKCANCEL = 1
# BUTTONS_ABORTRETRYIGNORE = 2
# BUTTONS_YESNO = 4
# require "Win32API"
# def msg_box text, title
#   api = Win32API.new('user32', 'MessageBox',['L', 'P', 'P', 'L'],'I')
#   api.call(0, text, title, BUTTONS_OK)
# end



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
    Win32::Screenshot::Take.of(:window, title: @win_name).write!(SCREENSHOT_FILENAME)
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

class UI_Navigator
  attr_accessor :bot

  def initialize bot
    @bot = bot
  end

  # close logo screen
  def logo_pass
    btn_coords = UI_Mapper::BuyLogoPage.CloseBtnCoords
    @bot.click btn_coords[:left], btn_coords[:top]
  end
end

##################################

bot = LordBot.new
exit unless bot.attach /Droid4X/
bot.click 200, 200
bot.makeScreenShot
bot.printWinInfo

ui = UI_Navigator.new(bot)
ui.logo_pass

#################################