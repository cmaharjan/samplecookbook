property :state, String
action :install do
   tarball_uri node['tomcat']['tomcat_package']
end
