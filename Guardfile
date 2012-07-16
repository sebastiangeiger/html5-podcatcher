# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rspec', :version => 2 do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/domain_model/(.+)\.rb$})     { |m| "spec/domain_model/#{m[1]}_spec.rb" }
  watch(%r{^app/api/(.+)\.rb$})     { |m| "spec/api/#{m[1]}_spec.rb" }
  watch(%r{^app/external/(.+)\.rb$})     { |m| "spec/external/#{m[1]}_spec.rb" }
end

