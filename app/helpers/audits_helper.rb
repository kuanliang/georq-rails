module AuditsHelper

	def setup_audit(audit)
	    audit.build_certificate unless audit.certificate
	    audit
	end

end
