class Reindex
  @@jenkins = BBMJenkins.new

  def perform(bot, id, staging)
    @@jenkins.open_require_ruby(staging, "master", "elasticsearch:reindex_index")
    @@jenkins.deploy_jenkins(bot, id, staging, "rake")
  end
end
