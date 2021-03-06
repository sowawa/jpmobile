# -*- coding: utf-8 -*-
require 'stringio'
require 'nkf'
require File.join(File.expand_path(File.dirname(__FILE__)), 'spec_helper')

describe Jpmobile::Util, ".deep_apply" do
  it 'nilのときはnilを返すこと' do
    Jpmobile::Util.deep_apply(nil) {|obj| obj }.should equal(nil)
  end

  it 'trueのときはtrueを返すこと' do
    Jpmobile::Util.deep_apply(true) {|obj| obj }.should equal(true)
  end

  it 'falseのときはそのまま値を返すこと' do
    Jpmobile::Util.deep_apply(false) {|obj| obj }.should equal(false)
  end

  it 'Tempfileのインスタンスのときはそのまま値を返すこと' do
    temp = Tempfile.new('test')
    Jpmobile::Util.deep_apply(temp) {|obj| obj}.object_id.should equal(temp.object_id)
    # 本来 Jpmobile::Util.deep_apply(temp) {|obj| obj }.should equal(temp) が通るべきのような。
    # 参考 http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-list/41720
  end

  it 'StringIOのインスタンスのときはそのまま値を返すこと' do
    string_io = StringIO.new('test')
    Jpmobile::Util.deep_apply(string_io) {|obj| obj }.should equal(string_io)
  end

  it "utf8_to_sjis で改行コードが CRLF に変更されること" do
    Jpmobile::Util.utf8_to_sjis("UTF8\nTEXT\n").should == Jpmobile::Util.sjis("UTF8\r\nTEXT\r\n")
  end
end
