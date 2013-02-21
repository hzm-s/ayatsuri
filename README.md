# Ayatsuri

Windows app automation that doesn't hurt

## Description

Ayatsuri is small framework to automate a Windows application.

## Requirement

[AutoItX3](http://www.autoitscript.com/site/autoit/)

## Synopsis
    require 'ayatsuri'
    
    class SmartOperator < Ayatsuri::Operator
      
      def init
        # init to operate
        # you can access given arguments like this
        #   params[:foo] #=> arg1
        #   params[:bar] #=> arg2
        #   params[:baz] #=> arg3
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
        operate(:confrim, limit: 5) { active_window.content =~ /Do you .+ \?/ }
        operate(:complete) { active_window.title =~ /^Some App/ }
      end

      def some_operate(arg1, arg2, arg3)
        run foo: arg1
            bar: arg2
            baz: arg3
      end
    end

    app = SomeApp.new
    app.some_operate(:foo, :bar, :baz)
