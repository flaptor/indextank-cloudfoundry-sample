require 'rubygems'
require 'sinatra'
require 'indextank'
require 'yajl'

before do
    @docid = "seamonkey#{rand(1122334455)}"

    # grab IndexTank credentials from ENV
    @js = Yajl::Parser.parse ENV['VCAP_SERVICES']
    if @js and @js['indextank-1.0'] then
        # grab 0, assuming you have just one provisioned instance of indextank-1.0 .. 
        creds = @js['indextank-1.0'][0]['credentials']
        @itc = IndexTank::Client.new(creds['INDEXTANK_PRIVATE_API_URL'])

        # and assume you have just one index.
        @index = @itc.indexes(creds["INDEXTANK_INDEX_NAMES"][0])
    end
end


after do
    if @index then
        begin
            @index.document(@docid).delete()
        rescue e
            # could not delete the document .. too bad.
            p e
        end
    end
end


get '/' do
    if @index then
        
        # add a document
        d = @index.document(@docid)
        d.add({:text => "some random text .. #{@docid}"})

        # search it
        docs = @index.search("random #{@docid}")
        
        # did we find it? 
        if docs['results'].length == 1 then
            # success!
            "<h1>This is an IndexTank-powered Cloud Foundry App. </h1> <h2>it just created, searched and deleted #{@docid}</h2>"
        else
            # fail
            [ 500, "something went wrong .. the document is not indexed .. " ]
        end
    else
        # fail
        [500, "NO IndexTank provisioned ...  #{ENV['VCAP_SERVICES']}"]
    end
end
