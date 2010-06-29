class ActsAsTaggableOnMigrationGenerator < Rails::Generator::Base 
  def use_string_ids?
    if (args.grep /string_ids/).empty?
      use_string_ids = false
      puts "
PS: if you are integrating with tables with non-integer primary keys, you might want to do:
  script/generate sanction string_ids=true
instead.
"
    else
      puts "
Setting taggable_id and tagger_id to \":string, :limit => 40\", 
don't forget to increase the limit if you need to to accomodate yer data" 
      use_string_ids = true        
    end
  end
  def manifest 
    record do |m| 
      use_string_ids = use_string_ids?
      
      m.migration_template 'migration.rb', 
        'db/migrate', 
        :migration_file_name => "acts_as_taggable_on_migration",
        :assigns => {:use_string_ids => use_string_ids}
    end
  end
end
