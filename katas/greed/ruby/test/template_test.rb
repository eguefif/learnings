require 'minitest/autorun'
require_relative '../lib/template'

class TemplateTest < Minitest::Test
  def test_template_method
    assert_equal 0, Template.template
  end
end
