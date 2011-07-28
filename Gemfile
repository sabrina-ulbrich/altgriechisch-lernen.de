require File.expand_path('../lib/bundler/repository', __FILE__)

source :rubygems

workspace '. ~/.projects ~/projects ~/.repositories ~/Development/{projects,work}'
developer :sven, :prefer => :local

repository = repository('adva-cms2', :git => 'git@github.com:svenfuchs/adva-cms2.git', :ref => 'dc399bd5f')
repository.gem 'adva-cms2'
