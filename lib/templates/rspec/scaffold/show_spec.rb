require 'rails_helper'

<% output_attributes = attributes.reject{|attribute| [:datetime, :timestamp, :time, :date].index(attribute.type) } -%>
<% reference_attributes = output_attributes.select{|attribute| attribute.type == :references } -%>
RSpec.describe "<%= ns_table_name %>/show", <%= type_metatag(:view) %> do
  before(:each) do
<% reference_attributes.each do |attribute| -%>
    <%= attribute.name %> = <%= attribute.name.camelize %>.create!
<% end -%>
    assign(:<%= singular_table_name %>, <%= class_name %>.create!(<%= '))' if output_attributes.empty? %>
<% output_attributes.each_with_index do |attribute, attribute_index| -%>
      <%= attribute.name %>: <%= attribute.type == :references ? attribute.name : value_for(attribute) %><%= attribute_index == output_attributes.length - 1 ? '' : ','%>
<% end -%>
<% if !output_attributes.empty? -%>
    ))
<% end -%>
  end

  it "renders attributes in <p>" do
    render
<% for attribute in output_attributes -%>
<% next if attribute.type == :references -%>
<% if attribute.type == :boolean -%>
    expect(rendered).to match(/Yes|No/)
<% else -%>
    expect(rendered).to match(/<%= raw_value_for(attribute) %>/)
<% end -%>
<% end -%>
  end
end
