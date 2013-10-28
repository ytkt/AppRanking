desc "This task is update app ranking"
task :update_ranking => :environment do
  puts "Updating ranking..."
  App.update_ranking
  puts "done."
end
