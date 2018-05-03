require './helper/bbm_jenkins.rb'

class Start
  @@jenkins = BBMJenkins.new

  def perform(bot, id, staging)
    @@jenkins.open_require_ruby(staging, "master", "backburner:start")
    @@jenkins.deploy_jenkins(bot, id, staging, "deploy")
  end
end
