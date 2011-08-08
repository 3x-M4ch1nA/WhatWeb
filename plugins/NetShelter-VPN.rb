##
# This file is part of WhatWeb and may be subject to
# redistribution and commercial restrictions. Please see the WhatWeb
# web site for more information on licensing and terms of use.
# http://www.morningstarsecurity.com/research/whatweb
##
Plugin.define "NetShelter-VPN" do
author "Brendan Coles <bcoles@gmail.com>" # 2011-03-07
version "0.1"
description "Fujitsu NetShelter/VPN [Japanese] - an IPSec-compliant VPN device with 56-bit DES encryption. - Manual: http://fenics.fujitsu.com/products/downloads/products/material/lan0104/lc0104_netshelter.pdf"

# ShodanHQ results as at 2011-03-07 #
# 2 for NetShelter

# Examples #
examples %w|
211.10.78.132
210.188.186.211
|

# Matches #
matches [

# Title
{ :text=>"<HEAD><TITLE>Welcome to NetShelter</TITLE></HEAD>" },

# Logo
{ :url=>"/images/sb_logo.gif", :md5=>"ffacfeae7e203bd8de5c9da889d217ec" },

]

# Passive #
def passive
	m=[]

	# HTTP Server Header
	m << { :name=>"HTTP Server Header" } if @headers["server"] =~ /^NetShelter\/VPN$/
	# Return passive matches
	m
end

end


