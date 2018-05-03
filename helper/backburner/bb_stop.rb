class Stop
  @@jenkins = BBMJenkins.new

  def perform(bot, id, staging)
    @@jenkins.open_require_ruby(staging, "master", "backburner:stop")
    @@jenkins.deploy_jenkins(bot, id, staging, "deploy")
  end
end
