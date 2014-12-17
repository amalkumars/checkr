# -*- encoding: utf-8 -*-
module Checkr
  class Report < Checkr::Base
    def self.url_name
      'reports'
    end
    
    def self.create(params={})
      if valid?(params)
        response = self.post("/#{self.url_name}", :body => params, :basic_auth => Checkr.auth )
        handle_response(response)
      end
    end

    def self.find(id)
      response = self.get("/reports/#{id}", :basic_auth => Checkr.auth )
      handle_response(response)
    end

    def self.construct(params)
      records = params["records"]
 	    report = self.new(params.except_key('records'))
 	    report.records = []
 	    unless records.nil? || records.empty?
 	      records.each do |record_attributes|
 	        report.records << Checkr::ReportRecord.construct(record_attributes)
 	      end
 	    end

 	    return report
    end

    protected

    def self.valid?(params)
      return true #TODO implement validation
    end
  end
end
