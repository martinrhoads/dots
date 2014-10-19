#!/usr/bin/env ruby 

require 'json'

def help
  <<EOH
usage: get_sha.rb owner project branch
EOH
end

def run(cmd='true')
  STDERR.puts "about to run '#{cmd}'"
  res=`#{cmd}`
  unless $?.success?
    STDERR.puts "command: '#{cmd}' failed with"
    STDERR.puts res
    exit 1
  end
  return res
end


repo_owner = ARGV[0]
project = ARGV[1]
branch = ARGV[2]
expected_sha = ARGV[3]

unless repo_owner and project and branch and expected_sha
  STDERR.puts help
  raise
end



json = run "curl https://api.github.com/repos/#{repo_owner}/#{project}/branches/#{branch}"

hash = JSON.parse json
sha = hash['commit']['sha']

if sha == expected_sha
  puts "sha is #{sha}"
else 
  puts "sha #{sha} found but expecting #{expected_sha}"
  exit 1
end
