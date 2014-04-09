require_relative 'spec_helper'

module Stujo
  module CommandLine


    describe Menu do
      describe "#run" do
        context "With No Options" do
          let(:menu) { Menu.new("Press Return!") }
          it "returns a line from stdin" do
            menu.stub(:gets).and_return("\n")
            STDOUT.should_receive(:puts).with("Press Return!")
            menu.run.should == ""
          end
        end
        context "With Text Options" do
          let(:menu) {
            menu = Menu.new("Yes or No")
            menu.add_option("Y")
            menu.add_option("N")
            menu
          }
          it "Returns the matching answer" do
            menu.stub(:gets).and_return("Y")
            STDOUT.should_receive(:puts).with("Yes or No (Y,N)")
            menu.run.should == "Y"
          end
          it "Returns the matching answer" do
            menu.stub(:gets).and_return("N")
            STDOUT.should_receive(:puts).with("Yes or No (Y,N)")
            menu.run.should == "N"
          end
          it "Returns the matching answer after a wrong answer" do
            menu.stub(:gets).and_return("x","N")
            STDOUT.should_receive(:puts).exactly(2).times.with("Yes or No (Y,N)")
            menu.run.should == "N"
          end
        end

        context "With Bloack Options" do
          let(:menu) {
            menu = Menu.new("Yes or No")
            menu.add_option("Y") { |x| "YES #{x}" }
            menu.add_option("N") { |x| "NO #{x}" }
            menu
          }
          it "Returns the matching answer" do
            menu.stub(:gets).and_return("Y")
            STDOUT.should_receive(:puts).with("Yes or No (Y,N)")
            menu.run.should == "YES Y"
          end
          it "Returns the matching answer" do
            menu.stub(:gets).and_return("N")
            STDOUT.should_receive(:puts).with("Yes or No (Y,N)")
            menu.run.should == "NO N"
          end
          it "Returns the matching answer after a wrong answer" do
            menu.stub(:gets).and_return("x","N")
            STDOUT.should_receive(:puts).exactly(2).times.with("Yes or No (Y,N)")
            menu.run.should == "NO N"
          end
        end
      end
    end
  end
end
