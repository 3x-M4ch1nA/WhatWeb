##
# This file is part of WhatWeb and may be subject to
# redistribution and commercial restrictions. Please see the WhatWeb
# web site for more information on licensing and terms of use.
# http://www.morningstarsecurity.com/research/whatweb
##
Plugin.define "LANCOM-Device" do
author "Brendan Coles <bcoles@gmail.com>" # 2011-06-02
version "0.1"
description "LANCOM Systems is a provider of innovative and reliable communications solutions, Secure Access, VPN and Wireless LAN with high technological capabilities, easy configuration and unified control of all products. - Homepage: http://www.lancom-systems.nl/"

# ShodanHQ results as at 2011-06-02 #
# 32,344 for LANCOM

# Examples #
examples %w|
212.108.43.65
217.92.219.241
62.227.71.192
217.140.72.103
217.89.42.186
79.187.243.194
217.92.214.213
213.187.77.184
|

# Passive #
def passive
	m=[]

	# HTTP Server Header
	if @headers["server"] =~ /^LANCOM [^\s]+ .+ [\d\.]+ \/ [\d]{2}\.[\d]{2}\.[\d]{4}$/

		# Version Detection
		m << { :version=>@headers["server"].scan(/^LANCOM [^\s]+ .+ ([\d\.]+) \/ [\d]{2}\.[\d]{2}\.[\d]{4}$/) }

		# Model Detection
		m << { :model=>@headers["server"].scan(/^LANCOM ([^\s]+) .+ [\d\.]+ \/ [\d]{2}\.[\d]{2}\.[\d]{4}$/) }

		# Device Detection (Wireless Router, VPN, VoIPm etc)
		m << { :string=>@headers["server"].scan(/^LANCOM [^\s]+ (.+) [\d\.]+ \/ [\d]{2}\.[\d]{2}\.[\d]{4}$/) }

	end

	# Return passive matches
	m
end

end

