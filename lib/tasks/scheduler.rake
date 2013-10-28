desc "This task is update app ranking"
task :update_feed => :environment do
  puts "Updating ranking..."
  App.update_ranking
  puts "done."
end
