module Aux
	def scheme_check
		Regexp.new('\Ahttp:\/\/|\Ahttps:\/\/', Regexp::IGNORECASE)
	end

	def char_set
		('a'..'z').to_a + ('A'..'Z').to_a + (0..9).to_a
	end

	# ensure the url starts with it protocol and is normalized
	def clean_url(url)
	    url = url.to_s.strip
	    if url !~ scheme_check && url[0] != '/'
	      url = "/#{url}"
	    end
	    URI.parse(url).normalize.to_s
    end

 	def url_key_candidate(len = 5)
	    (0...len).map{ char_set[rand(char_set.size)] }.join
	end
end