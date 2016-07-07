class Form < ActiveRecord::Base


	has_attached_file :file#,
	    # :styles => { :small =>"50x50",:medium => "300x300>", :thumb => "100x100>" },
    	#:default_url => "/images/:style/missing.png"
	 					#:path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"
	 do_not_validate_attachment_file_type :file
	 Paperclip.options[:content_type_mappings]
end
