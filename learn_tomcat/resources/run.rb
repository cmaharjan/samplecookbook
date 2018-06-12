property :state, String
action [:start, :enable] do
  tomcat_user node['tomcat']['user_name']
  tomcat_group node['tomcat']['group_name']
end
