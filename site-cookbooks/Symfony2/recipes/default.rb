#
# Cookbook Name:: Symfony2
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

execute "disable-default-site" do
  command "a2dissite default"
end

web_app "symfony" do
  application_name "symfony-app"
  docroot "/vagrant/web"
end

execute "install-vendors" do
  command "php /vagrant/bin/vendors install --env=vagrant_dev"
end

execute "link-resources" do
  command "php /vagrant/app/console --env=vagrant_dev assets:install /vagrant/web --symlink"
end

execute "clear-cache" do
  command "php /vagrant/app/console --env=vagrant_dev cache:clear"
end

execute "warm-up-cache" do
  command "php /vagrant/app/console --env=vagrant_dev cache:warmup"
end

execute "drop database" do
  command "mysql --password=root -u root -e 'drop database symfony2'; > /dev/null 2> /dev/null"
end

execute "create database" do
      command "mysql --password=root -u root -e 'create database symfony2'; > /dev/null 2> /dev/null"
end

#execute "copy database" do
#  command "mysql --password=root -u root adatabase < /vagrant/adatabase.sql"
#end

execute "migrations" do
    command "php /vagrant/app/console --env=vagrant_dev --no-interaction doctrine:migrations:migrate"
end


