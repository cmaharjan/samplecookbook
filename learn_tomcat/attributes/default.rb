#installation
default['tomcat']['remote_file'] = '/opt/learn_tomcat_helloworld/webapps/sample.war'
default['tomcat']['server_file'] = '/opt/learn_tomcat_helloworld/conf/server.xml'
default['tomcat']['catalina_file'] = '/opt/learn_tomcat_helloworld/bin/setevn.sh'
default['tomcat']['tomcat_package'] = 'http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.47/bin/apache-tomcat-8.0.47.tar.gz'
default['tomcat']['source_file'] = 'https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/sample.war'

#O.S related settings
default['tomcat']['group_name'] = 'cool_group'
default['tomcat']['user_name'] = 'cool_user'

#configuration
default['tomcat']['java-opts'] = 'Xms128m -Xmx512m'
default['tomcat']['port'] = '8081'
