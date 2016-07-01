desc 'Starts mysql db server'
task :mysql do
  exec 'mysql-ctl', 'start'
end

desc 'Starts elasticsearch server'
task :el do
  exec 'sudo', 'service', 'elasticsearch', 'start'
end

