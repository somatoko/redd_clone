namespace :multisearch do
  desc 'Keep your text search up to date'
  
  task update: :environment do
    MultisearchUpdateJob.perform_later
  end
end
