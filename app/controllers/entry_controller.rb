class EntryController < ApplicationController
	def new
	end
 	def create
	    @params = Array.new
	    @newStr = ""
	    #render plain: params[:entry].inspect
	    @params = params[:entry]
	    #render plain: @params['amount']
	    
	    entry1 = Entry.new(@params['title'], @params['category'], @params['amount'], @params['note'], @params['type_id'])
	    entry1.commit()
	    render plain: entry1.print()
	    #render plain: "Hello, Rails"
	end
end
class Entry
    def initialize(ti, ty, am, no, cd)
        @title = ti
        @cat = ty
        @amount = am
        @notes = no
	@credeb = cd
    end
    def commit()
	client = Mysql2::Client.new(:host => 'localhost', :username => 'budget', :password => 'password', :database => 'budget_test')
    	query = "INSERT INTO entry VALUES('#@title', '#@cat', '#@amount', '#@credeb', '#@notes');"
	client.query(query)
    end
    def print()
	rtn = ""
	rtn += "Title: "
	rtn += @title
	rtn += "\n"
	rtn += "Category: "
	rtn += @cat
	rtn += "\n"
	rtn += "Amount: "
	rtn += @amount
	rtn += "\n"
	rtn += "Type: "
	rtn += @credeb
	rtn += "\n"
	rtn += "Notes: "
	rtn += @notes

	return rtn
    end

end
