require 'rake'

backups = File.expand_path('backup', File.dirname(__FILE__))


desc "Hook our dotfiles into system-standard positions."
task :install do

  linkables = Dir.glob('src/*/**{.symlink}')
  linkables += Dir.glob('local/*/**{.symlink}')
  backup_location = File.expand_path('backup', File.dirname(__FILE__))

  skip_all = false
  overwrite_all = false
  backup_all = false

  linkables.each do |linkable|

    overwrite = false
    backup = false

    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"

    if File.exists?(target) || File.symlink?(target)

      unless skip_all || overwrite_all || backup_all
        puts "File already exists: #{target}, what do you want to do? [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all"
        case STDIN.gets.chomp
        when 'o' then overwrite = true
        when 'b' then backup = true
        when 'O' then overwrite_all = true
        when 'B' then backup_all = true
        when 'S' then skip_all = true
        when 's' then next
        end
      end

      FileUtils.rm_rf(target) if overwrite || overwrite_all
      `mv "$HOME/.#{file}" "#{backups}/.#{file}"` if backup || backup_all

    end

    `ln -s "$PWD/#{linkable}" "#{target}"`

  end
  puts 'Dotfiles installed.'

end


task :uninstall do

  linkables = Dir.glob('src/*/**{.symlink}')
  linkables += Dir.glob('local/*/**{.symlink}')

  linkables.each do |linkable|

    file = linkable.split('/').last.split('.symlink').last
    target = "#{ENV["HOME"]}/.#{file}"

    # Remove all symlinks created during installation
    if File.symlink?(target)
      FileUtils.rm(target)
    end

    # Replace any backups made during installation
    if File.exists?("#{backups}/.#{file}")
      `mv "#{backups}/.#{file}" "$HOME/.#{file}"`
    end

  end
  puts 'Dotfiles uninstalled.'

end


task :default => 'install'
