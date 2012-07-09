class McmsBlogGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)
  
  
  # @Params     : None
  # @Returns    : None
  # @Purpose    : To Copy asset_manager from engine to app
  def copy_asset_manager

    #copy file lib/asset_manager.rb to app/lib/asset_manager.rb if it doesn't exists
    copy_file "asset_manager.rb", "lib/asset_manager.rb" unless File.exists?(File.join(destination_root, 'lib', 'asset_manager.rb'))


  end

  # @Params     : None
  # @Returns    : None
  # @Purpose    : To Copy all the migrations from db/migrate of engine to db/migrate of application
  def add_migrations

    say "copying migrations......."

    # running command line command to copy engine's migration file
    rake("mcms_blog_engine:install:migrations")

  end # end method
  
end
