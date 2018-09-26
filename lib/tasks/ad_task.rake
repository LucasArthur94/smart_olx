namespace :ad do
    desc "TODO"
    task :ad_task => :environment do
        AdWorker.perform
    end
end
