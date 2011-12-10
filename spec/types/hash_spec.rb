require 'spec_helper'
require 'parameters/types/hash'
require 'parameters/types/symbol'
require 'parameters/types/integer'

describe Parameters::Types::Hash do
  let(:array) { [:a, 1, :b, 2]     }
  let(:hash)  { {:a => 1, :b => 2} }

  describe "coerce" do
    subject { described_class }

    it "should accept Arrays" do
      subject.coerce(array).should == hash
    end

    it "should call #to_hash" do
      subject.coerce(hash).should == hash
    end
  end

  context "instance" do
    context "with key-type" do
      let(:string_keys) { {'a' => 1, 'b' => 2} }

      subject { described_class.new(Parameters::Types::Symbol.new,nil) }

      describe "#===" do
        it "should check the type of each key" do
          subject.should_not === string_keys

          subject.should === hash
        end
      end

      describe "#coerce" do
        it "should coerce each key" do
          subject.coerce(string_keys).should == hash
        end
      end
    end

    context "with value-type" do
      let(:string_values) { {:a => '1', :b => '2'} }

      subject { described_class.new(nil,Parameters::Types::Integer.new) }

      describe "#===" do
        it "should check the type of each value" do
          subject.should_not === string_values

          subject.should === hash
        end
      end

    describe "#coerce" do
        it "should coerce each value" do
          subject.coerce(string_values).should == hash
        end
      end
    end
  end
end