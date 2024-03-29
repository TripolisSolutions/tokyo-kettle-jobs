set :gem_name, 'tokyo-kettle-jobs'
set :deploy_to, File.join('', 'home', 'gems', fetch(:gem_name))
set :gems_server_dir, File.join('', 'srv', 'gems-server')
set :rvm_type, :user
server 'gems.int.sg.tripolis.vn', user: 'gems', roles: %w{gems}


namespace :gem do
  task :deploy do
    on roles(:gems) do
      within current_path do
        execute :rm, '-f', '*.gem'
        execute :gem, 'build', "#{fetch(:gem_name)}.gemspec"
        execute :cp, '-rf', '*.gem', File.join(fetch(:gems_server_dir), 'gems', '')
        execute :gem, 'generate_index', '-d', fetch(:gems_server_dir)
        gem_path = File.join(fetch(:gems_server_dir), 'gems', "$(ls #{fetch(:gem_name)}-*.gem)")
        execute :gem, 'inabox', gem_path, '--host http://127.0.0.1:8807', '-o'
      end
    end
  end
end

after 'deploy:published', 'gem:deploy'
