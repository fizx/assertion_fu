task :default => :test

task :test do
  require "test/assertion_fu_test"
end

task :install
  system "gem build assertion_fu.gemspec"
  system "gem install assertion_fu"
end