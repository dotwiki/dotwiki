namespace :assets do
  task :precompile do
    sh 'NODE_ENV=production yarn run webpack'
  end
end