require 'rails_helper'

<% output_attributes = attributes.reject{|attribute| [:datetime, :timestamp, :time, :date].index(attribute.type) } -%>
<% reference_attributes = output_attributes.select{|attribute| attribute.type == :references } -%>
RSpec.describe "<%= ns_table_name %>/index", <%= type_metatag(:view) %> do
  before(:each) do
<% reference_attributes.each do |attribute| -%>
    <%= attribute.name %> = <%= attribute.name.camelize %>.create!
<% end -%>
    assign(:<%= table_name %>, [
<% [1,2].each_with_index do |id, model_index| -%>
      <%= class_name %>.create!(<%= output_attributes.empty? ? (model_index == 1 ? ')' : '),') : '' %>
<% output_attributes.each_with_index do |attribute, attribute_index| -%>
        <%= attribute.name %>: <%= attribute.type == :references ? attribute.name : value_for(attribute) %><%= attribute_index == output_attributes.length - 1 ? '' : ','%>
<% end -%>
<% if !output_attributes.empty? -%>
      <%= model_index == 1 ? ')' : '),' %>
<% end -%>
<% end -%>
    ])
  end

  it "renders a list of <%= ns_table_name %>" do
    render
<% for attribute in output_attributes -%>
<% next if attribute.type == :references -%>
<% if attribute.type == :boolean -%>
    expect(rendered).to match(/Yes|No/)
<% else -%>
    expect(rendered).to include(<%= value_for(attribute) %>.to_s)
<% end -%>
<% end -%>
  end
end
