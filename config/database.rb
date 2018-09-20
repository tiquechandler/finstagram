configure do
  # Log queries to STDOUT in development
 if Sinatra::Application.development?
  set :database, {
  adapter: "sqlite3",
  database: "db/db.sqlite3"
  }
else
  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://bvtayxncvlnxhg:1c70e408c36a77a198bff087d7454765d52d595a72f705c88eac504e3801c00e@ec2-54-83-27-165.compute-1.amazonaws.com:5432/d6s2qq743catmk')
  set :database, {
  adapter: "postgresql",
  host: db.host,
  username: db.user,
  password: db.password,
  database: db.path[1..-1],
  encoding: "utf8"
  }
end

  # Load all models from app/models, using autoload instead of require
  # See http://www.rubyinside.com/ruby-techniques-revealed-autoload-1652.html
  Dir[APP_ROOT.join('app', 'models', '*.rb')].each do |model_file|
    filename = File.basename(model_file).gsub('.rb', '')
    autoload ActiveSupport::Inflector.camelize(filename), model_file
  end

end