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
	    entry1.save()
	    @testvar = "Hello, Rails!"
	    
	    show()
	end
	
	# render all entry objects
	def show
	    #array to hold enry objects
	    @entryArray = Array.new
	    #get all records
	    client = Mysql2::Client.new(:host => 'localhost', :username => 'budget', :password => 'torisbudget', :database => 'budget_test')
	    query = "SELECT * FROM entry"
	    result = client.query(query)
	    #loop over the results, create entry objects and place in array
	    result.each do |row|
		@entryArray.push(Entry.new(row.fetch('title'), row.fetch('category'), row.fetch('amount'), row.fetch('note'), row.fetch('type')))
	    end
	#    #write to file for testing
	#    #@entryArray.each do |item|
	#	f = File.open('itemout.txt', 'a')
	#	f.write(item.print())
	#	f.write('\n')
	#	f.close()
	#    end		


	    #render the array
	    render(:action => 'show')
	end
end
class Entry
    def initialize(ti, ty, am, no, cd)
        @title = ti
        @cat = ty
        @amount = am.to_i
        @notes = no
	@credeb = cd
    end
    def save()
	client = Mysql2::Client.new(:host => 'localhost', :username => 'budget', :password => 'torisbudget', :database => 'budget_test')
    	query = "INSERT INTO entry VALUES('#@title', '#@cat', '#@amount', '#@credeb', '#@notes');"
	client.query(query)
	client.close
    end
    def print()
	@rtn = ""
	@rtn += "Title: "
	@rtn += @title
	@rtn += " | "
	@rtn += "Category: "
	@rtn += @cat
	@rtn += " | "
	@rtn += "Amount: "
	@rtn += @amount.to_s
	@rtn += " | "
	@rtn += "Type: "
	@rtn += @credeb
	@rtn += " | "
	@rtn += "Notes: "
	@rtn += @notes

	return @rtn.html_safe
    end
    def testMethod()
	t1 = "Test string for render"
	return t1.html_safe
    end

end
