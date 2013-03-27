class AddAnyConfigurationToBundles < ActiveRecord::Migration
  def change
    change_column :supported_configurations, :configuration_id, :integer, :null => true

    Bundle.find_each do |b|
      b.supported_configurations.create! :configuration_id=>nil unless b.supported_configurations.any?
    end
  end
end
