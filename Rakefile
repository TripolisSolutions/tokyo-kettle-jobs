require "bundler/gem_tasks"

desc "deploy gem"
task deploy: :install do
  base =  Dir.pwd
  spec = Bundler.load_gemspec(Dir[File.join(base, "{,*}.gemspec")].sort_by{|f| File.mtime(f)}.first)
  name = spec.name
  version = spec.version
  source_file = File.join(base, "pkg", "#{name}-#{version}.gem")

  target_dir = ENV["GEMS_DIR"] || "#{ENV['HOME']}/gem-server"
  gems_dir = File.join(target_dir, "gems")
  FileUtils.mkdir_p(gems_dir)
  FileUtils.cp(source_file, gems_dir)

  Dir.chdir target_dir do
    sh "unset RUBYOPT; gem generate_index"
  end
end