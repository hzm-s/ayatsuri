# Ayatsuri

Automation for Ruby

## Description

Ayatsuri is small framework to automate a Windows application.

## requirement

[AutoItX3](http://www.autoitscript.com/site/autoit/)

## Synopsis
    require 'ayatsuri'
    
    class SmartOperator < Ayatsuri::Operator
      
      def init
        # init to operate
        # you can access given arguments like this
        #   params[:arg1] #=> foo
        #   params[:arg2] #=> bar
        #   params[:arg3] #=> baz
      end

      def main
        # very complex operation
      end

      def confirm
        # optional operation
        # wait just 5sec in this case
      end
    end

    class SomeApp < Ayatsuri::Application
      ayatsuri_for "c:/Program Files/someapp.exe"
      
      define_operation_order SmartOperator do
        operate(:init) { active_window.title =~ /init window$/ }
        operate(:main) { active_window.title =~ /^Some App/ }
        operate(:confrim, 5) { active_window.text =~ /Do you .+ \?/ }
        operate(:complete) { active_window.title =~ /^Some App/ }
      end

      def some_operate(foo, bar, baz)
        run arg1: foo,
            arg2: bar,
            arg3, baz
      end
    end