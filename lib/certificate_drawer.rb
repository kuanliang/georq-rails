class CertificateDrawer
	def self.draw(certificate)
	  pdf = PDF::Writer.new
	  |
	    pdf.text test
	
	 # pdf.render
	end
end