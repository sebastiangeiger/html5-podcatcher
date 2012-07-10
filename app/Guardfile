# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', :version => 2 do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^domain_model/(.+)\.rb$})     { |m| "spec/domain_model/#{m[1]}_spec.rb" }
  watch(%r{^api/(.+)\.rb$})     { |m| "spec/api/#{m[1]}_spec.rb" }
end

