# encoding: utf-8
class VersionInput < SimpleForm::Inputs::StringInput
  def input
    value = object.send(attribute_name) if object.respond_to? attribute_name
    input_html_options[:value] = value
    #input_html_classes << "datepicker"
    super
  end

  def input_type
    :string
  end
end
