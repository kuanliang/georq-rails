# Be sure to restart your server when you modify this file.
require 'pdf/writer'
# Add new mime types for use in respond_to blocks:
# Mime::Type.register "text/richtext", :rtf
Mime::Type.register "application/pdf", :pdf
Mime::Type.register "application/csv", :csv
Mime::Type.register "application/csv", :xls