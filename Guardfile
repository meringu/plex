guard :rspec, cmd: 'bundle exec rspec' do
  watch(%r{^(recipes|providers|libraries)/(.*)\.rb}) { |m| p m; "spec/unit/#{m[1]}/#{m[2]}_spec.rb" }
  watch(%r{^spec})
end
