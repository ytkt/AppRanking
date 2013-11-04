desc "This task is update app ranking"
task :update_ranking => :environment do
  puts "Updating ranking..."
  Ranking.update_ranking
  puts "done."
end
