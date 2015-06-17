def create_liferay_app(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:liferay_app, :create, resource_name)
end
