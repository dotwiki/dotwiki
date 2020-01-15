namespace :assets do
  task :precompile do
    sh 'NODE_ENV=production npx webpack'
  end
end