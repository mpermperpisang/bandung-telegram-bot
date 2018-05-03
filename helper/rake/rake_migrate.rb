class Migrate
  @@jenkins = BBMJenkins.new

  def perform(bot, id, staging)
    @@jenkins.open_require_ruby(staging, "master", "db:migrate")
    @@jenkins.deploy_jenkins(bot, id, staging, "rake")
  end
end
