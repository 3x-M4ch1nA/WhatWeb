##
# This file is part of WhatWeb and may be subject to
# redistribution and commercial restrictions. Please see the WhatWeb
# web site for more information on licensing and terms of use.
# http://www.morningstarsecurity.com/research/whatweb
##
# Version 0.2 # 2011-06-11
# Added account detection
##
Plugin.define "Polycom-SoundPoint" do
author "Brendan Coles <bcoles@gmail.com>" # 2011-03-14
version "0.2"
description "Polycom SoundPoint VOIP phone - Homepage: http://www.polycom.com/products/voice/desktop_solutions/soundpoint/"

# ShodanHQ results as at 2011-03-14 #
# 6,474 for Polycom SoundPoint IP Telephone HTTPd

# Google results as at 2011-06-11 #
# 4 for "SoundPoint IP Configuration" intitle:"SoundPoint IP Configuration Utility - Registration" ext:htm

# Dorks #
dorks [
'"SoundPoint IP Configuration" intitle:"SoundPoint IP Configuration Utility - Registration" ext:htm'
]

# Examples #
examples %w|
207.228.51.194
72.244.162.86
75.186.59.227
81.0.197.178
142.58.0.212
66.37.236.211
24.238.7.127
27.1.25.6
148.210.125.59
|

# Passive #
def passive
	m=[]

	# HTTP Server Header
	if @headers["server"] =~ /^Polycom SoundPoint IP Telephone HTTPd$/

		m << { :name=>"HTTP Server Header" }

		# Display Name
		m << { :url=>"/reg_1.htm", :string=>@body.scan(/<td width="200" bgcolor="#999999"><input value="([^"]+)" name="reg\.1\.displayName"\/><\/td>/) } if @body =~ /<td width="200" bgcolor="#999999"><input value="([^"]+)" name="reg\.1\.displayName"\/><\/td>/

		# Account Detection
		if @body =~ /<td width="200" bgcolor="#999999"><input value="([^"]+)" name="reg\.1\.auth\.userId"\/><\/td>/ and @body =~ /<td width="200" bgcolor="#999999"><input value="([^"]*)" type="password" name="reg\.1\.auth\.password"\/><\/td>/
			m << { :url=>"/reg_1.htm", :account=>@body.scan(/<td width="200" bgcolor="#999999"><input value="([^"]+)" name="reg\.1\.auth\.userId"\/><\/td>/).to_s + ":" + @body.scan(/<td width="200" bgcolor="#999999"><input value="([^"]*)" type="password" name="reg\.1\.auth\.password"\/><\/td>/).to_s }

		end

	end

	# Return passive matches
	m
end

end

