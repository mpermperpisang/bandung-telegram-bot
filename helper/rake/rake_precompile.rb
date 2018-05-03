class Precompile
  @@jenkins = BBMJenkins.new

  def perform(bot, id, staging)
    @@jenkins.open_require_ruby(staging, "master", "assets:precompile")
    @@jenkins.deploy_jenkins(bot, id, staging, "rake")
  end
end
