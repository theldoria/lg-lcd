#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'fileutils'

task :msbuild do
   msbuild = File.join(ENV['windir'], 'Microsoft.NET', 'Framework', 'v4.0.30319', 'MSBuild.exe')
   raise "#{msbuild} not found" unless File.exists?(msbuild)
   sh "#{msbuild} ext/LgLcdDll/LgLcdDll.sln /t:Build /p:Configuration=Release"
   FileUtils.cp("ext/LgLcdDll/Release/LgLcdDll.dll", "ext/LgLcdDll.dll")
end

task :build => :msbuild
task :install => :msbuild
task :release => :msbuild
